import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/log_provider.dart';
import '../widgets/bottom_navigator.dart';
import 'create_log.dart';


import 'view_log.dart';


class ProgressFeed extends StatelessWidget {
  static const routeName = '/progress-feed';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Progress Feed'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add_a_photo),
              onPressed: () {
                Navigator.of(context).pushNamed(CreateLog.routeName);
              },
            ),
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<LogProvider>(context, listen: false)
              .fetchAndSetImages(),
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
                                subtitle: Text('${imagesData.events[i].description}'),
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    ViewLogScreen.routeName,
                                    arguments: imagesData.events[i].id,
                                  );
                                },
                              ),
                            ),
                ),
        ),
        bottomNavigationBar: BottomNavigator(0, context));
  }
}

