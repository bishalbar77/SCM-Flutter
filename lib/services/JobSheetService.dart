import 'dart:convert';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:scm/models/AddNewJobsheet.dart';
import 'package:scm/models/ApiResponse.dart';
import 'package:scm/models/Job.dart';
import 'package:scm/models/JobStatusUpdate.dart';
import 'package:scm/models/Jobsheet.dart';
import 'package:scm/models/Login.dart';
import 'package:scm/models/ProductInfo.dart';
import 'package:scm/models/User.dart';
import 'package:scm/views/ManageJobsheet.dart';
import 'package:scm/views/main.dart';

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

  Future<ApiResponse<Job>> getJob(int JobID) {
    return http.get(API + '/getsinglejobsheet/' + JobID.toString(), headers: headers).then((data){
      if(data.statusCode==200) {
        final jsonData = json.decode(data.body);
          return ApiResponse<Job>( data: Job.fromJson(jsonData) );
      }
      return ApiResponse<Job>(error: true, errorMessage: 'An error occurred' );
    })
        .catchError((_) => ApiResponse<Job>(error: true, errorMessage: 'No internet connection found' ));
  }

  Future<ApiResponse<ProductInfo>> getproduct(int JobID) {
    return http.get(API + '/getsinglejobsheetinfo/' + JobID.toString(), headers: headers).then((data){
      if(data.statusCode==200) {
        final jsonData = json.decode(data.body);
        return ApiResponse<ProductInfo>( data: ProductInfo.fromJson(jsonData) );
      }
      return ApiResponse<ProductInfo>(error: true, errorMessage: 'An error occurred' );
    })
        .catchError((_) => ApiResponse<ProductInfo>(error: true, errorMessage: 'No internet connection found' ));
  }

  Future<ApiResponse<bool>> manageJob(JobStatusUpdate item) {
    return http.post(API + '/change_job_status', headers: headers, body: json.encode(item.toJson())).then((data){
      if(data.statusCode==200) {
        {
          return ApiResponse<bool>( data: true );
        }
      }
      return ApiResponse<bool>(error: true, errorMessage: 'An error occurred' );
    })
        .catchError((_) => ApiResponse<bool>(error: true, errorMessage: 'No internet connection found' ));
  }

  Future<ApiResponse<bool>> addJob(AddNewJobsheet item) {
    return http.post(API + '/postjobsheet', headers: headers, body: json.encode(item.toJson())).then((data){
      if(data.statusCode==200) {
        {
          return ApiResponse<bool>( data: true );
        }
      }
      return ApiResponse<bool>(error: true, errorMessage: 'An error occurred' );
    })
        .catchError((_) => ApiResponse<bool>(error: true, errorMessage: 'No internet connection found' ));
  }

  Future<ApiResponse<Login>> loginEmail(Login item) {
    return http.post(API + '/login-by-email' , headers: headers, body: json.encode(item.toJson())).then((data) async {
      if(data.statusCode==200)
      {
        final jsonData = json.decode(data.body);
        var session = FlutterSession();
        await session.set("name", jsonData['name']);
        await session.set("id", jsonData['id']);
        await session.set("email", jsonData['email']);
        print(session.get('email'));
        return ApiResponse<Login>( data: Login.fromJson(jsonData) );
      }
      return ApiResponse<Login>(error: true, errorMessage: 'An error occurred');
    })
        .catchError((_) => ApiResponse<Login>(error: true, errorMessage: 'No internet connection found'));
  }
  Future<ApiResponse<User>> userData(String userId) {
    return http.get('http://asquareservicepro.com/api/userData/${userId.replaceAll(new RegExp(r"\s+\b|\b\s"), "")}', headers: headers).then((data){
      if(data.statusCode==200) {
        print(data.statusCode);
        final jsonData = json.decode(data.body);
        return ApiResponse<User>( data: User.fromJson(jsonData) );
      }
      return ApiResponse<User>(error: true, errorMessage: 'http://asquareservicepro.com/api/userData/'+userId );
    })
        .catchError((_) => ApiResponse<User>(error: true, errorMessage: 'No internet connection found' ));
  }
}
