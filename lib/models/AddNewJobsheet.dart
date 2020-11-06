import 'package:flutter/cupertino.dart';

class AddNewJobsheet {
  String id;
  String first_name;
  String last_name;
  String email;
  String phone;
  String jb_no;
  DateTime jb_date;
  String pd_type;
  String brand;
  String md_name;
  String md_no;
  String dv_config;
  String dv_pwd;
  String sr_no;
  String problem;
  String py_status;
  String remarks;
  String item_name;
  String item_ref_number;
  String selectservice;
  String warrantystatus;

  AddNewJobsheet({
    @required this.id,
    @required this.first_name,
    @required this.last_name,
    @required this.email,
    @required this.phone,
    @required this.pd_type,
    @required this.jb_no,
    @required this.jb_date,
    @required this.brand,
    @required this.md_name,
    @required this.md_no,
    @required this.dv_config,
    @required this.dv_pwd,
    @required this.sr_no,
    @required this.problem,
    @required this.py_status,
    @required this.remarks,
    @required this.item_name,
    @required this.item_ref_number,
    @required this.selectservice,
    @required this.warrantystatus,
  });


  Map<String, dynamic> toJson() {
    return {
      "id" : id,
      "first_name": first_name,
      "last_name" : last_name,
      "email" : email,
      "phone": phone,
      "pd_type" : pd_type,
      "jb_no": jb_no,
      "jb_date" : DateTime.now().toString(),
      "brand" : brand,
      "md_name": md_name,
      "md_no" : md_no,
      "dv_pwd" : dv_pwd,
      "dv_config": dv_config,
      "sr_no" : sr_no,
      "problem": problem,
      "py_status" : py_status,
      "remarks" : remarks,
      "item_name" : item_name,
      "item_ref_number" : item_ref_number,
      "sr_type": selectservice,
      "warranty" : warrantystatus,
    };
  }
}