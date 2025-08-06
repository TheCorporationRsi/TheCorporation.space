## Migration Guide: From OpenAPI Generator to Dynamic API Client

This guide shows how to migrate from the generated OpenAPI client to the new dynamic API client.

### 1. Update Dependencies

The following dependencies have been removed from `pubspec.yaml`:
- `openapi_generator_annotations`
- `build_runner` (if only used for OpenAPI generation)
- `corp_api` (local path dependency)

### 2. Import Changes

**Before:**
```dart
import 'package:corp_api/corp_api.dart';
```

**After:**
```dart
import 'package:flutter_dashboard/services/service_locator.dart';
// Or access the service directly via main.dart global variables
import 'package:flutter_dashboard/main.dart'; // for corpApiService
```

### 3. API Client Usage

**Before:**
```dart
var corpSecurityClient = CorpApi().getSecurityApi();
final response = await corpSecurityClient.login(loginRequest: loginRequest);
```

**After:**
```dart
// Option 1: Using the service directly
final response = await corpApiService.login(
  username: username,
  password: password,
  otp: otp,
);

// Option 2: Using ServiceLocator
final apiService = ServiceLocator().corpApiService;
final response = await apiService.login(
  username: username,
  password: password,
  otp: otp,
);

// Option 3: Low-level dynamic call
final dynamicClient = ServiceLocator().dynamicApiClient;
final response = await dynamicClient.call(
  'login',
  data: {
    'username': username,
    'password': password,
    'otp': otp,
  },
);
```

### 4. Response Handling

**Before:**
```dart
if (response.data!.msg == 'logged_in') {
  final accessToken = response.data!.corpAccessPass;
  final refreshToken = response.data!.corpRefreshPass;
}
```

**After:**
```dart
if (response.data['msg'] == 'logged_in') {
  final accessToken = response.data['corp_access_pass'];
  final refreshToken = response.data['corp_refresh_pass'];
}
```

### 5. Available Service Methods

The `CorpApiService` provides convenient methods for all API endpoints:

#### Authentication
- `login()`, `register()`, `logout()`, `refreshToken()`
- `changePassword()`, `getStatus()`

#### Information
- `getCorporateers()`, `getCurrentFunding()`

#### Influence System
- `getProfile()`, `getUserInfluenceStats()`, `sendTribute()`
- `getTributeHistory()`, `updateAccount()`

#### Auctions
- `listAuctions()`, `createAuction()`, `placeBet()`
- `closeAuction()`, `deleteAuction()`

#### Structure
- `getUserProfile()`, `getUserDepartments()`, `getUserDivisions()`
- `getUserRoles()`, `joinDivision()`, `leaveDivision()`

#### Admin Functions
- `adminAddTribute()`, `createRank()`, `editRank()`, `deleteRank()`
- `createDepartment()`, `updateDepartment()`, `deleteDepartment()`

### 6. Example: Complete Login Screen Update

Here's how to update the login functionality:

```dart
Future<void> _performLogin() async {
  try {
    final response = await corpApiService.login(
      username: handleController.text,
      password: _hashPassword(passwordController.text),
      otp: OTPController.text.isNotEmpty ? int.parse(OTPController.text) : null,
    );

    if (response.data['msg'] == 'logged_in') {
      final accessToken = response.data['corp_access_pass'] as String?;
      final refreshToken = response.data['corp_refresh_pass'] as String?;

      if (refreshToken != null) {
        await writeSecureData('corp_refresh_pass', refreshToken);
      }
      if (accessToken != null) {
        await writeSecureData('corp_access_pass', accessToken);
      }

      Navigator.pushReplacementNamed(context, '/dashboard');
    }
  } catch (e) {
    // Handle error
    print('Login failed: $e');
  }
}
```

### 7. Error Handling

The dynamic client returns standard Dio responses and exceptions:

```dart
try {
  final response = await corpApiService.someMethod();
  // Handle success
} on DioException catch (e) {
  if (e.response?.statusCode == 401) {
    // Handle unauthorized
  } else if (e.response?.statusCode == 400) {
    // Handle bad request
  }
} catch (e) {
  // Handle other errors
}
```

### 8. Exploring Available Endpoints

You can discover available endpoints dynamically:

```dart
final dynamicClient = ServiceLocator().dynamicApiClient;

// Get all endpoints
final endpoints = dynamicClient.endpoints;

// Get endpoints by tag
final securityEndpoints = dynamicClient.getEndpointsByTag('Security');

// Get specific endpoint info
final loginEndpoint = dynamicClient.getEndpoint('login');
print('Login path: ${loginEndpoint?.path}');
print('Login method: ${loginEndpoint?.method}');
```

### Benefits of the New Approach

1. **No Code Generation**: No need to run build_runner or regenerate API code
2. **Dynamic Updates**: API changes are automatically available without regeneration
3. **Smaller Bundle**: No generated code means smaller app size
4. **Type Safety**: Still maintains type safety through service methods
5. **Flexibility**: Can handle API changes without breaking the app
6. **Better Error Handling**: Standard Dio error handling patterns
7. **Runtime Discovery**: Can discover and use new endpoints at runtime

### Migration Steps

1. Remove OpenAPI generator dependencies from `pubspec.yaml`
2. Update imports in all files
3. Replace generated API client calls with service method calls
4. Update response handling to use Map<String, dynamic> instead of generated models
5. Test all API functionality
6. Remove the `api/corp_api` directory

This new approach provides the same functionality as the generated client but with much more flexibility and no build-time dependencies.
