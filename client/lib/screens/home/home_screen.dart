import 'package:flutter/material.dart';

import 'package:area/settings.dart';
import 'package:area/constants.dart';
import 'package:area/components/NavBar.dart';
import 'package:area/components/ActionsFetch.dart';

import 'components/heighlights.dart';
import 'components/home_banner.dart';
import 'components/my_projects.dart';
import 'components/recommendations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String route = '/home';

  @override
  Widget build(BuildContext context) {
    /*return const MainScreen(
      children: [
        HomeBanner(),
        HighLightsInfo(),
        MyProjects(),
        Recommendations(),
      ],
    );*/
    return Home();
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int navIndex = 0;
  String nameCity = "Paris";
  late Future<Joke> joke;

  TextEditingController cityController = TextEditingController();

  Future<int> i = ActionsFetch().fetchTime();
  late Future<Weather> paris;
  Future<Weather> tokyo = ActionsFetch().fetchWeather("Tokyo");

  @override
  void initState() {
    super.initState();
    paris = ActionsFetch().fetchWeather(nameCity);
    joke = ActionsFetch().fetchJoke();
  }

  void refreshWeather() {
    // reload
    setState(() {
      paris = ActionsFetch().fetchWeather(cityController.text);
      nameCity = cityController.text;
    });
  }

  void refreshJoke() {
    // reload
    setState(() {
      joke = ActionsFetch().fetchJoke();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Home',
            style: TextStyle(
              fontFamily: "Raleway",
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          backgroundColor: settings.dark_mode ? pf2 : pc3,
        ),
        backgroundColor: settings.dark_mode ? pf1 : pc1,
        drawer: NavBar(),
        body: Column(children: <Widget>[
          FutureBuilder<Weather>(
              future: paris,
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
                          leading: Image(
                              image:
                                  NetworkImage("http:" + snapshot.data!.icon)),
                          title: Text(nameCity),
                          subtitle: Text(
                              "Weather: " +
                                  snapshot.data!.weather +
                                  "\nTemperature: " +
                                  snapshot.data!.temperature,
                              style: Theme.of(context).textTheme.bodyMedium),
                          textColor: settings.dark_mode ? pc1 : pc1,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 0),
                          child: TextField(
                              decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: "Enter a city"),
                              controller: cityController),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            refreshWeather();
                          },
                          child: const Text('Apply'),
                        ),
                      ],
                    ),
                  );
                }

                return const CircularProgressIndicator();
              }),
          FutureBuilder<Joke>(
              future: joke,
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
                          leading: const Image(
                              image: NetworkImage(
                                  "https://assets.stickpng.com/images/584f0ac96a5ae41a83ddee60.png")),
                          title: Text("Setup: " +
                              snapshot.data!.setup +
                              "\nPunchline: " +
                              snapshot.data!.punchline),
                          textColor: settings.dark_mode ? pc1 : pc1,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            refreshJoke();
                          },
                          child: const Text('Refresh'),
                        ),
                      ],
                    ),
                  );
                }

                return const CircularProgressIndicator();
              }),
        ]));
  }
}
