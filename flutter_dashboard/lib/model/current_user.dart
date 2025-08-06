import 'package:flutter_dashboard/main.dart';
import 'package:flutter_dashboard/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

ValueNotifier<String> rsiHandle = ValueNotifier("loading");
ValueNotifier<String> rsiMoniker = ValueNotifier("loading");
ValueNotifier<String> profilePicture = ValueNotifier("https://www.gravatar.com/avatar/2c7d99fe281ecd3bcd65ab915bac6dd5?s=250");

ValueNotifier<List<Map<String, dynamic>>> roles = ValueNotifier(<Map<String, dynamic>>[]);
ValueNotifier<Map<String, dynamic>> status = ValueNotifier(<String, dynamic>{});
ValueNotifier<List<Map<String, dynamic>>> divisions = ValueNotifier(<Map<String, dynamic>>[]);
ValueNotifier<List<Map<String, dynamic>>> departments = ValueNotifier(<Map<String, dynamic>>[]);

Future<void> update() async {
  await updateUserInfo();
  await updateUserRoles();
  await updateStatus();
  await updateUserDepartments();
  await updateUserDivisions();
}

Future<void> logout() async {
  try {
    final apiService = ServiceLocator().corpApiService;
    await apiService.logout();
    await secureStorage.delete(key: "corp_refresh_pass");
    await secureStorage.delete(key: "corp_access_pass");
    navigatorKey.currentState?.pushNamed('/login');
  } catch (error) {
    print(error);
  }
}

Future<void> updateUserInfo() async {
  try {
    final apiService = ServiceLocator().corpApiService;
    final response = await apiService.getUserProfile();
    
    if (response.data != null) {
      final data = response.data as Map<String, dynamic>;
      print('User profile response: $data'); // Debug output
      
      // Check multiple possible field names for RSI handle
      rsiHandle.value = data['RSI_handle'] ?? data['rsi_handle'] ?? data['handle'] ?? rsiHandle.value;
      
      // Check multiple possible field names for moniker
      rsiMoniker.value = data['moniker'] ?? data['nickname'] ?? data['display_name'] ?? rsiMoniker.value;
      
      // Check multiple possible field names for profile picture
      String? pictureUrl = data['picture'] ?? data['profile_picture'] ?? data['avatar'] ?? data['image'];
      if (pictureUrl != null && pictureUrl.isNotEmpty) {
        profilePicture.value = pictureUrl;
      }
      
      print('Updated RSI Handle: ${rsiHandle.value}');
      print('Updated RSI Moniker: ${rsiMoniker.value}');
      print('Updated Profile Picture: ${profilePicture.value}');
    }
  } catch (error) {
    print('Error updating user info: $error');
  }
}

Future<void> updateUserRoles() async {
  try {
    final apiService = ServiceLocator().corpApiService;
    final response = await apiService.getUserRoles();
    if (response.data != null) {
      roles.value = List<Map<String, dynamic>>.from(response.data);
    }
  } catch (error) {
    print(error);
  }
}

Future<void> updateStatus() async {
  try {
    print('Attempting to get user status...');
    final apiService = ServiceLocator().corpApiService;
    final response = await apiService.getStatus();
    print('Status response received with status code: ${response.statusCode}');
    
    if (response.data != null) {
      status.value = Map<String, dynamic>.from(response.data);
      print('User status response: ${response.data}'); // Debug output
      print('Corp member status: ${status.value['corp_member']} (${status.value['corp_member'].runtimeType})');
      print('cORP member status: ${status.value['cORP_member']} (${status.value['cORP_member'].runtimeType})');
    } else {
      print('Status response data is null');
    }
  } catch (error) {
    print('Error in updateStatus: $error');
    if (error.toString().contains('401')) {
      print('401 Unauthorized error detected in status update - authentication token may be invalid');
      // Set a default empty status to prevent null errors
      status.value = <String, dynamic>{};
    }
  }
}

Future<void> updateUserDivisions() async {
  try {
    final apiService = ServiceLocator().corpApiService;
    final response = await apiService.getUserDivisions();
    
    if (response.data != null) {
      divisions.value = List<Map<String, dynamic>>.from(response.data);
    }
  } catch (error) {
    print(error);
  }
}

Future<void> updateUserDepartments() async {
  try {
    final apiService = ServiceLocator().corpApiService;
    final response = await apiService.getUserDepartments();
    
    if (response.data != null) {
      departments.value = List<Map<String, dynamic>>.from(response.data);
    }
  } catch (error) {
    print(error);
  }
}

Future<void> joinDivision(String title) async {
  try {
    final apiService = ServiceLocator().corpApiService;
    final response = await apiService.joinDivision(divisionTitle: title);
    
    if (response.data != null && response.data['msg'] == "Division joined") {
      await update();
    }
  } catch (error) {
    print(error);
  }
}

Future<void> leaveDivision(String title) async {
  try {
    final apiService = ServiceLocator().corpApiService;
    final response = await apiService.leaveDivision(divisionTitle: title);
    
    if (response.data != null && response.data['msg'] == "Division left") {
      await update();
    }
  } catch (error) {
    print(error);
  }
}

Future<void> setWeights(List<Map<String, dynamic>> divisions) async {
  try {
    final apiService = ServiceLocator().corpApiService;
    final weightsData = divisions.map((division) => {
      'title': division['title'],
      'amount': division['weight']
    }).toList();
    
    final response = await apiService.setWeights(weights: weightsData);
    
    if (response.data != null && response.data['msg'] == "Weights updated!") {
      await update();
    }
  } catch (error) {
    print(error);
  }
}

String _hashPassword(String password) {
  var bytes = utf8.encode(password);
  var digest = sha256.convert(bytes);
  return digest.toString();
}

Future<void> changePassword({
  required String currentPassword,
  required String newPassword,
  required String confirmedPassword
}) async {
  try {
    final apiService = ServiceLocator().corpApiService;
    
    await apiService.changePassword(
      currentPassword: _hashPassword(currentPassword),
      newPassword: _hashPassword(newPassword),
      confirmedPassword: _hashPassword(confirmedPassword),
    );
  } catch (error) {
    print(error);
  }
}

// Returns true if the current user is a manager, false otherwise.
bool isCurrentUserManager() {
  return status.value['is_manager'] == true;
}
