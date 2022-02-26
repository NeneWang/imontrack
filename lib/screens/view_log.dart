import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/log_provider.dart';

class ViewLogScreen extends StatelessWidget {
  static const routeName = '/view-log';

  List<Widget> tagsWidget = [];

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final logEvent =
        Provider.of<LogProvider>(context, listen: false).findById(id);


    final List<String> tags = logEvent.tags;
    if (tags != null) {
      logEvent.tags.forEach((element) {
        tagsWidget.add(Chip(label: Text(element)));
      });
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
          Text(
            logEvent.dateTime.toIso8601String(),
          ),
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
