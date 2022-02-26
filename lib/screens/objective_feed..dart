import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/log_provider.dart';
import '../widgets/bottom_navigator.dart';
import 'create_log.dart';


import 'view_log.dart';


class ObjectiveFeed extends StatelessWidget {
  static const routeName = '/progress-feed';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Objectives Feed'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(CreateLog.routeName);
              },
            ),
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<LogProvider>(context, listen: false)
              .fetchAndSetObjectives(),
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
                  
                      imagesData.objectives.length <= 0
                          ? ch
                          : ListView.builder(
                              itemCount: imagesData.objectives.length,
                              itemBuilder: (ctx, i) => ListTile(
                                title: Text(imagesData.objectives[i].title),
                                subtitle: Text('${imagesData.objectives[i].description}')
                              ),
                            ),
                ),
        ),
        bottomNavigationBar: BottomNavigator(0, context));
  }
}

