import 'package:corp_api/corp_api.dart';
import 'package:flutter_dashboard/main.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';




ValueNotifier<BuiltList<GetDepartments200ResponseInner>> departments =
    ValueNotifier(BuiltList<GetDepartments200ResponseInner>());

ValueNotifier<BuiltList<GetDivisions200ResponseInner>> divisions =
    ValueNotifier(BuiltList<GetDivisions200ResponseInner>());

ValueNotifier<BuiltList<GetRoles200ResponseInner>> roles =
    ValueNotifier(BuiltList<GetRoles200ResponseInner>());




final corpInformationClient = corpApi.getInformationApi();
final corpStructureClient = corpApi.getStructureApi();

Future<void> update() async {
  await updateDepartments();
  await updateDivisions();
  await updateRoles();
}

Future<void> updateDepartments() async {
  try {
    final response = await corpStructureClient.getDepartments();
    if (response.data != null) {
      departments.value = response.data ?? departments.value;
    }
  } catch (error) {
    print(error);
  }
}


Future<void> updateDivisions() async {
  try {
    final response = await corpStructureClient.getDivisions();
    if (response.data != null) {
      divisions.value = response.data ?? divisions.value;
    }
  } catch (error) {
    print(error);
  }
}

Future<void> updateRoles() async {
  try {
    final response = await corpStructureClient.getRoles();
    if (response.data != null) {
      roles.value = response.data ?? roles.value;
    }
  } catch (error) {
    print(error);
  }
}
