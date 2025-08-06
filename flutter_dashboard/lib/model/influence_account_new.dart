import 'package:flutter_dashboard/services/service_locator.dart';
import 'package:flutter/material.dart';

ValueNotifier<Map<String, dynamic>> profile =
    ValueNotifier(<String, dynamic>{});

ValueNotifier<List<Map<String, dynamic>>> corporateers =
    ValueNotifier(<Map<String, dynamic>>[]);

ValueNotifier<Map<String, dynamic>> stats =
    ValueNotifier(<String, dynamic>{});

ValueNotifier<List<Map<String, dynamic>>> receivedTributeHistory =
    ValueNotifier(<Map<String, dynamic>>[]);

ValueNotifier<List<Map<String, dynamic>>> sentTributeHistory =
    ValueNotifier(<Map<String, dynamic>>[]);

Future<void> update() async {
  await updateProfile();
  await updateSentTributeHistory();
  await updateReceivedTributeHistory();
  await updateStats();
  await updateCorporateers();
}

Future<void> updateProfile() async {
  try {
    final apiService = ServiceLocator().corpApiService;
    final response = await apiService.getProfile();
    if (response.data != null) {
      profile.value = Map<String, dynamic>.from(response.data);
    }
  } catch (error) {
    print('Error updating profile: $error');
  }
}

Future<void> updateStats() async {
  try {
    final apiService = ServiceLocator().corpApiService;
    final response = await apiService.getUserInfluenceStats();
    if (response.data != null) {
      stats.value = Map<String, dynamic>.from(response.data);
    }
  } catch (error) {
    print('Error updating stats: $error');
  }
}

Future<void> updateCorporateers() async {
  try {
    final apiService = ServiceLocator().corpApiService;
    final response = await apiService.getCorporateers();
    if (response.data != null) {
      corporateers.value = List<Map<String, dynamic>>.from(response.data);
    }
  } catch (error) {
    print('Error updating corporateers: $error');
  }
}

Future<void> sendTribute({
  required String receiver,
  required int amount,
  String? message,
}) async {
  try {
    final apiService = ServiceLocator().corpApiService;
    final response = await apiService.sendTribute(
      receiverHandle: receiver,
      amount: amount,
      message: message,
    );
    
    if (response.data != null && response.data['msg'] == "Tribute sent") {
      await update();
    }
  } catch (error) {
    print('Error sending tribute: $error');
    throw error;
  }
}

Future<void> updateReceivedTributeHistory() async {
  try {
    final apiService = ServiceLocator().corpApiService;
    final response = await apiService.getTributeHistory(
      type: 'received',
      request: 'all',
      page: '1',
    );
    if (response.data != null) {
      receivedTributeHistory.value = List<Map<String, dynamic>>.from(response.data);
    }
  } catch (error) {
    print('Error updating received tribute history: $error');
  }
}

Future<void> updateSentTributeHistory() async {
  try {
    final apiService = ServiceLocator().corpApiService;
    final response = await apiService.getTributeHistory(
      type: 'sent',
      request: 'all',
      page: '1',
    );
    if (response.data != null) {
      sentTributeHistory.value = List<Map<String, dynamic>>.from(response.data);
    }
  } catch (error) {
    print('Error updating sent tribute history: $error');
  }
}
