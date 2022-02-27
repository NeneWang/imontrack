import 'package:flutter/material.dart';
import 'package:imontrack/models/objective.dart';
import 'package:imontrack/screens/view_log.dart';
import 'package:provider/provider.dart';

import 'providers/log_provider.dart';

// Import Screens
import 'screens/create_compilation.dart';
import 'screens/create_log.dart';
import 'screens/create_objective.dart';
import 'screens/progress_feed.dart';
import 'screens/share_compilation.dart';
import 'screens/objective_feed..dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: LogProvider(),
      child: MaterialApp(
        title: 'Images',
        theme:
            ThemeData(primarySwatch: Colors.indigo, accentColor: Colors.yellow[700]),
        home: ProgressFeed(),
        routes: {
          CreateCompilation.routeName: (ctx) => CreateCompilation(),
          CreateLog.routeName: (ctx) => CreateLog(),
          CreateObjective.routeName: (ctx) => CreateObjective(),
          ProgressFeed.routeName: (ctx) => ProgressFeed(),
          ShareCompilation.routeName: (ctx) => ShareCompilation(),
          ViewLogScreen.routeName: (ctx) => ViewLogScreen(),
          ObjectiveFeed.routeName: (ctx) => ObjectiveFeed()
        },
      ),
    );
  }
}
