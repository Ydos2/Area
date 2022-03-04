import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';

import 'package:area/settings.dart';
import 'package:area/constants.dart';
import 'package:area/components/NavBar.dart';

class SpotifyState extends StatefulWidget {
  const SpotifyState({Key? key}) : super(key: key);

  @override
  State<SpotifyState> createState() => StatefulSpotify();
}

class StatefulSpotify extends State<SpotifyState> {
  bool _dark = settings.dark_mode;

  @override
  void initState() {
    super.initState();
    _dark = settings.dark_mode;
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spotify'),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        // ICCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCI
                        builder: (context) => const WebView(
                              initialUrl:
                                  "https://areachad.herokuapp.com/spotify/login?" +
                                      "LESSS GO TU PEUT METTRE LE MAIL DE L'USER STP",
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
