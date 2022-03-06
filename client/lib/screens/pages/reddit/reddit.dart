import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:area/settings.dart';
import 'package:area/constants.dart';
import 'package:area/components/NavBar.dart';
import 'package:area/components/ActionsFetch.dart';

class RedditState extends StatefulWidget {
  const RedditState({Key? key}) : super(key: key);

  @override
  State<RedditState> createState() => StatefulReddit();
}

class StatefulReddit extends State<RedditState> {
  bool _dark = settings.dark_mode;

  @override
  void initState() {
    super.initState();
    _dark = settings.dark_mode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reddit',
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
              SwitchListTile(
                title: Text(
                  "Ping new post ?",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Raleway",
                      color: settings.dark_mode ? pc1 : pf1,
                      fontWeight: FontWeight.w800),
                ),
                subtitle: Text(
                  "" + settings.newsReddit.toString(),
                  style: TextStyle(
                    color: settings.dark_mode ? pc1 : pf1,
                    fontFamily: "Raleway",
                  ),
                ),
                value: settings.newsReddit,
                onChanged: (val) {
                  if (settings.newsReddit == false) {
                    settings.newsReddit = true;
                  } else {
                    settings.newsReddit = false;
                  }
                  settings.applyChangeNews();
                  setState(() {
                    ActionsFetch().fetchNewsReddit(settings.mail_actu, settings.newsReddit);
                    settings.newsReddit = settings.newsReddit;
                  });
                },
              ),
              const SizedBox(height: 30.0),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  _launchInBrowser(
                      "https://areachad.herokuapp.com/reddit/login?mail=" +
                          settings.mail_actu);
                },
                child: const Text('Connect to spotify'),
              ),
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
