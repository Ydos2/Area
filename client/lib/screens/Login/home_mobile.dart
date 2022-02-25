import 'package:flutter/material.dart';

class HomeMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          elevation: 5,
          margin: EdgeInsets.symetric(
            horizontal: 70.0,
            vertical: 50.0
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17.0)
          ),
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.symetric(horizontal:30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisALignment: MainAxisALignment.center,
              children: <Widget>[
                Text(
                  "Sign in",
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizeBox(height: 50.0),
                buildCustomTextField("Email address", "you@example.com", false),
                SizeBox(height: 20,0),
                buildCustomTextField("Password", "Insert your password", true),
                SizeBox(height: 15.0),
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
                SizeBox(height:20.0),
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
                SizeBox(height: 20.0),
                Center(
                  child: RichText(
                    text: TextSpan(children : [
                      TextSpan(
                        text: "Don't have an account?",
                        style: TextStyle(
                          colors.black,
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
            hintText: hintText,
          )
        )
      ]
    )
  }
}