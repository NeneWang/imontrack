import 'package:flutter/material.dart';

class ProgressFeed extends StatefulWidget {
  static const routeName = '/progress_feed';
  @override
  _ProgressFeedState createState() => _ProgressFeedState();
}

class _ProgressFeedState extends State<ProgressFeed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Progress Feed")),
    );
  }
}
