import 'package:flutter/material.dart';
import 'package:area/screens/main/main_screen.dart';

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

  TextEditingController cityController = TextEditingController();

  Future<int> i = ActionsFetch().fetchTime();
  late Future<Weather> paris;
  Future<Weather> tokyo = ActionsFetch().fetchWeather("Tokyo");

  @override
  void initState() {
    super.initState();
    paris = ActionsFetch().fetchWeather(nameCity);
  }

  void refreshWeather() {
    // reload
    setState(() {
      paris = ActionsFetch().fetchWeather(cityController.text);
      nameCity = cityController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: settings.dark_mode ? pf2 : pc3,
      ),
      backgroundColor: settings.dark_mode ? pf1 : pc1,
      drawer: NavBar(),
      body: FutureBuilder<Weather>(
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
                          image: NetworkImage("http:" + snapshot.data!.icon)),
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
    );
  }
}
