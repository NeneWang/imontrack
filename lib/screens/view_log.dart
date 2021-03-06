import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/log_provider.dart';

class ViewLogScreen extends StatelessWidget {
  static const routeName = '/view-log';

  List<Widget> tagsWidget = [];

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final myProvider = Provider.of<LogProvider>(context, listen: false);
    final logEvent = myProvider.findById(id);
    String objectiveName =
        myProvider.getObjectiveNameByID(logEvent.objectiveID);

    // final List<String> tags = logEvent.tags;
    // if (logEvent.tags.length>0 || logEvent.tags != null) {
    //   logEvent.tags.forEach((element) {
    //     tagsWidget.add(Chip(label: Text(objectiveName)));
    // });
    // } else {
    //   tagsWidget.add(Chip(label: Text("No Objective set.")));
    // }

    // print(logEvent);

    void deletePressedHandler() async {
      await myProvider.deleteImage(logEvent.id);
      await myProvider.fetchAll().then((value) => Navigator.of(context).pop());
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(logEvent.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 350,
            width: double.infinity,
            child: Image.file(
              logEvent.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                      'Objective: ${objectiveName != null ? objectiveName : "No objective selected"}'),
                  SizedBox(
                    height: 10,
                  ),
                  Text(DateFormat('yyyy-MM-dd – kk:mm')
                      .format(logEvent.dateTime)),
                  Text(
                    logEvent.description != null ? logEvent.description : "",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FlatButton(
                    child: Text("Delete"),
                    onPressed: deletePressedHandler,
                  )
                ],
              ))
        ],
      ),
    );
  }
}
