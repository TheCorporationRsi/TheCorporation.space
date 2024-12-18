import 'package:corp_api/corp_api.dart';
import 'package:flutter_dashboard/main.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';

String rsiHandle = "loading";
String rsiMoniker = "loading";
String profilePicture = "https://www.gravatar.com/avatar/2c7d99fe281ecd3bcd65ab915bac6dd5?s=250";

ValueNotifier<BuiltList<GetUserRoles200ResponseInner>> roles = ValueNotifier(BuiltList<GetUserRoles200ResponseInner>());

ValueNotifier<GetStatus200Response> status = ValueNotifier(GetStatus200Response());

ValueNotifier<BuiltList<GetUserDivisions200ResponseInner>> divisions = ValueNotifier(BuiltList<GetUserDivisions200ResponseInner>());

ValueNotifier<BuiltList<GetUserDepartments200ResponseInner>> departments = ValueNotifier(BuiltList<GetUserDepartments200ResponseInner>());

final corpStructureClient = corpApi.getStructureApi();
final corpSecurityClient = corpApi.getSecurityApi();



Future<void> update() async {
  await updateUserInfo();
  await updateUserRoles();
  await updateStatus();
  await updateUserDepartments();
  await updateUserDivisions();

}

Future<void> logout() async {
  final headers = await getAuthHeader();
  try {
    await corpSecurityClient.logout(headers: headers);
    await secureStorage.delete(key: "corp_refresh_pass");
    await secureStorage.delete(key: "corp_access_pass");
    navigatorKey.currentState?.pushNamed('/login');
  } catch (error) {
    print(error);
  }
}


Future<void> updateUserInfo() async {
  final headers = await getAuthHeader();
  try {
    final response = await corpStructureClient.getUserProfile(headers: headers);
    
    if (response.data != null) {
      rsiHandle = response.data!.rSIHandle ?? rsiHandle;
      rsiMoniker = response.data!.moniker ?? rsiMoniker;
      profilePicture = response.data!.picture ?? profilePicture;
    }

  } catch (error) {
    print(error);
  }
}

Future<void> updateUserRoles() async {
  final headers = await getAuthHeader();
  try {
    final response = await corpStructureClient.getUserRoles(headers: headers);
    if (response.data != null) {
      roles.value = response.data ?? roles.value;
    }

  } catch (error) {
    print(error);
  }
}


Future<void> updateStatus() async {
  final headers = await getAuthHeader();
  try {
    final response = await corpSecurityClient.getStatus(headers: headers);
    if (response.data != null) {
      status.value = response.data ?? status.value;
    }

  } catch (error) {
    print(error);
  }
}



Future<void> updateUserDivisions() async {
  final headers = await getAuthHeader();
  try {
    final response = await corpStructureClient.getUserDivisions(headers: headers);
    
    if (response.data != null) {
      divisions.value = response.data ?? divisions.value;
    }

  } catch (error) {
    print(error);
  }
}


Future<void> updateUserDepartments() async {
  final headers = await getAuthHeader();
  try {
    final response = await corpStructureClient.getUserDepartments(headers: headers);
    
    if (response.data != null) {
      departments.value = response.data ?? departments.value;
    }

  } catch (error) {
    print(error);
  }
}


Future<void> joinDivision(String title) async {
  final headers = await getAuthHeader();
  final DeleteDivisionRequest deleteDivisionRequest = DeleteDivisionRequest((b) => b
      ..divisionTitle = title);
  try {
    final response = await corpStructureClient.joinDivision(headers: headers,deleteDivisionRequest: deleteDivisionRequest);
    
    if (response.data!.msg == "Division joined") {
      await update();
    }

  } catch (error) {
    print(error);
  }
}

Future<void> leaveDivision(String title) async {
  final headers = await getAuthHeader();
  final DeleteDivisionRequest deleteDivisionRequest = DeleteDivisionRequest((b) => b
      ..divisionTitle = title);
  try {
    final response = await corpStructureClient.leaveDivision(headers: headers, deleteDivisionRequest: deleteDivisionRequest);
    
    if (response.data!.msg == "Division left") {
      await update();
    }

  } catch (error) {
    print(error);
  }
}

Future<void> setWeights(String title) async {
  final headers = await getAuthHeader();
  final DeleteDivisionRequest deleteDivisionRequest = DeleteDivisionRequest((b) => b
      ..divisionTitle = title);
  try {
    final response = await corpStructureClient.leaveDivision(headers: headers, deleteDivisionRequest: deleteDivisionRequest);
    
    if (response.data!.msg == "Division left") {
      await update();
    }

  } catch (error) {
    print(error);
  }
}