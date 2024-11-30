import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dashboard/main.dart';




Future<void> checkSecurityLevel(BuildContext context, String requiredLevel) async {
  

  bool? authentificated = false;
  bool? rsi_verified = false;
  bool? corp_member = false;
  bool? isManager = false;
  bool? isAdmin = false;

  
  final corpSecurityClient = corpApi.getSecurityApi();

  final headers = await getAuthHeader();

  try {
    final response = await corpSecurityClient.getStatus(headers: headers);

    //print(response);

    authentificated = response.data!.authentificated;
    rsi_verified = response.data!.rSIVerified;
    corp_member = response.data!.cORPMember;
    isManager = response.data!.isManager;
    isAdmin = response.data!.isAdmin;

    if ((requiredLevel == "NotLoggedIn") && (authentificated == true)) {
      print('Already logged in');
      Navigator.pushNamed(context, '/dashboard');
    }
    else if ((requiredLevel == "authentificated") && (authentificated != true)){
      print('Not logged in');
      Navigator.pushNamed(context, '/login');
    }
    else if ((requiredLevel == "rsiVerified") && (rsi_verified != true)){
      if (authentificated == true){
        print('Not verified');
        Navigator.pushNamed(context, '/verification');
      }
      else {
        print('Not logged in');
        Navigator.pushNamed(context, '/login');
      }
    }
    else if ((requiredLevel == "corpMember") && (corp_member != true)){
      print('Not corp member');
      Navigator.pushNamed(context, '/dashboard');
    }
    else if ((requiredLevel == "isManager") && (isManager != true)){
      print('Not manager');
      Navigator.pushNamed(context, '/dashboard');
    }
    else if ((requiredLevel == "isAdmin") && (isAdmin != true)){
      print('Not admin');
      Navigator.pushNamed(context, '/dashboard');
    }
  }
  catch (e) {
    print(e);
    print("Status check failed");
  }

}





