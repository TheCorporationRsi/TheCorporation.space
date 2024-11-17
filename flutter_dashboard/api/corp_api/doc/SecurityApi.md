# corp_api.api.SecurityApi

## Load the API package
```dart
import 'package:corp_api/api.dart';
```

All URIs are relative to *http://localhost:5000/api/_**

Method | HTTP request | Description
------------- | ------------- | -------------
[**changePassword**](SecurityApi.md#changepassword) | **POST** /api/v0/change_password | Change password
[**getLogs**](SecurityApi.md#getlogs) | **GET** /api/v0/logs | Get your logs
[**getRSIToken**](SecurityApi.md#getrsitoken) | **GET** /api/v0/RSI_token | Get RSI token
[**getStatus**](SecurityApi.md#getstatus) | **GET** /api/v0/status | Get current authentification status
[**login**](SecurityApi.md#login) | **POST** /api/v0/login | Authetification endpoint
[**logout**](SecurityApi.md#logout) | **POST** /api/v0/logout | Logout current user
[**refreshToken**](SecurityApi.md#refreshtoken) | **POST** /api/v0/refresh_token | Path to refresh cookie that are soon to expire
[**register**](SecurityApi.md#register) | **POST** /api/v0/register | Registration endpoint
[**verifyRSIToken**](SecurityApi.md#verifyrsitoken) | **GET** /api/v0/test_RSI_token | Verify RSI token


# **changePassword**
> changePassword(changePasswordRequest)

Change password

This is using docstrings for specifications.<br/>

### Example
```dart
import 'package:corp_api/api.dart';
// TODO Configure API key authorization: csrf
//defaultApiClient.getAuthentication<ApiKeyAuth>('csrf').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('csrf').apiKeyPrefix = 'Bearer';

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

[csrf](../README.md#csrf)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getLogs**
> getLogs()

Get your logs

This is using docstrings for specifications.<br/>

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

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getRSIToken**
> GetRSIToken200Response getRSIToken()

Get RSI token

This is using docstrings for specifications.<br/>

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

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getStatus**
> GetStatus200Response getStatus()

Get current authentification status

This is using docstrings for specifications.<br/>

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

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **login**
> Login200Response login(loginRequest)

Authetification endpoint

<br/>This is using docstrings for specifications.<br/>

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

<br/>This is using docstrings for specifications.<br/>

### Example
```dart
import 'package:corp_api/api.dart';
// TODO Configure API key authorization: csrf
//defaultApiClient.getAuthentication<ApiKeyAuth>('csrf').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('csrf').apiKeyPrefix = 'Bearer';

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

[csrf](../README.md#csrf)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **refreshToken**
> refreshToken()

Path to refresh cookie that are soon to expire

<br/>This is using docstrings for specifications.<br/>

### Example
```dart
import 'package:corp_api/api.dart';
// TODO Configure API key authorization: csrf_refresh
//defaultApiClient.getAuthentication<ApiKeyAuth>('csrf_refresh').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('csrf_refresh').apiKeyPrefix = 'Bearer';

final api = CorpApi().getSecurityApi();

try {
    api.refreshToken();
} catch on DioException (e) {
    print('Exception when calling SecurityApi->refreshToken: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

[csrf_refresh](../README.md#csrf_refresh)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **register**
> Register200Response register(registerRequest)

Registration endpoint

<br/>This is using docstrings for specifications.<br/>

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

This is using docstrings for specifications.<br/>

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

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

