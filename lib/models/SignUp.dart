import 'package:flutter/cupertino.dart';

class Sign {
  String name;
  String phone;
  String fname;
  String email;
  String gst;

  Sign ({
    @required this.name,
    @required this.phone,
    @required this.fname,
    @required this.email,
    @required this.gst,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "phone" : phone,
      "fname": fname,
      "email" : email,
      "gst": gst,
    };
  }
  factory Sign.fromJson(Map<String, dynamic> item) {
    return Sign(
        name: item['name'],
        phone: item['phone'],
        fname: item['fname'],
        email: item['email'],
        gst: item['gst']
    );
  }
}