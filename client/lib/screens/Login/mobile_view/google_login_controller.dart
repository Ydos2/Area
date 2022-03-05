// ignore_for_file: non_constant_identifier_names

import 'package:area/components/user.dart';
import 'package:area/components/user_pref.dart';
import 'package:area/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final _googleSignin = GoogleSignIn();
  var account = Rx<GoogleSignInAccount?>(null);
  User user = UserPreferences.getUser();

  login(context) async {
    try {
      account.value = await _googleSignin.signIn().then(
        (value) {
          if (value != null) {
            if (user.hasLoggedInBefore == false) {
              user = user.copy(email: value.email);
              user = user.copy(username: value.displayName);
              value.photoUrl == null
                  ? user =
                      user.copy(profilePic: UserPreferences.myUser.profilePic)
                  : user = user.copy(profilePic: value.photoUrl);
              user = user.copy(hasLoggedInBefore: true);
              user = user.copy(banner: UserPreferences.myUser.banner);
              UserPreferences.setUser(user);
            }
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } else {
            showDialog(
                context: context,
                // ignore: prefer_const_constructors
                builder: (context) => const AlertDialog(
                      title: Center(child: Text('Error')),
                      titleTextStyle: TextStyle(
                        fontFamily: "Raleway",
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ));
          }
        },
      );
    } catch (e) {
      print(e);
    }
  }

  logout() async {
    account.value = await _googleSignin.signOut();
  }
}
