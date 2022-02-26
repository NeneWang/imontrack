import 'package:flutter/material.dart';

class ShareCompilation extends StatefulWidget {
  static const routeName = '/share_compilation';
  @override
  _ShareCompilationState createState() => _ShareCompilationState();
}

class _ShareCompilationState extends State<ShareCompilation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Share Compilations")),
    );
  }
}
