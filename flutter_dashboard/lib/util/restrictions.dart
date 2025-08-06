import 'package:flutter/material.dart';
import 'package:flutter_dashboard/services/service_locator.dart';

Future<void> checkSecurityLevel(BuildContext context, String requiredLevel) async {
  
  bool? authentificated = false;
  bool? rsi_verified = false;
  bool? corp_member = false;
  bool? isManager = false;
  bool? isAdmin = false;

  try {
    final apiService = ServiceLocator().corpApiService;
    final response = await apiService.getStatus();
    
    final statusData = response.data as Map<String, dynamic>;

    authentificated = statusData['authentificated'];
    rsi_verified = statusData['RSI_verified'];
    corp_member = statusData['corp_member'];
    isManager = statusData['is_manager'];
    isAdmin = statusData['is_admin'];

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





