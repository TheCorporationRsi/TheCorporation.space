import 'package:dio/dio.dart';

/// Legacy wrapper for maintaining compatibility during migration
/// This helps existing code work with the new dynamic API client
class LegacyApiWrapper {

  /// Helper method to convert old API calls to new format
  static Map<String, dynamic> convertResponse(Response response) {
    return response.data as Map<String, dynamic>;
  }

  /// Legacy profile response wrapper
  static Map<String, dynamic> wrapProfile(Map<String, dynamic> data) {
    return {
      'influence': data['influence'],
      'rank': data['rank'],
      'tribute': data['tribute'],
      'lifetime_influence': data['lifetime_influence'],
      'last_tribute_time': data['last_tribute_time'],
    };
  }

  /// Legacy user stats wrapper
  static Map<String, dynamic> wrapUserStats(Map<String, dynamic> data) {
    return {
      'total_influence': data['total_influence'],
      'total_lifetime_influence': data['total_lifetime_influence'],
      'general_influence': data['general_influence'],
      'lifetime_general_influence': data['lifetime_general_influence'],
      'departments': data['departments'] ?? [],
    };
  }

  /// Legacy corporateers list wrapper
  static List<Map<String, dynamic>> wrapCorporateers(List<dynamic> data) {
    return data.map((item) => {
      'RSI_handle': item['RSI_handle'],
      'RSI_moniker': item['RSI_moniker'],
      'picture': item['picture'],
    }).toList();
  }

  /// Legacy user divisions wrapper
  static List<Map<String, dynamic>> wrapUserDivisions(List<dynamic> data) {
    return data.map((item) => {
      'title': item['title'],
      'department': item['department'],
      'color': item['color'],
      'logo': item['logo'],
      'weight': item['weight'],
    }).toList();
  }

  /// Legacy user departments wrapper
  static List<Map<String, dynamic>> wrapUserDepartments(List<dynamic> data) {
    return data.map((item) => {
      'title': item['title'],
      'motto': item['motto'],
      'color': item['color'],
      'weight': item['weight'],
    }).toList();
  }

  /// Legacy user roles wrapper
  static List<Map<String, dynamic>> wrapUserRoles(List<dynamic> data) {
    return data.map((item) => {
      'title': item['title'],
      'type': item['type'],
      'department': item['department'],
      'division': item['division'],
      'color': item['color'],
      'logo': item['logo'],
    }).toList();
  }

  /// Legacy departments wrapper
  static List<Map<String, dynamic>> wrapDepartments(List<dynamic> data) {
    return data.map((item) => {
      'title': item['title'],
      'description': item['description'],
      'motto': item['motto'],
      'logo': item['logo'],
      'color': item['color'],
      'member_count': item['member_count'],
      'heads': item['heads'] ?? [],
      'proxys': item['proxys'] ?? [],
      'divisions': item['divisions'] ?? [],
    }).toList();
  }

  /// Legacy tribute history wrapper
  static List<Map<String, dynamic>> wrapTributeHistory(List<dynamic> data) {
    return data.map((item) => {
      'amount': item['amount'],
      'message': item['message'],
      'method': item['method'],
      'receiver': item['receiver'],
    }).toList();
  }

  /// Legacy ranks wrapper
  static List<Map<String, dynamic>> wrapRanks(List<dynamic> data) {
    return data.map((item) => {
      'title': item['title'],
      'required_lifetime_influence': item['required_lifetime_influence'],
      'weekly_amount': item['weekly_amount'],
    }).toList();
  }
}
