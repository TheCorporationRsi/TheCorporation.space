# corp_api.api.InfluenceSystemApi

## Load the API package
```dart
import 'package:corp_api/api.dart';
```

All URIs are relative to *http://localhost:5000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getInfluence**](InfluenceSystemApi.md#getinfluence) | **GET** /api/v0/influence_system/profile/{influence_type}/{type}/{title} | Get current influence
[**getProfile**](InfluenceSystemApi.md#getprofile) | **GET** /api/v0/influence_system/profile | Get influence system profile
[**getRanks**](InfluenceSystemApi.md#getranks) | **GET** /api/v0/influence_system/ranks | List of all influence system ranks
[**getTributeHistory**](InfluenceSystemApi.md#gettributehistory) | **GET** /api/v0/influence_system/profile/tribute_history/{type}/{request}/{page} | Get tribute transaction history
[**sendTribute**](InfluenceSystemApi.md#sendtribute) | **POST** /api/v0/influence_system/transfer | Endpoint to send tribute to another corporateer
[**setWeight**](InfluenceSystemApi.md#setweight) | **POST** /api/v0/structure/set_weight | Division weight assignment


# **getInfluence**
> String getInfluence(influenceType, type, title)

Get current influence

<br/>This endpoint provide the current amount of specified influence<br/>

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getInfluenceSystemApi();
final String influenceType = influence; // String | type of influence
final String type = all; // String | type of influence
final String title = Development; // String | Department/Division title

try {
    final response = api.getInfluence(influenceType, type, title);
    print(response);
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

**String**

### Authorization

[corp_access_pass](../README.md#corp_access_pass)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getProfile**
> GetProfile200Response getProfile()

Get influence system profile

<br/>This endpoint provide profile information about the user that is currently connected<br/>

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getInfluenceSystemApi();

try {
    final response = api.getProfile();
    print(response);
} catch on DioException (e) {
    print('Exception when calling InfluenceSystemApi->getProfile: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**GetProfile200Response**](GetProfile200Response.md)

### Authorization

[corp_access_pass](../README.md#corp_access_pass)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getRanks**
> BuiltList<GetRanks200ResponseInner> getRanks()

List of all influence system ranks

<br/>Returns a list of all the ranks of the influence system<br/>

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
> BuiltList<GetTributeHistory200ResponseInner> getTributeHistory(type, request, page)

Get tribute transaction history

<br/>This endpoint provide the tribute submission history<br/>

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getInfluenceSystemApi();
final String type = sent; // String | sent/received
final String request = all; // String | page/all
final String page = 0; // String | page number

try {
    final response = api.getTributeHistory(type, request, page);
    print(response);
} catch on DioException (e) {
    print('Exception when calling InfluenceSystemApi->getTributeHistory: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **type** | **String**| sent/received | 
 **request** | **String**| page/all | 
 **page** | **String**| page number | 

### Return type

[**BuiltList&lt;GetTributeHistory200ResponseInner&gt;**](GetTributeHistory200ResponseInner.md)

### Authorization

[corp_access_pass](../README.md#corp_access_pass)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **sendTribute**
> GetRanks200ResponseInner sendTribute(sendTributeRequest)

Endpoint to send tribute to another corporateer

<br/>This is the main endpoint to effectuate tribute transfer to another corporateer<br/>

### Example
```dart
import 'package:corp_api/api.dart';

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

[corp_access_pass](../README.md#corp_access_pass)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **setWeight**
> setWeight(setWeightRequest)

Division weight assignment

<br/>This endpoint goal is to set the weight of the member's divisions <br/>

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getInfluenceSystemApi();
final SetWeightRequest setWeightRequest = ; // SetWeightRequest | Division information

try {
    api.setWeight(setWeightRequest);
} catch on DioException (e) {
    print('Exception when calling InfluenceSystemApi->setWeight: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **setWeightRequest** | [**SetWeightRequest**](SetWeightRequest.md)| Division information | [optional] 

### Return type

void (empty response body)

### Authorization

[corp_access_pass](../README.md#corp_access_pass)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

