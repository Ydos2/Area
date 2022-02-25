// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class HomeMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(
            horizontal: 70.0,
            vertical: 50.0
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17.0)
          ),
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal:30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Sign in",
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 50.0),
                buildCustomTextField("Email address", "you@example.com", false),
                SizedBox(height: 20.0),
                buildCustomTextField("Password", "Insert your password", true),
                SizedBox(height: 15.0),
                Align(
                  alignment: Alignment.topRight,
                  child: FlatButton(
                    onPressed: (){},
                    child:Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                SizedBox(height:20.0),
                Container(
                  width: double.infinity,
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {},
                    color: Color(0xFFF3630B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                        topLeft: Radius.circular(25),
                      )
                    ),
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Center(
                  child: RichText(
                    text: TextSpan(children : [
                      TextSpan(
                        text: "Don't have an account?",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      ),
                      TextSpan(
                        text: "Sign up",
                        style: TextStyle(
                          color: Color(0xFFF36308),
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget buildCustomTextField(String title, String hinText, bool isPassword){
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontSize: 15, color: Colors.black),
        ),
        TextFormField(
          obscureText: isPassword,
          cursorColor: Color(0xFFF36308),
          decoration: InputDecoration(
            hintText: hinText,
          )
        )
      ]
    );
  }
}