import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:imontrack/screens/objective_feed..dart';

import 'package:intl/intl.dart';
import '../models/ImageData.dart';
import '../models/objective.dart';
import '../helpers/db_helper.dart';
import 'package:http/http.dart' as http;
import '../utils/tools.dart';

class LogProvider with ChangeNotifier {
  List<ImageData> _log_events = [];
  List<Objective> _objectives = [];

  int weekSinceStart = 0;

  List<ImageData> get events {
    return [..._log_events];
  }

  List<Objective> get objectives {
    return [..._objectives];
  }

  int increaseWeek() {
    weekSinceStart++;
  }

  List<ImageData> getImageDataByObjectiveID(String objectiveID) {
    // print(objectiveID);
    var events =
        _log_events.where((element) => element.objectiveID == objectiveID);
    // print(events);
    return [...events.where((element) => element.objectiveID == objectiveID)];
  }

  int getWeekProgressByID(String objectiveID) {
    // The progress so you could mark them with X's
    return getImageDataByObjectiveID(objectiveID).length;
    // You have to count just by the logs. It doesn't matter really anymore easy code.
  }

  List<ImageData> getEventsBYIDMONTH(String objectiveID, int monthPrev) {
    // First get all with objective ID
    var objetiveMonth = getImageDataByObjectiveID(objectiveID);

    // Then you want to add the event id months and compare
    DateTime now = DateTime.now();

    return [
      ...objetiveMonth
          .where((e) => e.dateTime.month == getFixedMonth(now.month, monthPrev))
    ];
  }

  int getFixedMonth(int nowMonth, int prev) {
    return nowMonth - (prev) > 0 ? nowMonth - prev : nowMonth - prev + 12;
  }

  int getMonthlyLogsBYIDMONTH(String objectiveID, int monthPrev) {
    return getEventsBYIDMONTH(objectiveID, monthPrev).length;
  }

  int get eventsCount {
    return _log_events.length;
  }

  int get weeksStreak {
    List<ImageData> sortedByDate = [...events];
    sortedByDate.sort((b, a) => a.dateTime.compareTo(b.dateTime));
    int totalDaysWithouthBreaking = 1, diff;
    DateTime lastDate = Tools.getSimplifiedDate(DateTime.now());

    for (ImageData singleEvent in sortedByDate) {
      DateTime simplifiedDate = Tools.getSimplifiedDate(singleEvent.dateTime);
      diff = lastDate.difference(simplifiedDate).inDays;

      if (diff > 7) {
        break;
      }

      totalDaysWithouthBreaking += diff;
      lastDate = simplifiedDate;
    }

    return (totalDaysWithouthBreaking / 7).floor() + 1;

    return 0;
  }

  int get streaks {
    // You actually have to go from now to the past. This can be done by
    // reducing one into the past and start counting.
    // So the algo would go like this today + n skipped. Then check if any
    // loggin had been created during those times.
    // for each week from the hypothetic until you cant find more.
    bool logFoundDuringThisWeek = true;

    int countStreaks = 0;
    DateTime dateCap = hypotheticToday.add(Duration(days: 0));
    while (logFoundDuringThisWeek) {
      DateTime prevDateCap = dateCap.subtract(Duration(days: 9));
      // for each date check if ONE has the condition.

      logFoundDuringThisWeek = false;
      for (var log in _log_events) {
        // print(log.dateTime);
        if (!logFoundDuringThisWeek &&
            log.dateTime.isBefore(dateCap) &&
            log.dateTime.isAfter(prevDateCap)) {
          // print("Counted");
          countStreaks += 1;
          logFoundDuringThisWeek = true;
        }
      }
      dateCap = dateCap.subtract(Duration(days: 7));
    }
    return countStreaks;
  }

  DateTime get hypotheticToday {
    DateTime now = Tools.getSimplifiedDate(DateTime.now());
    // DateTime.now()
    return now.add(Duration(days: 7 * weekSinceStart));
  }

  int get logUploaded {
    return _log_events.length;
  }

  int get maxStreaks {
    return currentStreak;
  }

  int get currentStreak {
    // You get the streak by counting backwards the items okok probably like sort them first by date, because it is not sorted
    List<ImageData> sortedByDate = [...events];
    sortedByDate.sort((b, a) => a.dateTime.compareTo(b.dateTime));
    // print(_log_events[_log_events.length - 1].dateTime);
    // print(sortedByDate[0].title);
    int streakCounter = 1;
    DateTime lastDate;
    bool firstLoop = true;
    int dateSinceProgress = 1;

    for (ImageData singleEvent in sortedByDate) {
      DateTime simplifiedDate = Tools.getSimplifiedDate(singleEvent.dateTime);
      if (firstLoop) {
        lastDate = simplifiedDate;
        firstLoop = false;
        DateTime previousDate = Tools.getPreviousDate(lastDate);
      }
      DateTime previousDate = Tools.getPreviousDate(lastDate);

      if (!(simplifiedDate == lastDate || simplifiedDate == previousDate)) {
        break;
      }

      if (simplifiedDate == previousDate) {
        lastDate = simplifiedDate;
        DateTime previousDate = Tools.getPreviousDate(lastDate);
        streakCounter++;
      }
    }

    return streakCounter;
  }

  ImageData findById(String id) {
    return _log_events.firstWhere((log) => log.id == id);
  }

  String getObjectiveNameByID(String id) {
    return _objectives.firstWhere((element) => element.id == id).title;
  }

  Objective getLastObjective() {
    return _objectives.last;
  }

  Future<void> addImage(String pickedTitle, File pickedImage, String testDate,
      List<String> selectedTags, String description, String objectiveID) async {
    final newLog = ImageData(
        id: DateTime.now().toString(),
        image: pickedImage,
        title: pickedTitle,
        dateTime: DateTime.parse(testDate),
        tags: selectedTags,
        description: description,
        objectiveID: objectiveID);
    _log_events.add(newLog);
    notifyListeners();
    DBHelper.insert('user_logs', {
      'id': newLog.id,
      'title': newLog.title,
      'image': newLog.image.path,
      'dateTime': newLog.dateTime.toIso8601String(),
      'objectiveID': newLog.objectiveID,
      'description': newLog.description,
      'tags': newLog.tags.join(",")
    });
  }

  Future<void> deleteImage(String id) {
    DBHelper.delete('user_logs', id);
  }

  Future<void> deleteObjective(String id) {
    DBHelper.delete('user_objectives', id);
  }

  Future<void> addObjective(
      String pickedTitle, String pickedDescription) async {
    await updateProjectsData(pickedTitle);
    final newObjective = Objective(
      id: DateTime.now().toString(),
      title: pickedTitle,
      description: pickedDescription,
    );
    _objectives.add(newObjective);
    notifyListeners();
    DBHelper.insert('user_objectives', {
      'id': newObjective.id,
      'title': newObjective.title,
      'description': newObjective.description
    });
  }

  Future<void> fetchAll() async {
    fetchAndSetImages();
    fetchAndSetObjectives();
    return updateGeneralData();
  }

  Future<void> fetchAndSetImages() async {
    final dataList = await DBHelper.getData('user_logs');
    // print("Fetching");
    // print(dataList);
    _log_events = dataList
        .map(
          (item) => ImageData(
              id: item['id'],
              title: item['title'],
              image: File(item['image']),
              description: item['description'],
              dateTime: DateTime.parse(item['dateTime']),
              objectiveID: item['objectiveID'],
              tags: item['tags'] != null ? item['tags'].split(',') : null),
        )
        .toList();
    notifyListeners();
  }

  Future<void> fetchAndSetObjectives() async {
    final dataList = await DBHelper.getData('user_objectives');
    _objectives = dataList
        .map((item) => Objective(
            id: item['id'],
            title: item['title'],
            description: item['description']))
        .toList();
    notifyListeners();
  }

  Future<void> updateGeneralData() async {
    final url = Uri.parse(
        'http://iamontrack.wangnelson.xyz/public/api/post-user-datum');
    print(hypotheticToday.toIso8601String());
    try {
      final response = await http.post(url, body: {
        'lastupdate': hypotheticToday.toIso8601String(),
        'currentstreak': currentStreak.toString()
      });
      print(response);
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProjectsData(String title) async {
    final url =
        Uri.parse('http://iamontrack.wangnelson.xyz/public/api/post-objective');
    // print(hypotheticToday.toIso8601String());
    try {
      final response = await http.post(url, body: {'title': title});
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
