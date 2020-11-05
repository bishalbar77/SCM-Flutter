import 'package:flutter/cupertino.dart';

class Login {
  int ID;
  String name;
  String email;
  String password;

  Login ({
    this.ID,
    this.name,
    @required this.password,
    @required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password" : password,
    };
  }
  factory Login.fromJson(Map<String, dynamic> item) {
    return Login(
        ID: item['id'],
        name: item['name'],
        email: item['email']
    );
  }
}