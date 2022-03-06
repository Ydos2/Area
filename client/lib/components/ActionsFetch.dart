import 'package:area/settings.dart';
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

class Zelda {
  final String name;
  final String description;

  const Zelda({
    required this.name,
    required this.description,
  });
}

class Crypto {
  final String title;
  final String url;
  final String source;

  const Crypto({
    required this.title,
    required this.url,
    required this.source,
  });
}

class News {
  final String name;
  final String description;

  const News({
    required this.name,
    required this.description,
  });
}

class Spotify {
  final String music;
  final String artist;
  final String preview;

  const Spotify({
    required this.music,
    required this.artist,
    required this.preview,
  });
}

class ActionsFetch {
  String discordID = "";

  Future<int> fetchLogin(String login, String password, dynamic context) async {
    final response = await http.get(
        Uri.parse('https://areachad.herokuapp.com/user/login?mail=' +
            login +
            '&pass=' +
            password),
        headers: {
          "Access-Control_Allow-Origin": "*",
          "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
        });

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

  Future<Spotify> fetchSpotify() async {
    final response = await http.get(Uri.parse(
        'https://areachad.herokuapp.com/data/spotify/listening?mail=' +
            settings.mail_actu));

    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    if (response.statusCode == 200) {
      final spotifyBody = jsonDecode(response.body);
      print(spotifyBody['item']['name'].toString());
      print(spotifyBody['item']['artists'][0]['name'].toString());
      print(spotifyBody['item']['preview_url'].toString());
      var spotify = Spotify(
          music: spotifyBody['item']['name'].toString(),
          artist: spotifyBody['item']['artists'][0]['name'].toString(),
          preview: spotifyBody['item']['preview_url'].toString());

      return spotify;
    } else {
      const spotify = Spotify(music: "", artist: "", preview: "");

      return spotify;
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

  Future<Zelda> fetchZelda(String name) async {
    final response = await http.get(Uri.parse(
        'https://areachad.herokuapp.com/data/zelda/getitem?name=' + name));

    if (response.statusCode == 200) {
      print(response.body);

      final data = jsonDecode(response.body);
      final zelda = Zelda(
          name: data['name'].toString(),
          description: data['description'].toString());

      return zelda;
    } else {
      const zelda = Zelda(name: "", description: "");

      return zelda;
    }
  }

  Future<News> fetchNews() async {
    final response = await http
        .get(Uri.parse('https://areachad.herokuapp.com/data/crypto/trending'));

    if (response.statusCode == 200) {
      print(response.body);

      final data = jsonDecode(response.body);
      final news = News(
          name: data['name'].toString(),
          description: data['description'].toString());

      return news;
    } else {
      const news = News(name: "", description: "");

      return news;
    }
  }

  Future<List<Crypto>> fetchCrypto() async {
    final response = await http
        .get(Uri.parse('https://areachad.herokuapp.com/data/crypto/news'));

    if (response.statusCode == 200) {
      print(response.body);

      final data = jsonDecode(response.body);
      List<Crypto> cryptoList = [];
      for (int i = 0; i <= 10; i++) {
        final crypto = Crypto(
            title: data[i]['title'].toString(),
            url: data[i]['url'].toString(),
            source: data[i]['source'].toString());
        cryptoList.add(crypto);

        print("!! " + data[i]['title'].toString());
        print("!! " + data[i]['url'].toString());
        print("!! " + data[i]['source'].toString());
      }

      return cryptoList;
    } else {
      List<Crypto> crypto = [];
      //const crypto = Crypto(title: "", url: "", source: "");

      return crypto;
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

  Future<void> fetchNewsReddit(String mail, bool state) async {
    final response = await http.get(Uri.parse(
        'https://areachad.herokuapp.com/area/reddit/pingnewpost?mail=' +
            mail +
            '&state=' +
            state.toString()));

    // in progress
    if (response.statusCode == 200) {
      print(response.body);
      return;
    } else {
      return;
    }
  }

  Future<void> fetchDiscord(String message, String time) async {
    final response = await http.get(Uri.parse(
        'https://areachad.herokuapp.com/area/time/discord?mail=' +
            settings.mail_actu +
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

  Future<void> fetchDiscordBot() async {
    final response = await http.get(Uri.parse(
        'https://areachad.herokuapp.com/tests/discord?mail=' +
            settings.mail_actu));

    // in progress
    if (response.statusCode == 200) {
      print(response.body);
      return;
    } else {
      return;
    }
  }
}
