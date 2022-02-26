import 'package:flutter/material.dart';
import '../screens/create_log.dart';
import '../screens/progress_feed.dart';
import '../screens/create_objective.dart';

class BottomNavigator extends StatelessWidget {
  final int indexNavigator;
  final BuildContext context;

  BottomNavigator(this.indexNavigator, this.context);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: true,
      showUnselectedLabels: false,
      onTap: (int index) {
        // print(index);
        switch (index) {
          case 0:
            Navigator.of(context).pushReplacement(PageRouteBuilder(
              pageBuilder: (_, __, ___) => CreateLog(),
              transitionDuration: Duration(seconds: 0),
            ));
            break;
          case 1:
            Navigator.of(context).pushReplacement(PageRouteBuilder(
              pageBuilder: (_, __, ___) => CreateObjective(),
              transitionDuration: Duration(seconds: 0),
            ));
            break;
            case 2:
            Navigator.of(context).pushReplacement(PageRouteBuilder(
              pageBuilder: (_, __, ___) => ProgressFeed(),
              transitionDuration: Duration(seconds: 0),
            ));
            break;
        }
      },
      backgroundColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.white,
      selectedItemColor: Theme.of(context).accentColor,
      currentIndex: indexNavigator,
      // type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).primaryColor,
          icon: Icon(Icons.photo),
          title: Text('+ Log'),
        ),
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).primaryColor,
          icon: Icon(Icons.calendar_today_rounded),
          title: Text('+ Objective'),
        ),
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).primaryColor,
          icon: Icon(Icons.account_box_outlined),
          title: Text('Progress'),
        ),
      ],
    );
  }
}
