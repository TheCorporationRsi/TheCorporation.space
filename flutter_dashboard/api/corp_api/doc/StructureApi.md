# corp_api.api.StructureApi

## Load the API package
```dart
import 'package:corp_api/api.dart';
```

All URIs are relative to *https://thecorporation.space*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getDepartments**](StructureApi.md#getdepartments) | **GET** /api/v0/structure/departments | List of all departments
[**getDivisions**](StructureApi.md#getdivisions) | **GET** /api/v0/structure/divisions | List of all divisions
[**getUserDepartments**](StructureApi.md#getuserdepartments) | **GET** /api/v0/structure/profile/departments | List of all your departments
[**getUserDivisions**](StructureApi.md#getuserdivisions) | **GET** /api/v0/structure/profile/divisions | List of all your division
[**getUserProfile**](StructureApi.md#getuserprofile) | **GET** /api/v0/structure/profile | Current user profile
[**getUserRoles**](StructureApi.md#getuserroles) | **GET** /api/v0/structure/profile/roles | List of all your roles


# **getDepartments**
> BuiltList<GetDepartments200ResponseInner> getDepartments()

List of all departments

<br/>Returns a list of all the departments in the system<br/>

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getStructureApi();

try {
    final response = api.getDepartments();
    print(response);
} catch on DioException (e) {
    print('Exception when calling StructureApi->getDepartments: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;GetDepartments200ResponseInner&gt;**](GetDepartments200ResponseInner.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getDivisions**
> BuiltList<GetDivisions200ResponseInner> getDivisions()

List of all divisions

<br/>Returns a list of all the divisions in the system<br/>

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getStructureApi();

try {
    final response = api.getDivisions();
    print(response);
} catch on DioException (e) {
    print('Exception when calling StructureApi->getDivisions: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;GetDivisions200ResponseInner&gt;**](GetDivisions200ResponseInner.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUserDepartments**
> BuiltList<GetUserDepartments200ResponseInner> getUserDepartments()

List of all your departments

<br/>Returns a list of the current user's departments<br/>

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getStructureApi();

try {
    final response = api.getUserDepartments();
    print(response);
} catch on DioException (e) {
    print('Exception when calling StructureApi->getUserDepartments: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;GetUserDepartments200ResponseInner&gt;**](GetUserDepartments200ResponseInner.md)

### Authorization

[corp_access_pass](../README.md#corp_access_pass)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUserDivisions**
> BuiltList<GetUserDivisions200ResponseInner> getUserDivisions()

List of all your division

<br/>Return a list of the current user's division<br/>

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getStructureApi();

try {
    final response = api.getUserDivisions();
    print(response);
} catch on DioException (e) {
    print('Exception when calling StructureApi->getUserDivisions: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;GetUserDivisions200ResponseInner&gt;**](GetUserDivisions200ResponseInner.md)

### Authorization

[corp_access_pass](../README.md#corp_access_pass)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUserProfile**
> GetUserProfile200Response getUserProfile()

Current user profile

<br/>Returns the current user's profile<br/>

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getStructureApi();

try {
    final response = api.getUserProfile();
    print(response);
} catch on DioException (e) {
    print('Exception when calling StructureApi->getUserProfile: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**GetUserProfile200Response**](GetUserProfile200Response.md)

### Authorization

[corp_access_pass](../README.md#corp_access_pass)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUserRoles**
> BuiltList<GetUserRoles200ResponseInner> getUserRoles()

List of all your roles

<br/>Returns a list of all the current user's roles<br/>

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getStructureApi();

try {
    final response = api.getUserRoles();
    print(response);
} catch on DioException (e) {
    print('Exception when calling StructureApi->getUserRoles: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;GetUserRoles200ResponseInner&gt;**](GetUserRoles200ResponseInner.md)

### Authorization

[corp_access_pass](../README.md#corp_access_pass)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

