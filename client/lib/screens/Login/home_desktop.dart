import 'package:flutter/material.dart';

class HomeDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Card(
          elevation: 5,
          margin: EdgeInsets.symetric(horizontal: 130, vertical: 25),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
          child: Container(
            width: double.infinity,
            height: 650.0,
            child: Padding(
              padding: EdgeInsets.all(35.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                    padding: EdgeInsets.symetric(horizontal: 18.0),
                      child: Column(
                        crossAxisAlignment: crossAxisAlignment.start,
                        mainAxisALignment: mainAxisALignment.center,
                        children: <Widget>[
                          Text(
                            "Sign In",
                            style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizeBox(height:50.0),
                          buildCustomTextField(
                            "Email address", "you@example.com", false),
                          SizeBox(height: 25),
                          buildCustomTextField(
                            "Password", "Insert your password", true),
                          SizeBox(height:25),
                          Align(
                            alignment: Alignment.topRight,
                            child: FlatButton(
                              onPressed: (){},
                              child:Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          SizeBox(height:30),
                          Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25),
                                topLeft: Radius.circular(25),
                              )
                            ),
                            child: RaisedButton(
                              onPressed: (){},
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(25),
                                  bottomRight: Radius.circular(25),
                                  topLeft: Radius.circular(25),
                                )
                              ),
                              color: Colors(0xFFF3630B),
                              child: Text(
                                "Sign in",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          SizeBox(height: 23.0),
                          Center(
                            child: RichText(
                              text: TextSpan(children : [
                                TextSpan(
                                  text: "Don't have an account?",
                                  style: TextStyle(
                                    colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                                TextSpan(
                                  text: "Sign up",
                                  style: TextStyle(
                                    color: Color(0xFFF36308),
                                    fontSize: 18,
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizeBox(width: 25),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Material(
                        borderRadius: BorderRadius.circular(17.0),
                        child: Image.asset(
                          "images/pluto.png",
                          fit: BoxFit.cover,
                          height: double.infinity,
                          width: double.infinity,
                        ),
                      )
                    )
                  )
                ]
              )
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