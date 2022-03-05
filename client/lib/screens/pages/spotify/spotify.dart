import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';

import 'package:area/settings.dart';
import 'package:area/constants.dart';
import 'package:area/components/NavBar.dart';
import 'package:area/components/ActionsFetch.dart';

import 'package:audioplayers/audioplayers.dart';

import 'player_widget.dart';

class SpotifyState extends StatefulWidget {
  const SpotifyState({Key? key}) : super(key: key);

  @override
  State<SpotifyState> createState() => StatefulSpotify();
}

class StatefulSpotify extends State<SpotifyState> {
  bool _dark = settings.dark_mode;
  late Future<Spotify> spotify;

  AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);

  @override
  void initState() {
    super.initState();
    _dark = settings.dark_mode;
    spotify = ActionsFetch().fetchSpotify();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  void refreshSpotify() {
    setState(() {
      spotify = ActionsFetch().fetchSpotify();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Spotify',
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
              FutureBuilder<Spotify>(
                  future: spotify,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const <Widget>[
                            ListTile(
                              leading: Icon(Icons.album),
                              title:
                                  Text('Spotify not launch...\nMusic by ...'),
                            ),
                          ],
                        ),
                      );
                    } else if (snapshot.hasData) {
                      return Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: Icon(Icons.album),
                              title: Text(snapshot.data!.music +
                                  '\nMusic by ' +
                                  snapshot.data!.artist),
                            ),
                            PlayerWidget(url: snapshot.data!.preview),
                          ],
                        ),
                      );
                    }

                    return const CircularProgressIndicator();
                  }),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  refreshSpotify();
                },
                child: const Text('Refresh spotify music'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WebView(
                              initialUrl:
                                  "https://areachad.herokuapp.com/spotify/login?mail=" +
                                      settings.mail_actu,
                              javascriptMode: JavascriptMode.unrestricted,
                            )),
                  );
                  showInSnackBar("Spotify is connected !");
                },
                child: const Text('Connect to spotify'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState!.showSnackBar(SnackBar(
      content: Text(
        value,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Colors.white, fontSize: 16.0, fontFamily: "Raleway"),
      ),
      backgroundColor: pc5,
      duration: const Duration(seconds: 3),
    ));
  }
}
