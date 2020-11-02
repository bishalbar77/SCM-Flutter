import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  Widget build(BuildContext context) {
    //object
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 30),
        width: double.infinity,
        //Main page background color
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Colors.blue[900],
                  Colors.blue[700],
                  Colors.blue[300]
                ]
            )
        ),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start, //position in X-axis
          children: <Widget>[
            SizedBox(height: 50,), //distance from top
            Padding(
              padding: EdgeInsets.all(30),    //padding from everywhere around
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, //position in X-axis
                children: <Widget>[
                  Text("Login", style: TextStyle(color: Colors.white, fontSize: 40),),
                  SizedBox(height: 10,),  //created a space between these 2 TEXT
                  Text("Welcome back", style: TextStyle(color: Colors.white, fontSize: 19),)
                ],
              ),
            ),
            SizedBox(height: 10,), //white box top padding

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40),
                      bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40), )
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: ListView(
                    children: <Widget>[
                      SizedBox(height: 40,),   //height of username bar from Expanded
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow(
                                color: Color.fromRGBO(135,206,235, .3),
                                blurRadius: 20,
                                offset: Offset(0, 10)
                            )]
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(

                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Email address",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(

                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 35,),
                      Text("Forgot Password?", style: TextStyle(color: Colors.grey),),
                      SizedBox(height: 30,),
                      Container(
                        height: 45,
                        margin: EdgeInsets.symmetric(horizontal: 65),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.blue[700]
                        ),
                        child: Center(
                          child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold ),),
                        ),
                      ),
                      SizedBox(height: 40,),
                      Container(
                        height: 45,
                        margin: EdgeInsets.symmetric(horizontal: 80),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.red[700]
                        ),
                        child: Center(
                          child: Text("Continue with Gmail", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold ),),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}