// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:wac_test_001/model/apis/apis.dart';

enum apiMethod {
  get,
  post,
  delete,
  update,
}

class ApiService {
  static Map errorResponse = {};
  static Dio dio = Dio();

  // static Future<void> dioInitializerAndSetter({required String token}) async {
  //   if (token.length > 5) {
  //     String tokenFromShared;
  //     await SharedPreferencesService.prefs.setString("token", token);
  //     tokenFromShared = SharedPreferencesService.prefs.getString("token")!;

  //     print(tokenFromShared);
  //     dio.options.headers['Content-Type'] = 'application/json';
  //     dio.options.headers['Accept'] = 'application/json';
  //     dio.options.headers['Authorization'] = 'Bearer $tokenFromShared';
  //     print(dio.options.headers['Authorization'] = 'Bearer $tokenFromShared');

  //     print("set token");
  //   }
  // }

  ///token remover
  static Future<void> tokenRemover() async {
   
  }

  ///api method set up
  static Future<Response<dynamic>?> apiMethodSetup(
      {required apiMethod method,
      required String url,
      var data,
      var queryParameters,
      Function(int, int)? onSendProgress,
      Function(int, int)? onRecieveProgress,
      Options? options}) async {
   // dio.options.baseUrl = Apis.baseUrl;
    dio.options.connectTimeout = const Duration(milliseconds: 10000);
    dio.options.receiveTimeout = const Duration(milliseconds: 10000);
    // dio.options.headers['Content-Type'] = 'application/json';
    // dio.options.headers['Accept'] = 'application/json';
   // dio.options.contentType = Headers.acceptHeader;
    try {
      Response? response;
      //  int? statusCode;
      switch (method) {
        case apiMethod.get:
          if (data != null) {
            response = await dio.get(url,
                queryParameters: data, options: options ?? Options());
          } else {
            response = await dio.get(url,
                queryParameters: queryParameters,
                options: options ?? Options());
          }
          break;
        case apiMethod.post:
          response = await dio.post(url,
              data: data,
              queryParameters: queryParameters,
              onSendProgress: onSendProgress,
              onReceiveProgress: onRecieveProgress,
              options: options??Options());
          break;
        case apiMethod.delete:
          // ignore: todo
          // TODO: Handle this case.
          break;
        case apiMethod.update:
          response = await dio.put(url,
              data: data,
              queryParameters: queryParameters,
              onSendProgress: onSendProgress,
              onReceiveProgress: onRecieveProgress,
              options: options);
          break;
      }
      return response;
    } on DioError catch (e) {
      print(e);
    
      if (e.response?.statusCode == 401) {
        errorResponse["status"] = "401";
        errorResponse["message"] = "Authorization error";
    
        print(errorResponse);
      } else if (e.response?.statusCode == 500) {
    
      } else if (e.response?.statusCode == 404) {
     
      } else if (e.response?.statusCode == 409) {
     
      } else if (e.type == DioErrorType.receiveTimeout) {
    
      } else if (e.type == DioErrorType.connectionTimeout) {
    
      } else if (e.error is SocketException) {

      } else {
        print("103");
      }
    }
    return null;
  }
}
