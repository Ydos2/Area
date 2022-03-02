import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:area/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

class Weather {
  final String weather;
  final String icon;
  final String temperature;
  final String feelslike;
  final String humidity;

  const Weather({
    required this.weather,
    required this.icon,
    required this.temperature,
    required this.feelslike,
    required this.humidity,
  });
}

class Joke {
  final String setup;
  final String punchline;

  const Joke({
    required this.setup,
    required this.punchline,
  });
}

class ActionsFetch {
  String discordID = "";

  Future<int> fetchLogin(String login, String password, dynamic context) async {
    final response = await http.get(Uri.parse(
        'https://areachad.herokuapp.com/user/login?mail=' +
            login +
            '&pass=' +
            password));

    print(response.statusCode);
    if (response.statusCode == 200) {
      print("Good login");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Home();
          },
        ),
      );
      return 0;
    } else {
      print("Not good login");
      return 1;
      //throw Exception('Failed to load album');
    }
  }

  Future<int> fetchRegister(String login, String password, String name) async {
    final response = await http.get(Uri.parse(
        'https://areachad.herokuapp.com/user/register?mail=' +
            login +
            '&pass=' +
            password +
            '&name=' +
            name));

    if (response.statusCode == 200) {
      print("Good register");
      return 0;
    } else {
      print("Not good register");
      return 1;
    }
  }

  Future<int> fetchTime() async {
    final response =
        await http.get(Uri.parse('https://areachad.herokuapp.com/data/time'));

    if (response.statusCode == 200) {
      print(response.body);

      final data = jsonDecode(response.body);
      print(data['time'].toString());
      print(data['date'].toString());
      return 0;
    } else {
      return 1;
    }
  }

  Future<Joke> fetchJoke() async {
    final response =
        await http.get(Uri.parse('https://areachad.herokuapp.com/data/joke'));

    if (response.statusCode == 200) {
      print(response.body);

      final data = jsonDecode(response.body);
      final joke = Joke(
          setup: data['setup'].toString(),
          punchline: data['punchline'].toString());

      return joke;
    } else {
      const joke = Joke(setup: "", punchline: "");

      return joke;
    }
  }

  Future<Weather> fetchWeather(String place) async {
    final response = await http.get(Uri.parse(
        'https://areachad.herokuapp.com/data/weather?place=' + place));

    if (response.statusCode == 200) {
      print(response.body);

      final data = jsonDecode(response.body);
      final weather = Weather(
          weather: data['weather'].toString(),
          icon: data['icon'].toString(),
          temperature: data['temperature'].toString(),
          feelslike: data['feelslike'].toString(),
          humidity: data['humidity'].toString());

      return weather;
    } else {
      const weather = Weather(
          weather: "", icon: "", temperature: "", feelslike: "", humidity: "");

      return weather;
    }
  }

  Future<void> fetchEmail(
      String mail, String content, String object, String time) async {
    final response = await http.get(Uri.parse(
        'https://areachad.herokuapp.com/area/time/mail?mail=' +
            mail +
            '&content=' +
            content +
            '&object=' +
            object +
            '&time=' +
            time));

    // in progress
    if (response.statusCode == 200) {
      print(response.body);
      return;
    } else {
      return;
    }
  }

  Future<void> fetchConnectDiscord() async {
    final response = await http.get(Uri.parse(
        'https://discord.com/oauth2/authorize?client_id=945702069376024656&permissions=0&scope=bot%20applications.commands'));

    // in progress
    if (response.statusCode == 200) {
      print(response.body);

      final data = jsonDecode(response.body);
      print(data['id'].toString());
      discordID = data['id'].toString();
      return;
    } else {
      return;
    }
  }

  Future<void> fetchDiscord(String message, String time) async {
    final response = await http.get(Uri.parse(
        'https://areachad.herokuapp.com/area/time/discord?userID=' +
            discordID +
            '&message=' +
            message +
            '&time=' +
            time));

    // in progress
    if (response.statusCode == 200) {
      print(response.body);
      return;
    } else {
      return;
    }
  }
}
