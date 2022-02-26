import 'package:flutter/material.dart';

class CreateObjective extends StatefulWidget {
  static const routeName = '/create-objective';
  @override
  _CreateObjectiveState createState() => _CreateObjectiveState();
}

class _CreateObjectiveState extends State<CreateObjective> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Objectives")),
    );
  }
}
