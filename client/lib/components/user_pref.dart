import 'dart:convert';

import 'package:area/components/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static late SharedPreferences __preferences;
  static const _KeyUser = 'user';

  static const myUser = User(
    profilePic: "https://i.natgeofe.com/n/82fddbcc-4cbb-4373-bf72-dbc30068be60/drill-monkey-01_2x3.jpg",
    username: "Chadi Chado",
    email: "ChaD@gaming.com",
    banner: "https://media.istockphoto.com/photos/colour-smoke-background-horror-halloween-mystery-magic-picture-id1059499980?k=20&m=1059499980&s=170667a&w=0&h=9kPwHbDoPWk5qA1P4Se6TYWMzt7sxcmMcwy6V_nV5pg=",
    hasLoggedInBefore: false,
  );

  static Future init() async =>
    __preferences = await SharedPreferences.getInstance();

  static Future setUser(User user) async {
    final json = jsonEncode(user.toJson());

    await __preferences.setString(_KeyUser, json);
  }

  static User getUser() {
    final json = __preferences.getString(_KeyUser);

    return json == null ? myUser : User.fromJson(jsonDecode(json));
  }
}