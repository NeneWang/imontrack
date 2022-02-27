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
    final logEvent =
        Provider.of<LogProvider>(context, listen: false).findById(id);
    String objectiveName = Provider.of<LogProvider>(context, listen: false)
        .getObjectiveNameByID(logEvent.objectiveID);

    final List<String> tags = logEvent.tags;
    if (logEvent.tags.length>0 || logEvent.tags != null) {
      logEvent.tags.forEach((element) {
        tagsWidget.add(Chip(label: Text(objectiveName)));
    });
    } else {
      tagsWidget.add(Chip(label: Text("No Objective set.")));
    }

    // print(logEvent);

    return Scaffold(
      appBar: AppBar(
        title: Text(logEvent.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              logEvent.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(DateFormat('yyyy-MM-dd – kk:mm').format(logEvent.dateTime)),
          Text(
            logEvent.description,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Wrap(
                    spacing: 10,
                    children: tagsWidget,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
