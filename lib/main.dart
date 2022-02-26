import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/images_provider.dart';

// Import Screens
import 'screens/create_compilation.dart';
import 'screens/create_log.dart';
import 'screens/create_objective.dart';
import 'screens/progress_feed.dart';
import 'screens/share_compilation.dart';

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
              ThemeData(primarySwatch: Colors.indigo, accentColor: Colors.grey),
          home: ProgressFeed()),
    );
  }
}
