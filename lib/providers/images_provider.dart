import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/ImageData.dart';
import '../helpers/db_helper.dart';
import '../utils/tools.dart';

class LogProvider with ChangeNotifier {
  List<ImageData> _events = [];

  List<ImageData> get events {
    return [..._events];
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

    return (totalDaysWithouthBreaking / 7).floor()+1;

    return 0;
  }

  int get imagesUploaded {
    return _events.length;
  }

  int get maxStreaks {
    return currentStreak;
  }

  int get currentStreak {
    // You get the streak by counting backwards the items okok probably like sort them first by date, because it is not sorted
    List<ImageData> sortedByDate = [...events];
    sortedByDate.sort((b, a) => a.dateTime.compareTo(b.dateTime));
    // print(_events[_events.length - 1].dateTime);
    // print(sortedByDate[0].title);
    int streakCounter = 1;
    DateTime lastDate;
    bool firstLoop = true;

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
    return _events.firstWhere((place) => place.id == id);
  }

  Future<void> addImage(String pickedTitle, File pickedImage, String testDate,
      List<String> selectedTags) async {
    final newPlace = ImageData(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      dateTime: DateTime.parse(testDate),
      tags: selectedTags,
    );
    _events.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'dateTime': newPlace.dateTime.toIso8601String(),
      'tags': newPlace.tags.join(",")
    });
    // print("Successfully submitted");
    // print(newPlace.tags.join(","));
  }

  Future<void> fetchAndSetImages() async {
    final dataList = await DBHelper.getData('user_places');
    // print("Fetching");
    // print(dataList);
    _events = dataList
        .map(
          (item) => ImageData(
              id: item['id'],
              title: item['title'],
              image: File(item['image']),
              dateTime: DateTime.parse(item['dateTime']),
              tags: item['tags'] != null ? item['tags'].split(',') : null),
        )
        .toList();
    notifyListeners();
  }
}
