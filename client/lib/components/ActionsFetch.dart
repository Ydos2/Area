import 'package:http/http.dart' as http;

class ActionsFetch {
  /*function getAllUsers(login, password) {
    return new Promise(function (resolve, reject) {
        axios.get('http://localhost:8080/login?mail=' + login + '&pass=' + password).then(res => {
            resolve(res)
        }).catch((err) => setImmediate(() => { reject(err) }))
    })
  }*/

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
      //throw Exception('Failed to load album');
    }
  }
}
