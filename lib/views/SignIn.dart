import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:scm/models/Login.dart';
import 'package:scm/models/SignUp.dart';
import 'package:scm/services/JobSheetService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'login.dart';

class SignPage extends StatefulWidget {
  @override
  _SignPageState createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  var userData;
  JobSheetService get service =>  GetIt.I<JobSheetService>();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController fname = TextEditingController();
  TextEditingController gst = TextEditingController();
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
    return Scaffold(
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
                  Colors.deepOrange[900],
                  Colors.deepOrange[700],
                  Colors.deepOrange[300]
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
                  Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 40),),
                  SizedBox(height: 10,),  //created a space between these 2 TEXT
                  Text("Create an account", style: TextStyle(color: Colors.white, fontSize: 19),)
                ],
              ),
            ),
            SizedBox(height: 5,), //white box top padding

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
                    children: <Widget>[  //height of username bar from Expanded
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
                                controller: name,
                                decoration: InputDecoration(
                                  hintText: "Name",
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
                                controller: phone,
                                decoration: InputDecoration(
                                  hintText: "Phone Number",
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
                                controller: fname,
                                decoration: InputDecoration(
                                  hintText: "Business Name",
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
                                controller: email,
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
                                controller: gst,
                                decoration: InputDecoration(
                                  hintText: "GST/PAN Number",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        height: 45,
                        margin: EdgeInsets.symmetric(horizontal: 65),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80),
                            color: Colors.deepOrange[700]
                        ),
                        child: RaisedButton(
                            child: Text("Create Account", style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold ),),
                            color: Colors.red,
                            onPressed: () async {
                              setState(() {
                                _isLoading= true;
                              });
                              final login = Sign(
                                name: name.text,
                                phone: phone.text,
                                email: email.text,
                                fname: fname.text,
                                gst: gst.text,
                              );
                              final result = await service.signUp(login);
                              setState(() {
                                _isLoading= true;
                              });
                              final title = 'Access';
                              final text = result.error ? (result.errorMessage ?? "Something went wrong." ): "Account created successful";
                              if(text=='Account created successfully') {
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
                                                .push(MaterialPageRoute(builder: (__) => Homepage(email: email.text,)));
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
                            color: Colors.deepOrange[700]
                        ),
                        child: RaisedButton(
                            child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold ),),
                            color: Theme.of(context).primaryColor,
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (__) => LoginPage()));
                            }
                        ),
                      ),
                      SizedBox(height: 10,),
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