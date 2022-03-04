//import 'package:http/http.dart' as http;
//import 'dart:html' as html;

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

import 'package:area/screens/Login/home_view.dart';

Future<void> authenticate() async {
  final authUrl =
      'https://discord.com/oauth2/authorize?client_id=945702069376024656&permissions=0&scope=bot%20applications.commands';
  final rsp = await http.get(Uri.parse(authUrl));

  if (rsp.statusCode == 200) {
    print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA CUM");
    print(rsp.body);

    return;
  } else {
    print("Failed data search because i got: ");
    print(rsp.statusCode);
    print(rsp.body);
    return;
  }
}

class TokenAsk extends StatefulWidget {
  const TokenAsk({Key? key}) : super(key: key);

  @override
  State<TokenAsk> createState() => TokenAskState();
}

class TokenAskState extends State<TokenAsk> {
  late WebViewController control;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WebView(
            initialUrl:
                "https://discord.com/oauth2/authorize?client_id=945702069376024656&permissions=0&scope=bot%20applications.commands",
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController controller) {
              control = controller;
            },
            onPageStarted: (url) async {
              if (url.contains("code=")) {
                Uri link = Uri.dataFromString(url.substring(0, url.length - 2));
                var code;
                setState(() {
                  code = link.queryParameters["code"];
                });
                await authenticate();
                return runApp(HomeView());
              } else if (url.contains("error")) {
                print("ight im outta here");
                setState(() {
                  control.loadUrl(
                      "https://discord.com/oauth2/authorize?client_id=945702069376024656&permissions=0&scope=bot%20applications.commands");
                });
              }
            }));
  }
}

Future<void> oauthTest() async {
  /*OAuth2Client client = GitHubOAuth2Client(
      customUriScheme: 'my.app',
      redirectUri: 'my.app://oauth2redirect');

  AccessTokenResponse tknResp = await client.getTokenWithAuthCodeFlow(
      clientId: 'myclientid', clientSecret: 'myclientsecret', scopes: ['repo']);*/

  authenticate();

  /*http.Client httpClient = http.Client();
  http.Response resp = await httpClient.get(Uri.parse(
      'https://discord.com/oauth2/authorize?client_id=945702069376024656&permissions=0&scope=bot%20applications.commands'));

  print(resp.body);
  if (resp.statusCode != 200) {
    /*AccessTokenResponse tknResp = await client.getTokenWithAuthCodeFlow(
        clientId: 'myclientid',
        clientSecret: 'myclientsecret',
        scopes: ['repo']);*/

    print("Not good...");
    /*http.Response resp = await httpClient.get(
        Uri.parse('https://api.github.com/user/repos'),
        headers: {'Authorization': 'Bearer ' + tknResp.accessToken.toString()});*/
  } else {
    print("Good !");
  }*/
}
