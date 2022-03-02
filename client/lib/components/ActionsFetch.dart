import 'package:http/http.dart' as http;
import 'dart:convert';

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

class ActionsFetch {
  Future<int> fetchLogin(String login, String password) async {
    final response = await http.get(Uri.parse(
        'https://areachad.herokuapp.com/user/login?mail=' +
            login +
            '&pass=' +
            password));

    if (response.statusCode == 200) {
      print("Good login");
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
      print("Good register");
      print(response.body);

      final data = jsonDecode(response.body);
      print(data['time'].toString());
      print(data['date'].toString());
      return 0;
    } else {
      print("Not good register");
      return 1;
    }
  }

  Future<Weather> fetchWeather(String place) async {
    final response = await http.get(Uri.parse(
        'https://areachad.herokuapp.com/data/weather?place=' + place));

    if (response.statusCode == 200) {
      print("Good register");
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

      print("Not good register");
      return weather;
    }
  }
}
