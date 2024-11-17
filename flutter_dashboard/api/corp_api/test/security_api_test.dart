import 'package:test/test.dart';
import 'package:corp_api/corp_api.dart';

/// tests for SecurityApi
void main() {
  final instance = CorpApi().getSecurityApi();

  group(SecurityApi, () {
    // Change password
    //
    // This is using docstrings for specifications.<br/>
    //
    //Future changePassword({ ChangePasswordRequest changePasswordRequest }) async
    test('test changePassword', () async {
      // TODO
    });

    // Get your logs
    //
    // This is using docstrings for specifications.<br/>
    //
    //Future getLogs() async
    test('test getLogs', () async {
      // TODO
    });

    // Get RSI token
    //
    // This is using docstrings for specifications.<br/>
    //
    //Future<GetRSIToken200Response> getRSIToken() async
    test('test getRSIToken', () async {
      // TODO
    });

    // Authetification endpoint
    //
    // <br/>This is using docstrings for specifications.<br/>
    //
    //Future<Login200Response> login({ LoginRequest loginRequest }) async
    test('test login', () async {
      // TODO
    });

    // Logout current user
    //
    // <br/>This is using docstrings for specifications.<br/>
    //
    //Future logout() async
    test('test logout', () async {
      // TODO
    });

    // Path to refresh cookie that are soon to expire
    //
    // <br/>This is using docstrings for specifications.<br/>
    //
    //Future refreshToken() async
    test('test refreshToken', () async {
      // TODO
    });

    // Registration endpoint
    //
    // <br/>This is using docstrings for specifications.<br/>
    //
    //Future<Register200Response> register({ RegisterRequest registerRequest }) async
    test('test register', () async {
      // TODO
    });

    // Verify RSI token
    //
    // This is using docstrings for specifications.<br/>
    //
    //Future<VerifyRSIToken200Response> verifyRSIToken() async
    test('test verifyRSIToken', () async {
      // TODO
    });
  });
}
