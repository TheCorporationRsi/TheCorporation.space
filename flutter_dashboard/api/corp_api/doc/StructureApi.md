# corp_api.api.StructureApi

## Load the API package
```dart
import 'package:corp_api/api.dart';
```

All URIs are relative to *http://localhost:5000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiV0StructureProfileRolesGet**](StructureApi.md#apiv0structureprofilerolesget) | **GET** /api/v0/structure/profile/roles | List of all your roles
[**getDepartments**](StructureApi.md#getdepartments) | **GET** /api/v0/structure/departments | List of all departments
[**getDivisions**](StructureApi.md#getdivisions) | **GET** /api/v0/structure/divisions | List of all divisions
[**getUserDepartments**](StructureApi.md#getuserdepartments) | **GET** /api/v0/structure/profile/departments | List of all your departments
[**getUserDivisions**](StructureApi.md#getuserdivisions) | **GET** /api/v0/structure/profile/divisions | List of all your division


# **apiV0StructureProfileRolesGet**
> ApiV0StructureProfileRolesGet200Response apiV0StructureProfileRolesGet()

List of all your roles

<br/>Returns a list of all the current user's roles<br/>

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getStructureApi();

try {
    final response = api.apiV0StructureProfileRolesGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling StructureApi->apiV0StructureProfileRolesGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ApiV0StructureProfileRolesGet200Response**](ApiV0StructureProfileRolesGet200Response.md)

### Authorization

[corp_access_pass](../README.md#corp_access_pass)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getDepartments**
> GetDepartments200Response getDepartments()

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

[**GetDepartments200Response**](GetDepartments200Response.md)

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
> GetUserDepartments200Response getUserDepartments()

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

[**GetUserDepartments200Response**](GetUserDepartments200Response.md)

### Authorization

[corp_access_pass](../README.md#corp_access_pass)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUserDivisions**
> GetUserDivisions200Response getUserDivisions()

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

[**GetUserDivisions200Response**](GetUserDivisions200Response.md)

### Authorization

[corp_access_pass](../README.md#corp_access_pass)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

