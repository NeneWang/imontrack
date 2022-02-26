import 'package:flutter/material.dart';

class StatHighlight extends StatelessWidget {
  Size screenSize;
  String title;
  String description;

  StatHighlight(
      {@required this.screenSize,
      @required this.title,
      @required this.description});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenSize.width / 4.5,
      height: screenSize.height / 8,
      child: Card(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
          ),
          Text(description),
        ],
      )),
    );
  }
}
