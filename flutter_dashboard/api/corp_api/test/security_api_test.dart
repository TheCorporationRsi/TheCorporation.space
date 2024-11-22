import 'package:test/test.dart';
import 'package:corp_api/corp_api.dart';

/// tests for SecurityApi
void main() {
  final instance = CorpApi().getSecurityApi();

  group(SecurityApi, () {
    // Change password
    //
    // <br/>This endpoint allow for password change as long as you know the current password<br/>
    //
    //Future changePassword({ ChangePasswordRequest changePasswordRequest }) async
    test('test changePassword', () async {
      // TODO
    });

    // Get your logs
    //
    // <br/>This returns a list of all the logs that have been assigned to your account<br/>
    //
    //Future getLogs() async
    test('test getLogs', () async {
      // TODO
    });

    // Get RSI token
    //
    // <br/>Returns the user RSI token to be place in the bio for authentification<br/>
    //
    //Future<GetRSIToken200Response> getRSIToken() async
    test('test getRSIToken', () async {
      // TODO
    });

    // Get current authentification status
    //
    // <br/>This endpoint provide information on what you currently have access<br/>
    //
    //Future<GetStatus200Response> getStatus() async
    test('test getStatus', () async {
      // TODO
    });

    // Authetification endpoint
    //
    // <br/>This endpoint allow login with username:password<br/>
    //
    //Future<Login200Response> login({ LoginRequest loginRequest }) async
    test('test login', () async {
      // TODO
    });

    // Logout current user
    //
    // <br/>This allow a user to logout from the api<br/>
    //
    //Future logout() async
    test('test logout', () async {
      // TODO
    });

    // Path to refresh cookie that are soon to expire
    //
    // <br/>In order to gain a new token once expired, the frontend must submit the refresh token to get a new one.<br/>
    //
    //Future refreshToken() async
    test('test refreshToken', () async {
      // TODO
    });

    // Registration endpoint
    //
    // <br/>This registers the current RSI handle in the system<br/>
    //
    //Future<Register200Response> register({ RegisterRequest registerRequest }) async
    test('test register', () async {
      // TODO
    });

    // Verify RSI token
    //
    // <br/>When used, the current user profile will be verified on the RSI website to find the assigned token<br/>
    //
    //Future<VerifyRSIToken200Response> verifyRSIToken() async
    test('test verifyRSIToken', () async {
      // TODO
    });
  });
}
