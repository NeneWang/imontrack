import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/log_provider.dart';
import '../widgets/bottom_navigator.dart';

import '../widgets/stat_highlights.dart';

import 'create_log.dart';
import 'create_compilation.dart';

import 'view_log.dart';

class StatsBoard extends StatefulWidget {
  @override
  _StatsBoardState createState() => _StatsBoardState();
}

class _StatsBoardState extends State<StatsBoard> {
  void addOneWeek(BuildContext context) {
// Increase the week count somehow. like don't even count the days just add the counter and say how mnay weeks.
    Provider.of<LogProvider>(context, listen: false).increaseWeek();
    setState(() {});
  }

  @override
  build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Expanded(
        flex: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                StatHighlight(
                  screenSize: screenSize,
                  title:
                      "${Provider.of<LogProvider>(context, listen: false).weekSinceStart}",
                  description: "Weeks",
                ),
                StatHighlight(
                  screenSize: screenSize,
                  title:
                      "${Provider.of<LogProvider>(context, listen: false).streaks}",
                  description: "Streaks",
                ),
                StatHighlight(
                  screenSize: screenSize,
                  title: "4",
                  description: "Max Streaks",
                ),
                StatHighlight(
                  screenSize: screenSize,
                  title:
                      "${Provider.of<LogProvider>(context, listen: false).eventsCount}",
                  description: "Total Logs",
                ),
              ],
            ),
            FlatButton(
                onPressed: () => addOneWeek(context), child: Text("+1 week")),
          ],
        ));
  }
}

class ProgressFeed extends StatelessWidget {
  static const routeName = '/progress-feed';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            StatsBoard(),
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
        bottomNavigationBar: BottomNavigator(
          indexNavigator: 0,
          context: context,
        ));
  }
}
