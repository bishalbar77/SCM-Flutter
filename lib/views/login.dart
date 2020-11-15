import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:scm/models/Login.dart';
import 'package:scm/services/JobSheetService.dart';
import 'package:scm/views/SignIn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
 var userData;
  JobSheetService get service =>  GetIt.I<JobSheetService>();
  Login login = new Login();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

 void initState() {
   _getUserInfo();

   print("Data is here ");
   super.initState();
 }

 void _getUserInfo() async {
   setState(() {
     _isLoading = true;
   });
   SharedPreferences localStorage = await SharedPreferences.getInstance();
   var email = localStorage.getString("email");
   setState(() {
     userData = email;
   });
   if(userData!=null) {
     Navigator.of(context)
         .pushReplacement(MaterialPageRoute(builder: (__) => Homepage(email: userData,)));
   }
   else {
     setState(() {
       _isLoading = false;
     });
   }
 }

  Widget build(BuildContext context) {
    //object
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        body: _isLoading ?
        Container(
          color: Colors.white70.withOpacity(0.3),
          width: MediaQuery.of(context).size.width,//70.0,
          height: MediaQuery.of(context).size.height, //70.0,
          child: new Padding(
              padding: const EdgeInsets.all(5.0),
              child: new Center(child: new CircularProgressIndicator())),
        )
            : Container(
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
              SizedBox(height: 10,), //distance from top
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
                                  controller: _emailController,
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
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  obscureText: true,
                                  controller: _passwordController,
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
                              borderRadius: BorderRadius.circular(80),
                              color: Colors.blue[700]
                          ),
                          child: RaisedButton(
                            child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold ),),
                            color: Theme.of(context).primaryColor,
                              onPressed: () async {
                                setState(() {
                                  _isLoading= true;
                                });
                                final login = Login(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                                final result = await service.loginEmail(login);
                                setState(() {
                                  _isLoading= false;
                                });
                                final title = result.error ? 'Access Denied' : 'Access Granted';
                                final text = result.error ? (result.errorMessage ?? "Sorry! Credentials didn't match." ): "Login successful";
                                if(text=='Login successful') {
                                  showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        title: Text(title),
                                        content: Text(text),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text('Ok'),
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(builder: (__) => Homepage(email: _emailController.text,)));
                                            },
                                          )
                                        ],
                                      )
                                  )
                                      .then((data) {
                                    if (!result.error) {
                                      Navigator.of(context).pop();
                                    }
                                  });
                                } //end if
                                else {
                                  showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        title: Text(title),
                                        content: Text(text),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text('Ok'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      )
                                  )
                                      .then((data) {
                                    if (!result.error) {
                                      Navigator.of(context).pop();
                                    }
                                  });
                                } //end else
                              }
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
                          child: RaisedButton(
                            child: Text("Sign up", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold ),),
                              color: Theme.of(context).errorColor,
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (__) => SignPage()));
                              }
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
      ),
    );
  }
}