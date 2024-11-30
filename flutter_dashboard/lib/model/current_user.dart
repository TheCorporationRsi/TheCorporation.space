import 'package:corp_api/corp_api.dart';
import 'package:flutter_dashboard/main.dart';
import 'package:built_collection/built_collection.dart';

String rsiHandle = "loading";
String rsiMoniker = "loading";
String profilePicture = "https://www.gravatar.com/avatar/2c7d99fe281ecd3bcd65ab915bac6dd5?s=250";

BuiltList<GetUserRoles200ResponseInner> roles = BuiltList<GetUserRoles200ResponseInner>();

GetStatus200Response status = GetStatus200Response();

GetProfile200Response infAccount = GetProfile200Response();

BuiltList<GetUserDivisions200ResponseInner> divisions = BuiltList<GetUserDivisions200ResponseInner>();

BuiltList<GetUserDepartments200ResponseInner> departments = BuiltList<GetUserDepartments200ResponseInner>();

final corpStructureClient = corpApi.getStructureApi();
final corpSecurityClient = corpApi.getSecurityApi();
final corpInfluenceClient = corpApi.getInfluenceSystemApi();

Future<void> update() async {
  await updateUserInfo();
  await updateUserRoles();
  await updateStatus();
  await updateInfAccount();
  await updateUserDepartments();
  await updateUserDivisions();
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
      roles = response.data ?? roles;
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
      status = response.data ?? status;
    }

  } catch (error) {
    print(error);
  }
}

Future<void> updateInfAccount() async {
  final headers = await getAuthHeader();
  try {
    final response = await corpInfluenceClient.getProfile(headers: headers);
    if (response.data != null) {
      infAccount = response.data ?? infAccount;
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
      divisions = response.data ?? divisions;
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
      departments = response.data ?? departments;
    }

  } catch (error) {
    print(error);
  }
}