# corp_api.api.InfluenceSystemApi

## Load the API package
```dart
import 'package:corp_api/api.dart';
```

All URIs are relative to *http://localhost:5000/api/_**

Method | HTTP request | Description
------------- | ------------- | -------------
[**getInfluence**](InfluenceSystemApi.md#getinfluence) | **GET** /api/v0/influence_system/profile/{influence_type}/{type}/{title} | Get current influence
[**getProfile**](InfluenceSystemApi.md#getprofile) | **GET** /api/v0/influence_system/profile | Get influence system profile
[**getRanks**](InfluenceSystemApi.md#getranks) | **GET** /api/v0/influence_system/ranks | List of all influence system ranks
[**getTributeHistory**](InfluenceSystemApi.md#gettributehistory) | **GET** /api/v0/influence_system/profile/tribute_history/{type}/{request}/{page} | Get tribute sent history
[**sendTribute**](InfluenceSystemApi.md#sendtribute) | **POST** /api/v0/influence_system/transfer | Endpoint to send tribute to another corporateer


# **getInfluence**
> getInfluence(influenceType, type, title)

Get current influence

<br/>This is using docstrings for specifications.<br/>

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getInfluenceSystemApi();
final String influenceType = influenceType_example; // String | type of influence
final String type = type_example; // String | type of influence
final String title = title_example; // String | Department/Division title

try {
    api.getInfluence(influenceType, type, title);
} catch on DioException (e) {
    print('Exception when calling InfluenceSystemApi->getInfluence: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **influenceType** | **String**| type of influence | 
 **type** | **String**| type of influence | 
 **title** | **String**| Department/Division title | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getProfile**
> getProfile()

Get influence system profile

<br/>This is using docstrings for specifications.<br/>

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getInfluenceSystemApi();

try {
    api.getProfile();
} catch on DioException (e) {
    print('Exception when calling InfluenceSystemApi->getProfile: $e\n');
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

# **getRanks**
> BuiltList<GetRanks200ResponseInner> getRanks()

List of all influence system ranks

<br/>This is using docstrings for specifications.<br/>

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getInfluenceSystemApi();

try {
    final response = api.getRanks();
    print(response);
} catch on DioException (e) {
    print('Exception when calling InfluenceSystemApi->getRanks: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;GetRanks200ResponseInner&gt;**](GetRanks200ResponseInner.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getTributeHistory**
> getTributeHistory(type, request, page)

Get tribute sent history

<br/>This is using docstrings for specifications.<br/>

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getInfluenceSystemApi();
final String type = type_example; // String | sent/received
final String request = request_example; // String | page/all
final int page = 0; // int | page number

try {
    api.getTributeHistory(type, request, page);
} catch on DioException (e) {
    print('Exception when calling InfluenceSystemApi->getTributeHistory: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **type** | **String**| sent/received | 
 **request** | **String**| page/all | 
 **page** | **int**| page number | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **sendTribute**
> GetRanks200ResponseInner sendTribute(sendTributeRequest)

Endpoint to send tribute to another corporateer

<br/>This is using docstrings for specifications.<br/>

### Example
```dart
import 'package:corp_api/api.dart';
// TODO Configure API key authorization: csrf
//defaultApiClient.getAuthentication<ApiKeyAuth>('csrf').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('csrf').apiKeyPrefix = 'Bearer';

final api = CorpApi().getInfluenceSystemApi();
final SendTributeRequest sendTributeRequest = ; // SendTributeRequest | transfer information

try {
    final response = api.sendTribute(sendTributeRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling InfluenceSystemApi->sendTribute: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sendTributeRequest** | [**SendTributeRequest**](SendTributeRequest.md)| transfer information | [optional] 

### Return type

[**GetRanks200ResponseInner**](GetRanks200ResponseInner.md)

### Authorization

[csrf](../README.md#csrf)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

