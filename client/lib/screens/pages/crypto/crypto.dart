import 'package:area/components/ActionsFetch.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:area/settings.dart';
import 'package:area/constants.dart';
import 'package:area/components/NavBar.dart';

class CryptoState extends StatefulWidget {
  const CryptoState({Key? key}) : super(key: key);

  @override
  State<CryptoState> createState() => StatefulCrypto();
}

class StatefulCrypto extends State<CryptoState> {
  bool _dark = settings.dark_mode;

  late Future<List<Crypto>> crypto;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    _dark = settings.dark_mode;
    crypto = ActionsFetch().fetchCrypto();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = const AndroidInitializationSettings('app_icon');
    var iOS = const IOSInitializationSettings();
    var initSetttings = InitializationSettings(android: android, iOS: iOS);
    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);

    Future.delayed(const Duration(minutes: 4), () {
      setNewNotification("Crypto", "News is here");
      setState(() {});
    });
  }

  void onSelectNotification(String? payload) {
    debugPrint("payload : $payload");
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Notification'),
        content: Text('$payload'),
      ),
    );
  }

  void refreshCrypto() {
    // reload
    setState(() {
      crypto = ActionsFetch().fetchCrypto();
    });
  }

  showNotification(int id, String title, String text) async {
    var android = const AndroidNotificationDetails('channel id', 'channel NAME',
        priority: Priority.high, importance: Importance.max);
    var iOS = const IOSNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(id, title, text, platform,
        payload: 'AndroidCoding.in');
  }

  void setNewNotification(String title, String text) {
    showNotification(2, title, text);
    settings.titles.add(title);
    settings.subtitles.add(text);
    settings.icon.add(Icons.discord);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Crypto',
          style: TextStyle(
            fontFamily: "Raleway",
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        backgroundColor: settings.dark_mode ? pf2 : pc3,
      ),
      drawer: NavBar(),
      backgroundColor: settings.dark_mode ? pf1 : pc1,
      body: DefaultTextStyle(
        style: TextStyle(
          color: settings.dark_mode ? pf2 : pc2,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  refreshCrypto();
                },
                child: const Text('Refresh'),
              ),
              const SizedBox(height: 30.0),
              FutureBuilder<List<Crypto>>(
                  future: crypto,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      return Column(children: <Widget>[
                        Card(
                            color: settings.dark_mode ? pf2 : pc2,
                            child: Column(children: <Widget>[
                              ListTile(
                                title: Text(snapshot.data![0].title),
                                subtitle:
                                    Text("Source: " + snapshot.data![0].source),
                                leading: const Icon(Icons.newspaper),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _launchInBrowser(snapshot.data![0].url);

                                  Future.delayed(const Duration(minutes: 2),
                                      () {
                                    setNewNotification(
                                        "Crypto", "News is here");
                                    setState(() {});
                                  });
                                },
                                child: const Text(
                                  "See website",
                                  style: TextStyle(
                                    fontFamily: "Raleway",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ])),
                        Card(
                            color: settings.dark_mode ? pf2 : pc2,
                            child: Column(children: <Widget>[
                              ListTile(
                                title: Text(snapshot.data![1].title),
                                subtitle:
                                    Text("Source: " + snapshot.data![1].source),
                                leading: const Icon(Icons.newspaper),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _launchInBrowser(snapshot.data![1].url);
                                },
                                child: const Text(
                                  "See website",
                                  style: TextStyle(
                                    fontFamily: "Raleway",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ])),
                        Card(
                            color: settings.dark_mode ? pf2 : pc2,
                            child: Column(children: <Widget>[
                              ListTile(
                                title: Text(snapshot.data![2].title),
                                subtitle:
                                    Text("Source: " + snapshot.data![2].source),
                                leading: const Icon(Icons.newspaper),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _launchInBrowser(snapshot.data![2].url);
                                },
                                child: const Text(
                                  "See website",
                                  style: TextStyle(
                                    fontFamily: "Raleway",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ])),
                        Card(
                            color: settings.dark_mode ? pf2 : pc2,
                            child: Column(children: <Widget>[
                              ListTile(
                                title: Text(snapshot.data![3].title),
                                subtitle:
                                    Text("Source: " + snapshot.data![3].source),
                                leading: const Icon(Icons.newspaper),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _launchInBrowser(snapshot.data![3].url);
                                },
                                child: const Text(
                                  "See website",
                                  style: TextStyle(
                                    fontFamily: "Raleway",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ])),
                        Card(
                            color: settings.dark_mode ? pf2 : pc2,
                            child: Column(children: <Widget>[
                              ListTile(
                                title: Text(snapshot.data![4].title),
                                subtitle:
                                    Text("Source: " + snapshot.data![4].source),
                                leading: const Icon(Icons.newspaper),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _launchInBrowser(snapshot.data![4].url);
                                },
                                child: const Text(
                                  "See website",
                                  style: TextStyle(
                                    fontFamily: "Raleway",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ])),
                        Card(
                            color: settings.dark_mode ? pf2 : pc2,
                            child: Column(children: <Widget>[
                              ListTile(
                                title: Text(snapshot.data![5].title),
                                subtitle:
                                    Text("Source: " + snapshot.data![5].source),
                                leading: const Icon(Icons.newspaper),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _launchInBrowser(snapshot.data![5].url);
                                },
                                child: const Text(
                                  "See website",
                                  style: TextStyle(
                                    fontFamily: "Raleway",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ])),
                        Card(
                            color: settings.dark_mode ? pf2 : pc2,
                            child: Column(children: <Widget>[
                              ListTile(
                                title: Text(snapshot.data![6].title),
                                subtitle:
                                    Text("Source: " + snapshot.data![6].source),
                                leading: const Icon(Icons.newspaper),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _launchInBrowser(snapshot.data![6].url);
                                },
                                child: const Text(
                                  "See website",
                                  style: TextStyle(
                                    fontFamily: "Raleway",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ])),
                        Card(
                            color: settings.dark_mode ? pf2 : pc2,
                            child: Column(children: <Widget>[
                              ListTile(
                                title: Text(snapshot.data![7].title),
                                subtitle:
                                    Text("Source: " + snapshot.data![7].source),
                                leading: const Icon(Icons.newspaper),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _launchInBrowser(snapshot.data![7].url);
                                },
                                child: const Text(
                                  "See website",
                                  style: TextStyle(
                                    fontFamily: "Raleway",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ])),
                        Card(
                            color: settings.dark_mode ? pf2 : pc2,
                            child: Column(children: <Widget>[
                              ListTile(
                                title: Text(snapshot.data![8].title),
                                subtitle:
                                    Text("Source: " + snapshot.data![8].source),
                                leading: const Icon(Icons.newspaper),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _launchInBrowser(snapshot.data![8].url);
                                },
                                child: const Text(
                                  "See website",
                                  style: TextStyle(
                                    fontFamily: "Raleway",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ])),
                        Card(
                            color: settings.dark_mode ? pf2 : pc2,
                            child: Column(children: <Widget>[
                              ListTile(
                                title: Text(snapshot.data![9].title),
                                subtitle:
                                    Text("Source: " + snapshot.data![9].source),
                                leading: const Icon(Icons.newspaper),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _launchInBrowser(snapshot.data![9].url);
                                },
                                child: const Text(
                                  "See website",
                                  style: TextStyle(
                                    fontFamily: "Raleway",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ])),
                      ]);
                    }

                    return const CircularProgressIndicator();
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchInBrowser(String url) async {
    if (!await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    )) {
      throw 'Could not launch $url';
    }
  }
}
