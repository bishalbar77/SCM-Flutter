import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:scm/models/ApiResponse.dart';
import 'package:scm/models/Job.dart';
import 'package:scm/models/Jobsheet.dart';
Map request = {
  'id': 3,
};
class JobSheetService {

  static const API = 'http://asquareservicepro.com/api';
  static const headers = {
     'Content-Type': 'application/json'
  };
  String body = json.encode(request);
  Future<ApiResponse<List<Jobsheet>>> getJobSheet() {
    return http.post(API + '/getjobsheet', headers: headers, body: body).then((data){
      if(data.statusCode==200) {
        final jsonData = json.decode(data.body);
        final jobs = <Jobsheet>[];
        for(var item in jsonData)
          {
            jobs.add(Jobsheet.fromJson(item));
          }
        return ApiResponse<List<Jobsheet>>( data: jobs );
      }
      return ApiResponse<List<Jobsheet>>(error: true, errorMessage: 'An error occurred' );
    })
    .catchError((_) => ApiResponse<List<Jobsheet>>(error: true, errorMessage: 'No internet connection found' ));
  }

  Future<ApiResponse<Job>> getJob(String JobID) {
    return http.get(API + '/getsinglejobsheet/' + JobID, headers: headers).then((data){
      if(data.statusCode==200) {
        final jsonData = json.decode(data.body);
        for(var item in jsonData)
        {
          return ApiResponse<Job>( data: Job.fromJson(item) );
        }
      }
      return ApiResponse<Job>(error: true, errorMessage: 'An error occurred' );
    })
        .catchError((_) => ApiResponse<Job>(error: true, errorMessage: 'No internet connection found' ));
  }

  Future<ApiResponse<Job>> manageJob(String JobID) {
    return http.get(API + '/getsinglejobsheet/' + JobID, headers: headers).then((data){
      if(data.statusCode==200) {
        final jsonData = json.decode(data.body);
        for(var item in jsonData)
        {
          return ApiResponse<Job>( data: Job.fromJson(item) );
        }
      }
      return ApiResponse<Job>(error: true, errorMessage: 'An error occurred' );
    })
        .catchError((_) => ApiResponse<Job>(error: true, errorMessage: 'No internet connection found' ));
  }
}
