# corp_api.api.AdminApi

## Load the API package
```dart
import 'package:corp_api/api.dart';
```

All URIs are relative to *https://thecorporation.space*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createDepartment**](AdminApi.md#createdepartment) | **POST** /api/v0/structure/departments | Department creation endpoint
[**createDivision**](AdminApi.md#createdivision) | **POST** /api/v0/structure/divisions | Division creation endpoint
[**deleteDepartment**](AdminApi.md#deletedepartment) | **DELETE** /api/v0/structure/departments | Department deletion endpoint
[**deleteDivision**](AdminApi.md#deletedivision) | **DELETE** /api/v0/structure/divisions | Division deletion endpoint
[**updateDepartment**](AdminApi.md#updatedepartment) | **PATCH** /api/v0/structure/departments | Department update endpoint
[**updateDivision**](AdminApi.md#updatedivision) | **PATCH** /api/v0/structure/divisions | Division update endpoint


# **createDepartment**
> CreateDepartment200Response createDepartment(createDepartmentRequest)

Department creation endpoint

<br/>This endpoint allow the creation of a new department<br/>

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getAdminApi();
final CreateDepartmentRequest createDepartmentRequest = ; // CreateDepartmentRequest | Department information

try {
    final response = api.createDepartment(createDepartmentRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->createDepartment: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createDepartmentRequest** | [**CreateDepartmentRequest**](CreateDepartmentRequest.md)| Department information | [optional] 

### Return type

[**CreateDepartment200Response**](CreateDepartment200Response.md)

### Authorization

[corp_access_pass](../README.md#corp_access_pass)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createDivision**
> CreateDivision200Response createDivision(createDivisionRequest)

Division creation endpoint

<br/>This is the admin endpoint to create new divisions<br/>

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getAdminApi();
final CreateDivisionRequest createDivisionRequest = ; // CreateDivisionRequest | Division information

try {
    final response = api.createDivision(createDivisionRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->createDivision: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createDivisionRequest** | [**CreateDivisionRequest**](CreateDivisionRequest.md)| Division information | [optional] 

### Return type

[**CreateDivision200Response**](CreateDivision200Response.md)

### Authorization

[corp_access_pass](../README.md#corp_access_pass)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteDepartment**
> DeleteDepartment200Response deleteDepartment(deleteDepartmentRequest)

Department deletion endpoint

<br/>This endpoint allows the deletion of a department<br/>

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getAdminApi();
final DeleteDepartmentRequest deleteDepartmentRequest = ; // DeleteDepartmentRequest | Department information

try {
    final response = api.deleteDepartment(deleteDepartmentRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->deleteDepartment: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **deleteDepartmentRequest** | [**DeleteDepartmentRequest**](DeleteDepartmentRequest.md)| Department information | [optional] 

### Return type

[**DeleteDepartment200Response**](DeleteDepartment200Response.md)

### Authorization

[corp_access_pass](../README.md#corp_access_pass)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteDivision**
> DeleteDivision200Response deleteDivision(deleteDivisionRequest)

Division deletion endpoint

<br/>This endpoint allows the deletion of a division<br/>

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getAdminApi();
final DeleteDivisionRequest deleteDivisionRequest = ; // DeleteDivisionRequest | Division information

try {
    final response = api.deleteDivision(deleteDivisionRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->deleteDivision: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **deleteDivisionRequest** | [**DeleteDivisionRequest**](DeleteDivisionRequest.md)| Division information | [optional] 

### Return type

[**DeleteDivision200Response**](DeleteDivision200Response.md)

### Authorization

[corp_access_pass](../README.md#corp_access_pass)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateDepartment**
> UpdateDepartment200Response updateDepartment(updateDepartmentRequest)

Department update endpoint

<br/>This endpoint allow the update of a department<br/>

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getAdminApi();
final UpdateDepartmentRequest updateDepartmentRequest = ; // UpdateDepartmentRequest | Department information

try {
    final response = api.updateDepartment(updateDepartmentRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->updateDepartment: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateDepartmentRequest** | [**UpdateDepartmentRequest**](UpdateDepartmentRequest.md)| Department information | [optional] 

### Return type

[**UpdateDepartment200Response**](UpdateDepartment200Response.md)

### Authorization

[corp_access_pass](../README.md#corp_access_pass)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateDivision**
> UpdateDivision200Response updateDivision(updateDivisionRequest)

Division update endpoint

<br/>This endpoint allows the update of a division<br/>

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getAdminApi();
final UpdateDivisionRequest updateDivisionRequest = ; // UpdateDivisionRequest | Division information

try {
    final response = api.updateDivision(updateDivisionRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->updateDivision: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateDivisionRequest** | [**UpdateDivisionRequest**](UpdateDivisionRequest.md)| Division information | [optional] 

### Return type

[**UpdateDivision200Response**](UpdateDivision200Response.md)

### Authorization

[corp_access_pass](../README.md#corp_access_pass)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

