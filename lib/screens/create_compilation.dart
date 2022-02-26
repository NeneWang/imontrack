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
      appBar: AppBar(title: Text("Create Compilations")),
    );
  }
}
