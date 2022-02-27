import 'package:imontrack/models/objective.dart';

import '../widgets/bottom_navigator.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../providers/log_provider.dart';

class CreateObjective extends StatefulWidget {
  static const routeName = '/create-objective';
  @override
  _CreateObjectiveState createState() => _CreateObjectiveState();
}

class _CreateObjectiveState extends State<CreateObjective> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  void _saveObjective() {
    Provider.of<LogProvider>(context, listen: false)
        .addObjective(_titleController.text, _descriptionController.text);
    _showToast(context);

    // Navigator.of(context).pop();
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);

    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Objective Created'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Objectives")),
      bottomNavigationBar: BottomNavigator(
        indexNavigator: 0,
        context: context,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: "Title"),
                    controller: _titleController,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: "Description"),
                    controller: _descriptionController,
                  ),
                  RaisedButton.icon(
                    icon: Icon(Icons.add),

                    label: Text('Create Objective'),
                    onPressed: _saveObjective,
                    elevation: 0,
                    // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    color: Theme.of(context).accentColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
