import 'package:flutter/cupertino.dart';

class JobStatusUpdate {
  String ID;
  String jobsheetNumber;
  String job_status;

  JobStatusUpdate({
      @required this.ID,
      @required this.jobsheetNumber,
      @required this.job_status,
    });


  Map<String, dynamic> toJson() {
    return {
      "id" : ID,
      "jobsheetNumber": jobsheetNumber,
      "job_status" : job_status,
    };
  }
}