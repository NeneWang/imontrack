import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/log_provider.dart';
import '../widgets/bottom_navigator.dart';
import '../widgets/image_input.dart';
import 'progress_feed.dart';
import '../models/ImageData.dart';
import '/utils/tools.dart';

class CreateLog extends StatefulWidget {
  static const routeName = '/create-log';
  @override
  _CreateLogState createState() => _CreateLogState();
}

class _CreateLogState extends State<CreateLog> {
  List<String> selectedTags = [];

  final _titleController = TextEditingController();
  final _tagsController = TextEditingController();
  final _descriptionController = TextEditingController();

  File _pickedImage;

  Future<DateTime> selectedDate;
  String inputDate = "";
  String inputDescription = "";
  String selectedObjectiveID = "";

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _addTag(String tagName) {
    setState(() {
      selectedTags.add(tagName);
    });
    _tagsController.clear();
  }

  Iterable<Widget> get getTagsWidgets sync* {
    for (final String tagName in selectedTags) {
      yield Padding(
        padding: const EdgeInsets.all(4.0),
        child: Chip(
          label: Text(tagName),
          onDeleted: () {
            setState(() {
              selectedTags.removeWhere((itemName) {
                return tagName == itemName;
              });
            });
          },
        ),
      );
    }
  }

  void _saveLog() {
    //Only the picked Image is necessary
    if (_pickedImage == null) {
      return;
    }
    var myProvider = Provider.of<LogProvider>(context, listen: false);
    var registerDate =
        inputDate == "" ? DateTime.now() : DateTime.parse(inputDate);
    myProvider.addImage(
        _titleController.text == "" || _titleController.text == null
            ? " Progress ${Tools.getFormattedDateShortDateTime(registerDate)}  ${Tools.getFormattedTimeEventDateTime(DateTime.now())}"
            : _titleController.text,
        _pickedImage,
        registerDate.toIso8601String(),
        selectedTags,
        _descriptionController.text,
        selectedObjectiveID);
    _showToast(context);

    Navigator.pushReplacementNamed(context, ProgressFeed.routeName)
        .then((value) => myProvider.fetchAll());
    // myProvider.fetchAll().then((value) => Navigator.of(context).pop());
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);

    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Log Created'),
      ),
    );
  }

  void _chooseObjective(e) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Log'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 7,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(_selectImage),
                    TextField(
                      decoration:
                          InputDecoration(labelText: 'Title (optional)'),
                      controller: _titleController,
                    ),
                    TextField(
                      decoration:
                          InputDecoration(labelText: 'Description (optional)'),
                      controller: _descriptionController,
                    ),
                    // TextField(
                    //   decoration:
                    //       InputDecoration(labelText: 'Enter a tag (optional)'),
                    //   controller: _tagsController,
                    //   onSubmitted: _addTag,
                    // ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Wrap(
                              spacing: 5,
                              children: getTagsWidgets.toList(),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          primary: Theme.of(context).accentColor),
                      child: Text(inputDate == "" ? "Today" : inputDate,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      onPressed: () {
                        showDialogPicker(context);
                      },
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    // LocationInput(_selectPlace),
                  ],
                ),
              ),
            ),
          ),
          Text("Choose an Objective"),
          Expanded(
              flex: 1,
              child: FutureBuilder(
                future: Provider.of<LogProvider>(context, listen: false)
                    .fetchAndSetObjectives(),
                builder: (ctx, snapshot) => snapshot.connectionState ==
                        ConnectionState.waiting
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Consumer<LogProvider>(
                        child: Center(
                          child: const Text('Got no Objectives created yet.'),
                        ),
                        builder: (ctx, imagesData, ch) =>
                            imagesData.objectives.length <= 0
                                ? ch
                                : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: imagesData.objectives.length,
                                    itemBuilder: (ctx, i) => ActionChip(
                                        backgroundColor: selectedObjectiveID ==
                                                imagesData.objectives[i].id
                                            ? Theme.of(context).accentColor
                                            : Colors.grey[1],
                                        onPressed: () {
                                          selectedObjectiveID =
                                              imagesData.objectives[i].id;
                                          setState(() {});
                                        },
                                        label: Text(
                                            imagesData.objectives[i].title)),
                                  ),
                      ),
              )),
          RaisedButton.icon(
            icon: Icon(Icons.add),
            label: Text('Create Log'),
            onPressed: _saveLog,
            elevation: 0,
            // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).accentColor,
          ),
        ],
      ),
    );
  }

  void showDialogPicker(BuildContext context) {
    selectedDate = showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
    selectedDate.then((value) {
      setState(() {
        if (value == null) return;
        inputDate = Tools.getFormattedDateSimple(value.millisecondsSinceEpoch);
      });

      print(DateTime.parse(inputDate).toUtc());
    }, onError: (error) {
      print(error);
    });
  }
}
