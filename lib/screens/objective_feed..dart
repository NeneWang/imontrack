import 'package:flutter/material.dart';

import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:provider/provider.dart';
import '../providers/log_provider.dart';
import '../widgets/bottom_navigator.dart';
import 'package:flutter/material.dart';
import 'create_log.dart';

import 'view_log.dart';

class ObjectiveFeed extends StatelessWidget {
  static const routeName = '/progress-feed';

  @override
  Widget build(BuildContext context) {
    const ticks = [7, 14, 21, 28, 35];

    var provider = Provider.of<LogProvider>(context, listen: false);
    provider.fetchAndSetObjectives();
    print("Arrays Data");
    // print(provider.objectives.map((e) => e.title));
    // print(provider.objectives.map((e) => provider.getWeekProgressByID(e.id)));
    // print(provider.objectives.length);

    var objectiveTitles = provider.objectives.map((e) => e.title);
    var objectiveData =
        provider.objectives.map((e) => provider.getWeekProgressByID(e.id));

    List<String> features = ["AA"];
    List<List<int>> data = [
      [10]
    ];

    features.addAll(objectiveTitles);
    data[0].addAll(objectiveData);

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
        body: Column(
          children: <Widget>[
            Expanded(
              child: RadarChart.light(
                ticks: ticks,
                features: features,
                data: data,
                reverseAxis: true,
                useSides: false,
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: provider.fetchAndSetObjectives(),
                builder: (ctx, snapshot) =>
                    snapshot.connectionState == ConnectionState.waiting
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
                                            title: Text(
                                                imagesData.objectives[i].title),
                                            subtitle: Text(
                                                '${imagesData.objectives[i].description}; ${imagesData.objectives[i].id} ; Logs ${provider.getWeekProgressByID(imagesData.objectives[i].id)}')),
                                      ),
                          ),
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigator(0, context));
  }
}
