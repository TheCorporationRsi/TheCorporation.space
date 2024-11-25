import 'package:flutter/material.dart';
import 'package:corp_api/corp_api.dart';
import 'package:dio/dio.dart';

void checkSecurityLevel(BuildContext context, String requiredLevel) {
  

  bool authentificated = false;
  bool rsi_verified = false;
  bool corp_member = false;
  bool isManager = false;
  bool isAdmin = false;
  
  var corpSecurityClient = CorpApi().getSecurityApi();
  corpSecurityClient.getStatus().then((response) =>  {

    authentificated = response.data!.authentificated,
    rsi_verified = response.data!.rSIVerified,
    corp_member = response.data!.cORPMember,
    isManager = response.data!.isManager,
    isAdmin = response.data!.isAdmin,

    if ((requiredLevel == "notLoggedIn") & (authentificated != false)) {
      print('Already logged in'),
      Navigator.pushNamed(context, '/dashboard')
    }
    else if ((requiredLevel == "authentificated") & (authentificated != true)){
      print('Not logged in'),
      Navigator.pushNamed(context, '/login')
    }
    else if ((requiredLevel == "rsiVerified") & (rsi_verified != true)){
      print('Not verified'),
      Navigator.pushNamed(context, '/verification')
    }
    else if ((requiredLevel == "corpMember") & (corp_member != true)){
      print('Not corp member'),
      Navigator.pushNamed(context, '/dashboard')
    }
    else if ((requiredLevel == "isManager") & (isManager != true)){
      print('Not manager'),
      Navigator.pushNamed(context, '/dashboard')
    }
    else if ((requiredLevel == "isAdmin") & (isAdmin != true)){
      print('Not admin'),
      Navigator.pushNamed(context, '/dashboard')
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





