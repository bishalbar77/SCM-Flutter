import 'package:flutter/cupertino.dart';

class ServiceStatusUpdate {
  String job_id;
  String type_id;
  String remark;

  ServiceStatusUpdate({
    @required this.job_id,
    @required this.type_id,
    @required this.remark,
  });


  Map<String, dynamic> toJson() {
    return {
      "job_id" : job_id,
      "type_id": type_id,
      "remark" : remark,
    };
  }
}