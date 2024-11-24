import 'package:flutter/material.dart';
import 'package:corp_api/corp_api.dart';
import 'package:dio/dio.dart';

void verifyCookie() {
  
  final api = CorpApi().getSecurityApi();
  
  
  api.getCookieExpiration().then((response) =>  {
      
      if (response.data!.corpAccessPassExpiration != "expired") {
        print('Cookie expires at: ${response.data!.corpAccessPassExpiration}'),

        if (response.data!.corpRefreshPassExpiration != "expired") {


          //api.refreshToken(headers: {'X-CSRF-TOKEN': csrfToken})
          
        }
        else {
          api.removeCookie()
        }
      }
  
  }).catchError((error) => {
    
    if (error is DioException) {
      print('DioError: ${error.message}'),

      if (error.type == DioExceptionType.connectionTimeout) {
        print('Connection Timeout Exception')
      } 
      else if (error.type == DioExceptionType.sendTimeout) {
        print('Send Timeout Exception')
      } 
      else if (error.type == DioExceptionType.receiveTimeout) {
        print('Receive Timeout Exception')
      } 
      else if (error.type == DioExceptionType.badResponse) {
        print('Response Exception: ${error.response?.statusCode}')
      } 
      else if (error.type == DioExceptionType.cancel) {
        print('Request Cancelled')
      }
    } 
    else {
      print('Unexpected error: $error')
    }
      });

}





