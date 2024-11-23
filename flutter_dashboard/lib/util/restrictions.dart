import 'package:flutter/material.dart';
import 'package:corp_api/corp_api.dart';
import 'package:dio/dio.dart';

void checkSecurityLevel(BuildContext context, String requiredLevel) {
  
  final api = CorpApi().getSecurityApi();
  
  api.getStatus().then((value) => {

    if ((requiredLevel == "notLoggedIn") & (value.data?.authentificated)) {

    }

    print("Authenticated: ${value.data.authentificated.toString()}" ),
    print("RSI_verified: ${value.data.rSIVerified.toString()}" ),
    print("Authenticated: ${value.data.cORPMember.toString()}" ),
    print("Authenticated: ${value.data.isManager.toString()}" ),
    print("Authenticated: ${value.data.isAdmin.toString()}" ),
  
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





