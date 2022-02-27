import 'package:flutter/material.dart';
import 'package:imontrack/screens/objective_feed..dart';
import '../screens/create_log.dart';
import '../screens/progress_feed.dart';
import '../screens/create_objective.dart';

class BottomNavigator extends StatefulWidget {
  int indexNavigator;
  BuildContext context;
  BottomNavigator({@required this.indexNavigator, @required this.context});

  // BottomNavigator(this.indexNavigator, this.context)
  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  void _onItemTapped(int index) {
    setState(() {
      widget.indexNavigator = index;
    });
    switch (index) {
      case 0:
        Navigator.of(context).pushReplacement(PageRouteBuilder(
          pageBuilder: (_, __, ___) => ObjectiveFeed(),
          transitionDuration: Duration(seconds: 0),
        ));
        break;
      case 1:
        Navigator.of(context).pushReplacement(PageRouteBuilder(
          pageBuilder: (_, __, ___) => ProgressFeed(),
          transitionDuration: Duration(seconds: 0),
        ));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: true,
      showUnselectedLabels: false,
      onTap: _onItemTapped,
      backgroundColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.white,
      selectedItemColor: Theme.of(context).accentColor,
      currentIndex: widget.indexNavigator,
      // type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).primaryColor,
          icon: Icon(Icons.edit),
          title: Text('Objectives'),
        ),
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).primaryColor,
          icon: Icon(Icons.border_all),
          title: Text('Progress'),
        ),
      ],
    );
  }
}
