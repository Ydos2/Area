import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:area/settings.dart';
import 'package:area/constants.dart';

class NotifState extends StatefulWidget {
  const NotifState({Key? key}) : super(key: key);

  @override
  State<NotifState> createState() => StatefulNotif();
}

class StatefulNotif extends State<NotifState> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  int _index = settings.titles.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notification',
          style: TextStyle(
            fontFamily: "Raleway",
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        backgroundColor: settings.dark_mode ? pf2 : pc3,
      ),
      backgroundColor: settings.dark_mode ? pf1 : pc1,
      body: Center(
        child: _index == 0
            ? Text(
                "No new notification...",
                style: TextStyle(
                  fontFamily: "Raleway",
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: settings.dark_mode ? pc1 : pf2,
                ),
              )
            : ListView.builder(
                itemCount: _index,
                itemBuilder: (context, index) {
                  return Card(
                      child: ListTile(
                          title: Text(settings.titles[index]),
                          subtitle: Text(settings.subtitles[index]),
                          leading: Icon(settings.icon[index]),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                settings.titles.removeAt(index);
                                settings.subtitles.removeAt(index);
                                settings.icon.removeAt(index);
                                _index = settings.titles.length;
                              });
                            },
                          )));
                }),
      ),
    );
  }
}
