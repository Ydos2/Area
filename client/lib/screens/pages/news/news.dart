import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:area/settings.dart';
import 'package:area/constants.dart';
import 'package:area/components/NavBar.dart';
import 'package:area/components/ActionsFetch.dart';

class NewsState extends StatefulWidget {
  const NewsState({Key? key}) : super(key: key);

  @override
  State<NewsState> createState() => StatefulNews();
}

class StatefulNews extends State<NewsState> {
  bool _dark = settings.dark_mode;

  late Future<News> news;

  @override
  void initState() {
    super.initState();
    _dark = settings.dark_mode;
    news = ActionsFetch().fetchNews();
  }

  void refreshNews() {
    // reload
    setState(() {
      news = ActionsFetch().fetchNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'News',
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
              const SizedBox(height: 30.0),
              FutureBuilder<News>(
                  future: news,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      return Card(
                        color: settings.dark_mode ? pf2 : pc2,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: const Icon(Icons.newspaper),
                              title: const Text("NEWS"),
                              subtitle: Text(
                                  "Weather: " +
                                      snapshot.data!.name +
                                      "\nTemperature: " +
                                      snapshot.data!.description,
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                              textColor: settings.dark_mode ? pc1 : pc1,
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 20),
                              ),
                              onPressed: () {
                                refreshNews();
                              },
                              child: const Text('Refresh'),
                            ),
                          ],
                        ),
                      );
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
