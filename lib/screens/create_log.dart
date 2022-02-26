import 'package:flutter/material.dart';
import '../widgets/bottom_navigator.dart';

class CreateLog extends StatefulWidget {
  static const routeName = '/create-log';
  @override
  _CreateLogState createState() => _CreateLogState();
}

class _CreateLogState extends State<CreateLog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Log Screen")),
      bottomNavigationBar: BottomNavigator(0, context)
    );
  }
}
