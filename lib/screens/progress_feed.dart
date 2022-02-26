import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/log_provider.dart';
import '../widgets/bottom_navigator.dart';

import '../widgets/stat_highlights.dart';

import 'create_log.dart';
import 'create_compilation.dart';

import 'view_log.dart';

void addOneWeek() {
// Increase the week count somehow. like don't even count the days just add the counter and say how mnay weeks.
  
}

class ProgressFeed extends StatelessWidget {
  static const routeName = '/progress-feed';
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Text("+1 wk"),
          onPressed: addOneWeek,
        ),
        appBar: AppBar(
          title: Text('Progress Feed'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.video_call),
              onPressed: () {
                Navigator.of(context).pushNamed(CreateCompilation.routeName);
              },
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(CreateLog.routeName);
              },
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  StatHighlight(
                    screenSize: screenSize,
                    title: "2",
                    description: "Weeks",
                  ),
                  StatHighlight(
                    screenSize: screenSize,
                    title: "2",
                    description: "Streaks",
                  ),
                  StatHighlight(
                    screenSize: screenSize,
                    title: "4",
                    description: "Max Streaks",
                  ),
                  StatHighlight(
                    screenSize: screenSize,
                    title: "6",
                    description: "Total Logs",
                  )
                ],
              ),
            ),
            Expanded(
                flex: 5,
                child: FutureBuilder(
                  future: Provider.of<LogProvider>(context, listen: false)
                      .fetchAll(),
                  builder: (ctx, snapshot) => snapshot.connectionState ==
                          ConnectionState.waiting
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Consumer<LogProvider>(
                          child: Center(
                            child: const Text('Got no Log yet.'),
                          ),
                          builder: (ctx, imagesData, ch) =>
                              imagesData.events.length <= 0
                                  ? ch
                                  : ListView.builder(
                                      itemCount: imagesData.events.length,
                                      itemBuilder: (ctx, i) => ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage: FileImage(
                                            imagesData.events[i].image,
                                          ),
                                        ),
                                        title: Text(imagesData.events[i].title),
                                        subtitle: Text(
                                            '${imagesData.events[i].description}'),
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                            ViewLogScreen.routeName,
                                            arguments: imagesData.events[i].id,
                                          );
                                        },
                                      ),
                                    ),
                        ),
                ))
          ],
        ),
        bottomNavigationBar: BottomNavigator(0, context));
  }
}
