import 'package:flutter/material.dart';

class CreateCompilation extends StatefulWidget {
  static const routeName = '/create-compilation';
  @override
  _CreateCompilationState createState() => _CreateCompilationState();
}

class _CreateCompilationState extends State<CreateCompilation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Create Compilation'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(height: 35),
            Container(
              child: FlatButton(
                child: Text(
                  'Create Video Compilaiton',
                  style: TextStyle(fontSize: 20.0),
                ),
                onPressed: () {
                  // Navigator.of(context).pushNamed(ContactUsScreen.routeName,);
                },
              ),
            ),
            Container(
              child: FlatButton(
                child: Text(
                  'Create Gif Compilation',
                  style: TextStyle(fontSize: 20.0),
                ),
                onPressed: () {
                  // Navigator.of(context).pushNamed(CreditsScreen.routeName,);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
