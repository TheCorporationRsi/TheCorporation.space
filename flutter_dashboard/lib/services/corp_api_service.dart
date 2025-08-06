import 'package:dio/dio.dart';
import 'dynamic_api_client.dart';

/// Service class that provides convenient methods for common API operations
class CorpApiService {
  final DynamicApiClient _apiClient;
  
  CorpApiService(this._apiClient);

  /// Initialize the service
  Future<void> initialize() async {
    await _apiClient.initialize();
  }

  /// Check if the service is ready to use
  bool get isReady => _apiClient.isInitialized;

  // Authentication endpoints

  /// Login with username and password
  Future<Response> login({
    required String username,
    required String password,
    int? otp,
  }) async {
    return _apiClient.call(
      'login',
      data: {
        'username': username,
        'password': password,
        if (otp != null) 'otp': otp,
      },
    );
  }

  /// Register a new user
  Future<Response> register({
    required String username,
    required String password,
    required String confirmedPassword,
  }) async {
    return _apiClient.call(
      'register',
      data: {
        'username': username,
        'password': password,
        'confirmed_password': confirmedPassword,
      },
    );
  }

  /// Refresh authentication token
  Future<Response> refreshToken() async {
    return _apiClient.call('refresh_token');
  }

  /// Logout current user
  Future<Response> logout() async {
    return _apiClient.call('logout');
  }

  /// Get current authentication status
  Future<Response> getStatus() async {
    return _apiClient.call('get_status');
  }

  /// Change password
  Future<Response> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmedPassword,
  }) async {
    return _apiClient.call(
      'change_password',
      data: {
        'current_password': currentPassword,
        'new_password': newPassword,
        'confirmed_password': confirmedPassword,
      },
    );
  }

  // Information endpoints

  /// Get list of corporateers
  Future<Response> getCorporateers() async {
    return _apiClient.call('get_corporateers');
  }

  /// Get current funding information
  Future<Response> getCurrentFunding() async {
    return _apiClient.call('get_current_funding');
  }

  // Influence System endpoints

  /// Get user's influence profile
  Future<Response> getProfile() async {
    return _apiClient.call('get_profile');
  }

  /// Get user's influence stats
  Future<Response> getUserInfluenceStats() async {
    return _apiClient.call('get_user_influence_stats');
  }

  /// Get specific influence amount
  Future<Response> getInfluence({
    required String influenceType, // 'influence' or 'lifetime_influence'
    required String type, // 'all', 'division', 'department', 'general'
    required String title,
  }) async {
    return _apiClient.call(
      'get_influence',
      pathParams: {
        'influence_type': influenceType,
        'type': type,
        'title': title,
      },
    );
  }

  /// Send tribute to another corporateer
  Future<Response> sendTribute({
    required String receiverHandle,
    required int amount,
    String? message,
  }) async {
    return _apiClient.call(
      'send_tribute',
      data: {
        'receiver_handle': receiverHandle,
        'amount': amount,
        if (message != null) 'message': message,
      },
    );
  }

  /// Get tribute history
  Future<Response> getTributeHistory({
    required String type, // 'sent' or 'received'
    required String request, // 'all' or 'page'
    required String page,
  }) async {
    return _apiClient.call(
      'get_tribute_history',
      pathParams: {
        'type': type,
        'request': request,
        'page': page,
      },
    );
  }

  /// Update influence system account
  Future<Response> updateAccount() async {
    return _apiClient.call('update_account');
  }

  // Auction endpoints

  /// Get list of auctions
  Future<Response> listAuctions() async {
    return _apiClient.call('list_auctions');
  }

  /// Create a new auction
  Future<Response> createAuction({
    required String title,
    required String description,
    required String endTime,
    String? department,
    String? division,
  }) async {
    return _apiClient.call(
      'create_auction',
      data: {
        'title': title,
        'description': description,
        'end_time': endTime,
        if (department != null) 'department': department,
        if (division != null) 'division': division,
      },
    );
  }

  /// Place a bet on an auction
  Future<Response> placeBet({
    required String auctionId,
    required int amount,
  }) async {
    return _apiClient.call(
      'place_bet',
      data: {
        'auction_id': auctionId,
        'amount': amount,
      },
    );
  }

  /// Close an auction
  Future<Response> closeAuction({required String auctionId}) async {
    return _apiClient.call(
      'close_auction',
      data: {'auction_id': auctionId},
    );
  }

  /// Delete an auction
  Future<Response> deleteAuction({required String auctionId}) async {
    return _apiClient.call(
      'delete_auction',
      data: {'auction_id': auctionId},
    );
  }

  // Structure endpoints

  /// Get user profile
  Future<Response> getUserProfile() async {
    return _apiClient.call('get_user_profile');
  }

  /// Get user departments
  Future<Response> getUserDepartments() async {
    return _apiClient.call('get_user_departments');
  }

  /// Get user divisions
  Future<Response> getUserDivisions() async {
    return _apiClient.call('get_user_divisions');
  }

  /// Get user roles
  Future<Response> getUserRoles() async {
    return _apiClient.call('get_user_roles');
  }

  /// Get all departments
  Future<Response> getDepartments() async {
    return _apiClient.call('get_departments');
  }

  /// Get all divisions
  Future<Response> getDivisions() async {
    return _apiClient.call('get_divisions');
  }

  /// Get all roles
  Future<Response> getRoles() async {
    return _apiClient.call('get_roles');
  }

  /// Join a division
  Future<Response> joinDivision({required String divisionTitle}) async {
    return _apiClient.call(
      'join_division',
      data: {'division_title': divisionTitle},
    );
  }

  /// Leave a division
  Future<Response> leaveDivision({required String divisionTitle}) async {
    return _apiClient.call(
      'leave_division',
      data: {'division_title': divisionTitle},
    );
  }

  /// Set division weights
  Future<Response> setWeights({
    required List<Map<String, dynamic>> weights,
  }) async {
    return _apiClient.call(
      'set_weights',
      data: weights,
    );
  }

  /// Add role to user
  Future<Response> addUserRole({
    required String roleTitle,
    required String rsiHandle,
  }) async {
    return _apiClient.call(
      'add_user_role',
      data: {
        'role_title': roleTitle,
        'rsi_handle': rsiHandle,
      },
    );
  }

  /// Remove role from user
  Future<Response> removeUserRole({
    required String roleTitle,
    required String rsiHandle,
  }) async {
    return _apiClient.call(
      'remove_user_role',
      data: {
        'role_title': roleTitle,
        'rsi_handle': rsiHandle,
      },
    );
  }

  // RSI Stats endpoints

  /// Get RSI token
  Future<Response> getRSIToken() async {
    return _apiClient.call('get_RSI_token');
  }

  /// Verify RSI token
  Future<Response> verifyRSIToken() async {
    return _apiClient.call('verify_RSI_token');
  }

  // Security endpoints

  /// Get logs
  Future<Response> getLogs() async {
    return _apiClient.call('get_logs');
  }

  /// Get all users
  Future<Response> getUsers() async {
    return _apiClient.call('get_users');
  }

  /// Get specific user info
  Future<Response> getUser({required String username}) async {
    return _apiClient.call(
      'get_user',
      pathParams: {'username': username},
    );
  }

  /// Delete a user
  Future<Response> deleteUser({required String username}) async {
    return _apiClient.call(
      'delete_user',
      pathParams: {'username': username},
    );
  }

  /// Manually verify a user
  Future<Response> manuallyVerifyUser({required String username}) async {
    return _apiClient.call(
      'manualy_verify_user',
      pathParams: {'username': username},
    );
  }

  /// Set user security level
  Future<Response> setUserSecurityLevel({
    required String username,
    required int securityLevel,
  }) async {
    return _apiClient.call(
      'set_user_security_level',
      data: {
        'username': username,
        'security_level': securityLevel,
      },
    );
  }

  // Admin endpoints

  /// Add tribute (admin only)
  Future<Response> adminAddTribute({
    required String rsiHandle,
    required int amount,
  }) async {
    return _apiClient.call(
      'admin_add_tribute',
      data: {
        'rsi_handle': rsiHandle,
        'amount': amount,
      },
    );
  }

  /// Get influence system ranks
  Future<Response> getRanks() async {
    return _apiClient.call('get_ranks');
  }

  /// Create a new rank (admin only)
  Future<Response> createRank({
    required String title,
    required int requiredLifetimeInfluence,
    required int weeklyAmount,
  }) async {
    return _apiClient.call(
      'create_rank',
      data: {
        'title': title,
        'required_lifetime_influence': requiredLifetimeInfluence,
        'weekly_amount': weeklyAmount,
      },
    );
  }

  /// Edit a rank (admin only)
  Future<Response> editRank({
    required String rankTitle,
    String? newTitle,
    int? requiredLifetimeInfluence,
    int? weeklyAmount,
  }) async {
    final data = <String, dynamic>{'rank_title': rankTitle};
    
    if (newTitle != null) data['title'] = newTitle;
    if (requiredLifetimeInfluence != null) {
      data['required_lifetime_influence'] = requiredLifetimeInfluence;
    }
    if (weeklyAmount != null) data['weekly_amount'] = weeklyAmount;

    return _apiClient.call('edit_rank', data: data);
  }

  /// Delete a rank (admin only)
  Future<Response> deleteRank({required String rankTitle}) async {
    return _apiClient.call(
      'delete_rank',
      data: {'rank_title': rankTitle},
    );
  }

  /// Create a department (admin only)
  Future<Response> createDepartment({required String title}) async {
    return _apiClient.call(
      'create_department',
      data: {'title': title},
    );
  }

  /// Update a department (admin only)
  Future<Response> updateDepartment({
    required String departmentTitle,
    String? newTitle,
    String? description,
    String? motto,
    String? logo,
    String? color,
  }) async {
    final data = <String, dynamic>{'department_title': departmentTitle};
    
    if (newTitle != null) data['new_title'] = newTitle;
    if (description != null) data['description'] = description;
    if (motto != null) data['motto'] = motto;
    if (logo != null) data['logo'] = logo;
    if (color != null) data['color'] = color;

    return _apiClient.call('update_department', data: data);
  }

  /// Delete a department (admin only)
  Future<Response> deleteDepartment({required String departmentTitle}) async {
    return _apiClient.call(
      'delete_department',
      data: {'department_title': departmentTitle},
    );
  }

  /// Create a division (admin only)
  Future<Response> createDivision({
    required String title,
    required String departmentTitle,
  }) async {
    return _apiClient.call(
      'create_division',
      data: {
        'title': title,
        'department_title': departmentTitle,
      },
    );
  }

  /// Update a division (admin only)
  Future<Response> updateDivision({
    required String divisionTitle,
    String? newTitle,
    String? description,
    String? motto,
    String? logo,
    bool? restricted,
    int? securityLevel,
  }) async {
    final data = <String, dynamic>{'division_title': divisionTitle};
    
    if (newTitle != null) data['new_title'] = newTitle;
    if (description != null) data['description'] = description;
    if (motto != null) data['motto'] = motto;
    if (logo != null) data['logo'] = logo;
    if (restricted != null) data['restricted'] = restricted;
    if (securityLevel != null) data['security_level'] = securityLevel;

    return _apiClient.call('update_division', data: data);
  }

  /// Delete a division (admin only)
  Future<Response> deleteDivision({required String divisionTitle}) async {
    return _apiClient.call(
      'delete_division',
      data: {'division_title': divisionTitle},
    );
  }

  /// Create a role (admin only)
  Future<Response> createRole({
    required String title,
    required String departmentTitle,
    required String divisionTitle,
  }) async {
    return _apiClient.call(
      'create_role',
      data: {
        'title': title,
        'department_title': departmentTitle,
        'division_title': divisionTitle,
      },
    );
  }

  /// Update a role (admin only)
  Future<Response> updateRole({
    required String roleTitle,
    String? newTitle,
    String? newColor,
    String? newLogo,
    String? newDiscordId,
  }) async {
    final data = <String, dynamic>{'role_title': roleTitle};
    
    if (newTitle != null) data['new_title'] = newTitle;
    if (newColor != null) data['new_color'] = newColor;
    if (newLogo != null) data['new_logo'] = newLogo;
    if (newDiscordId != null) data['new_discord_id'] = newDiscordId;

    return _apiClient.call('update_role', data: data);
  }

  /// Delete a role (admin only)
  Future<Response> deleteRole({required String roleTitle}) async {
    return _apiClient.call(
      'delete_role',
      data: {'role_title': roleTitle},
    );
  }

  // Generic method for any operation not covered above
  Future<Response<T>> callOperation<T>(
    String operationId, {
    Map<String, dynamic>? pathParams,
    Map<String, dynamic>? queryParams,
    dynamic data,
    Map<String, dynamic>? headers,
    Options? options,
  }) async {
    return _apiClient.call<T>(
      operationId,
      pathParams: pathParams,
      queryParams: queryParams,
      data: data,
      headers: headers,
      options: options,
    );
  }

  /// Get endpoint information
  ApiEndpoint? getEndpointInfo(String operationId) {
    return _apiClient.getEndpoint(operationId);
  }

  /// Get all available endpoints
  Map<String, ApiEndpoint>? get allEndpoints => _apiClient.endpoints;

  /// Get endpoints by tag
  List<ApiEndpoint> getEndpointsByTag(String tag) {
    return _apiClient.getEndpointsByTag(tag);
  }
}
