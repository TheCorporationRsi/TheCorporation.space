import 'package:corp_api/corp_api.dart';
import 'package:flutter_dashboard/main.dart';
import 'package:built_collection/built_collection.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


ValueNotifier<GetProfile200Response> profile = ValueNotifier(GetProfile200Response());


ValueNotifier<BuiltList<GetCorporateers200ResponseInner>> corporateers =
    ValueNotifier(BuiltList<GetCorporateers200ResponseInner>());

ValueNotifier<BuiltList<GetTributeHistory200ResponseInner>> receivedTributeHistory =
    ValueNotifier(BuiltList<GetTributeHistory200ResponseInner>());

ValueNotifier<BuiltList<GetTributeHistory200ResponseInner>> sentTributeHistory =
    ValueNotifier(BuiltList<GetTributeHistory200ResponseInner>());

final corpInfluenceClient = corpApi.getInfluenceSystemApi();

Future<void> update() async {
  await updateProfile();
  await updateSentTributeHistory();
  await updateReceivedTributeHistory();
}


Future<void> updateProfile() async {
  final headers = await getAuthHeader();
  try {
    final response = await corpInfluenceClient.getProfile(headers: headers);
    if (response.data != null) {
      profile.value = response.data ?? profile.value;
    }

  } catch (error) {
    print(error);
  }
}


Future<void> sendTribute({required Function onErrorMsg, required Function onSuccessMsg, required String receiver, required int amount, String? message }) async {
  final headers = await getAuthHeader();
  try {
    final SendTributeRequest sendTributeRequest = SendTributeRequest((b) => b
              ..receiverHandle = receiver
              ..amount = amount
              ..message = message);
    await corpInfluenceClient.sendTribute(headers: headers, sendTributeRequest: sendTributeRequest);

    onSuccessMsg("$amount tribute successfully sent to $receiver");

  } catch (error) {
    if ( error is DioException && error.response?.statusCode == 400){
      onErrorMsg(jsonDecode(error.response.toString())['msg']);
    }
    else {
      print(error);
    }
  }
}


Future<void> updateSentTributeHistory({int page = 0, String request = "page"}) async {
  final headers = await getAuthHeader();

  try {
    final response =
        await corpInfluenceClient.getTributeHistory(headers: headers, type: "sent", request: request, page: page.toString(),);
    if (response.data != null) {
      sentTributeHistory.value = response.data ?? sentTributeHistory.value;
    }
  } catch (error) {
    print(error);
  }
}

Future<void> updateReceivedTributeHistory({int page = 0, String request = "page"}) async {
  final headers = await getAuthHeader();

  try {
    final response =
        await corpInfluenceClient.getTributeHistory(headers: headers, type: "received", request: request, page: page.toString(),);
    if (response.data != null) {
      receivedTributeHistory.value = response.data ?? receivedTributeHistory.value;
    }
  } catch (error) {
    print(error);
  }
}
