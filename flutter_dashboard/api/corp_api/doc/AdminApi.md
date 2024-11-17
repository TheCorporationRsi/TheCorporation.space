# corp_api.api.AdminApi

## Load the API package
```dart
import 'package:corp_api/api.dart';
```

All URIs are relative to *http://localhost:5000/api/_**

Method | HTTP request | Description
------------- | ------------- | -------------
[**createDepartment**](AdminApi.md#createdepartment) | **POST** /api/v0/structure/departments | Department creation endpoint
[**createDivision**](AdminApi.md#createdivision) | **POST** /api/v0/structure/divisions | Division creation endpoint


# **createDepartment**
> CreateDepartment200Response createDepartment(createDepartmentRequest)

Department creation endpoint

<br/>This is using docstrings for specifications.<br/>

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

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createDivision**
> CreateDivision200Response createDivision(createDivisionRequest)

Division creation endpoint

<br/>This is using docstrings for specifications.<br/>

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

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

