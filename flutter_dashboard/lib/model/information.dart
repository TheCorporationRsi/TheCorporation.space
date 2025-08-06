import 'package:flutter/material.dart';
import 'package:flutter_dashboard/services/service_locator.dart';

ValueNotifier<List<Map<String, dynamic>>> departments =
    ValueNotifier([]);

ValueNotifier<List<Map<String, dynamic>>> divisions =
    ValueNotifier([]);

ValueNotifier<List<Map<String, dynamic>>> roles =
    ValueNotifier([]);

Future<void> update() async {
  await updateDepartments();
  await updateDivisions();
  await updateRoles();
}

Future<void> updateDepartments() async {
  try {
    final apiService = ServiceLocator().corpApiService;
    final response = await apiService.getDepartments();
    if (response.data is List) {
      departments.value = List<Map<String, dynamic>>.from(response.data);
    }
  } catch (error) {
    print('Error updating departments: $error');
  }
}

Future<void> updateDivisions() async {
  try {
    final apiService = ServiceLocator().corpApiService;
    final response = await apiService.getDivisions();
    if (response.data is List) {
      divisions.value = List<Map<String, dynamic>>.from(response.data);
    }
  } catch (error) {
    print('Error updating divisions: $error');
  }
}

Future<void> updateRoles() async {
  try {
    final apiService = ServiceLocator().corpApiService;
    final response = await apiService.getRoles();
    if (response.data is List) {
      roles.value = List<Map<String, dynamic>>.from(response.data);
    }
  } catch (error) {
    print('Error updating roles: $error');
  }
}
