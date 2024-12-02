# corp_api.api.SecurityApi

## Load the API package
```dart
import 'package:corp_api/api.dart';
```

All URIs are relative to *https://thecorporation.space*

Method | HTTP request | Description
------------- | ------------- | -------------
[**changePassword**](SecurityApi.md#changepassword) | **POST** /api/v0/change_password | Change password
[**deleteUser**](SecurityApi.md#deleteuser) | **DELETE** /api/v0/users/{username} | User delete
[**getLogs**](SecurityApi.md#getlogs) | **GET** /api/v0/logs | Get your logs
[**getRSIToken**](SecurityApi.md#getrsitoken) | **GET** /api/v0/RSI_token | Get RSI token
[**getStatus**](SecurityApi.md#getstatus) | **GET** /api/v0/status | Get current authentification status
[**getUser**](SecurityApi.md#getuser) | **GET** /api/v0/users/{username} | User info
[**getUsers**](SecurityApi.md#getusers) | **GET** /api/v0/users | Users list
[**login**](SecurityApi.md#login) | **POST** /api/v0/login | Authetification endpoint
[**logout**](SecurityApi.md#logout) | **POST** /api/v0/logout | Logout current user
[**refreshToken**](SecurityApi.md#refreshtoken) | **POST** /api/v0/refresh_token | Path to refresh cookie that are soon to expire
[**register**](SecurityApi.md#register) | **POST** /api/v0/register | Registration endpoint
[**verifyRSIToken**](SecurityApi.md#verifyrsitoken) | **GET** /api/v0/test_RSI_token | Verify RSI token


# **changePassword**
> changePassword(changePasswordRequest)

Change password

<br/>This endpoint allow for password change as long as you know the current password<br/>

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getSecurityApi();
final ChangePasswordRequest changePasswordRequest = ; // ChangePasswordRequest | registration information

try {
    api.changePassword(changePasswordRequest);
} catch on DioException (e) {
    print('Exception when calling SecurityApi->changePassword: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **changePasswordRequest** | [**ChangePasswordRequest**](ChangePasswordRequest.md)| registration information | [optional] 

### Return type

void (empty response body)

### Authorization

[corp_access_pass](../README.md#corp_access_pass)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteUser**
> deleteUser(username)

User delete

<br/>This endpoint delete a user<br/>

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getSecurityApi();
final String username = Cyber-Dreamer; // String | Username of the user

try {
    api.deleteUser(username);
} catch on DioException (e) {
    print('Exception when calling SecurityApi->deleteUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **username** | **String**| Username of the user | 

### Return type

void (empty response body)

### Authorization

[corp_access_pass](../README.md#corp_access_pass)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getLogs**
> getLogs()

Get your logs

<br/>This returns a list of all the logs that have been assigned to your account<br/>

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getSecurityApi();

try {
    api.getLogs();
} catch on DioException (e) {
    print('Exception when calling SecurityApi->getLogs: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

[corp_access_pass](../README.md#corp_access_pass)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getRSIToken**
> GetRSIToken200Response getRSIToken()

Get RSI token

<br/>Returns the user RSI token to be place in the bio for authentification<br/>

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getSecurityApi();

try {
    final response = api.getRSIToken();
    print(response);
} catch on DioException (e) {
    print('Exception when calling SecurityApi->getRSIToken: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**GetRSIToken200Response**](GetRSIToken200Response.md)

### Authorization

[corp_access_pass](../README.md#corp_access_pass)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getStatus**
> GetStatus200Response getStatus()

Get current authentification status

<br/>This endpoint provide information on what you currently have access<br/>

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getSecurityApi();

try {
    final response = api.getStatus();
    print(response);
} catch on DioException (e) {
    print('Exception when calling SecurityApi->getStatus: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**GetStatus200Response**](GetStatus200Response.md)

### Authorization

[corp_access_pass](../README.md#corp_access_pass)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUser**
> GetUser200Response getUser(username)

User info

<br/>This endpoint returns the information on a user<br/>

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getSecurityApi();
final String username = Cyber-Dreamer; // String | Username of the user

try {
    final response = api.getUser(username);
    print(response);
} catch on DioException (e) {
    print('Exception when calling SecurityApi->getUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **username** | **String**| Username of the user | 

### Return type

[**GetUser200Response**](GetUser200Response.md)

### Authorization

[corp_access_pass](../README.md#corp_access_pass)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUsers**
> BuiltList<GetUsers200ResponseInner> getUsers()

Users list

<br/>This endpoint returns all the users in the system<br/>

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getSecurityApi();

try {
    final response = api.getUsers();
    print(response);
} catch on DioException (e) {
    print('Exception when calling SecurityApi->getUsers: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;GetUsers200ResponseInner&gt;**](GetUsers200ResponseInner.md)

### Authorization

[corp_access_pass](../README.md#corp_access_pass)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **login**
> Login200Response login(loginRequest)

Authetification endpoint

<br/>This endpoint allow login with username:password<br/>

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getSecurityApi();
final LoginRequest loginRequest = ; // LoginRequest | login information

try {
    final response = api.login(loginRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling SecurityApi->login: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **loginRequest** | [**LoginRequest**](LoginRequest.md)| login information | [optional] 

### Return type

[**Login200Response**](Login200Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **logout**
> logout()

Logout current user

<br/>This allow a user to logout from the api<br/>

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getSecurityApi();

try {
    api.logout();
} catch on DioException (e) {
    print('Exception when calling SecurityApi->logout: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

[corp_access_pass](../README.md#corp_access_pass)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **refreshToken**
> RefreshToken200Response refreshToken()

Path to refresh cookie that are soon to expire

<br/>In order to gain a new token once expired, the frontend must submit the refresh token to get a new one.<br/>

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getSecurityApi();

try {
    final response = api.refreshToken();
    print(response);
} catch on DioException (e) {
    print('Exception when calling SecurityApi->refreshToken: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**RefreshToken200Response**](RefreshToken200Response.md)

### Authorization

[corp_refresh_pass](../README.md#corp_refresh_pass)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **register**
> Register200Response register(registerRequest)

Registration endpoint

<br/>This registers the current RSI handle in the system<br/>

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getSecurityApi();
final RegisterRequest registerRequest = ; // RegisterRequest | registration information

try {
    final response = api.register(registerRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling SecurityApi->register: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **registerRequest** | [**RegisterRequest**](RegisterRequest.md)| registration information | [optional] 

### Return type

[**Register200Response**](Register200Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **verifyRSIToken**
> VerifyRSIToken200Response verifyRSIToken()

Verify RSI token

<br/>When used, the current user profile will be verified on the RSI website to find the assigned token<br/>

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getSecurityApi();

try {
    final response = api.verifyRSIToken();
    print(response);
} catch on DioException (e) {
    print('Exception when calling SecurityApi->verifyRSIToken: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**VerifyRSIToken200Response**](VerifyRSIToken200Response.md)

### Authorization

[corp_access_pass](../README.md#corp_access_pass)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

