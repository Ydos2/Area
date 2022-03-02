import 'package:area/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final _googleSignin = GoogleSignIn();
  var account = Rx<GoogleSignInAccount?>(null);

  login(context) async {
    account.value = await _googleSignin.signIn().then(
      (value) {
        print(value?.displayName);
        if (value != null) {
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
  }

  logout() async {
    account.value = await _googleSignin.signOut();
  }
}
