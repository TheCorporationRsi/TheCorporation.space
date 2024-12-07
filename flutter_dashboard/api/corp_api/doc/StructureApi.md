# corp_api.api.StructureApi

## Load the API package
```dart
import 'package:corp_api/api.dart';
```

All URIs are relative to *https://thecorporation.space*

Method | HTTP request | Description
------------- | ------------- | -------------
[**addUserRole**](StructureApi.md#adduserrole) | **POST** /api/v0/structure/profile/roles | Add a role to the current user
[**createRole**](StructureApi.md#createrole) | **POST** /api/v0/structure/roles | Create a new role
[**deleteRole**](StructureApi.md#deleterole) | **DELETE** /api/v0/structure/roles | Delete an existing role
[**editRole**](StructureApi.md#editrole) | **PATCH** /api/v0/structure/roles | Edit an existing role
[**getDepartments**](StructureApi.md#getdepartments) | **GET** /api/v0/structure/departments | List of all departments
[**getDivisions**](StructureApi.md#getdivisions) | **GET** /api/v0/structure/divisions | List of all divisions
[**getRoles**](StructureApi.md#getroles) | **GET** /api/v0/structure/roles | List of all roles
[**getUserDepartments**](StructureApi.md#getuserdepartments) | **GET** /api/v0/structure/profile/departments | List of all your departments
[**getUserDivisions**](StructureApi.md#getuserdivisions) | **GET** /api/v0/structure/profile/divisions | List of all your division
[**getUserProfile**](StructureApi.md#getuserprofile) | **GET** /api/v0/structure/profile | Current user profile
[**getUserRoles**](StructureApi.md#getuserroles) | **GET** /api/v0/structure/profile/roles | List of all your roles
[**removeUserRole**](StructureApi.md#removeuserrole) | **DELETE** /api/v0/structure/profile/roles | Remove a role from the current user


# **addUserRole**
> AddUserRole200Response addUserRole(addUserRoleRequest)

Add a role to the current user

<br/>Adds a new role to the current user<br/>

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getStructureApi();
final AddUserRoleRequest addUserRoleRequest = ; // AddUserRoleRequest | 

try {
    final response = api.addUserRole(addUserRoleRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling StructureApi->addUserRole: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **addUserRoleRequest** | [**AddUserRoleRequest**](AddUserRoleRequest.md)|  | 

### Return type

[**AddUserRole200Response**](AddUserRole200Response.md)

### Authorization

[corp_access_pass](../README.md#corp_access_pass)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createRole**
> CreateRole201Response createRole(createRoleRequest)

Create a new role

<br/>Creates a new role in the system<br/>

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getStructureApi();
final CreateRoleRequest createRoleRequest = ; // CreateRoleRequest | 

try {
    final response = api.createRole(createRoleRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling StructureApi->createRole: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createRoleRequest** | [**CreateRoleRequest**](CreateRoleRequest.md)|  | 

### Return type

[**CreateRole201Response**](CreateRole201Response.md)

### Authorization

[corp_access_pass](../README.md#corp_access_pass)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteRole**
> DeleteRole200Response deleteRole()

Delete an existing role

<br/>Deletes an existing role in the system<br/>

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getStructureApi();

try {
    final response = api.deleteRole();
    print(response);
} catch on DioException (e) {
    print('Exception when calling StructureApi->deleteRole: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**DeleteRole200Response**](DeleteRole200Response.md)

### Authorization

[corp_access_pass](../README.md#corp_access_pass)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **editRole**
> EditRole200Response editRole(editRoleRequest)

Edit an existing role

<br/>Edits an existing role in the system<br/>

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getStructureApi();
final EditRoleRequest editRoleRequest = ; // EditRoleRequest | 

try {
    final response = api.editRole(editRoleRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling StructureApi->editRole: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **editRoleRequest** | [**EditRoleRequest**](EditRoleRequest.md)|  | 

### Return type

[**EditRole200Response**](EditRole200Response.md)

### Authorization

[corp_access_pass](../README.md#corp_access_pass)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

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

# **getRoles**
> BuiltList<GetRoles200ResponseInner> getRoles()

List of all roles

<br/>Returns a list of all the roles in the system<br/>

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getStructureApi();

try {
    final response = api.getRoles();
    print(response);
} catch on DioException (e) {
    print('Exception when calling StructureApi->getRoles: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;GetRoles200ResponseInner&gt;**](GetRoles200ResponseInner.md)

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

# **removeUserRole**
> RemoveUserRole200Response removeUserRole(addUserRoleRequest)

Remove a role from the current user

<br/>Removes an existing role from the current user<br/>

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getStructureApi();
final AddUserRoleRequest addUserRoleRequest = ; // AddUserRoleRequest | 

try {
    final response = api.removeUserRole(addUserRoleRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling StructureApi->removeUserRole: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **addUserRoleRequest** | [**AddUserRoleRequest**](AddUserRoleRequest.md)|  | 

### Return type

[**RemoveUserRole200Response**](RemoveUserRole200Response.md)

### Authorization

[corp_access_pass](../README.md#corp_access_pass)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

