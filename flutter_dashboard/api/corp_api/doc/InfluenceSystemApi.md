# corp_api.api.InfluenceSystemApi

## Load the API package
```dart
import 'package:corp_api/api.dart';
```

All URIs are relative to *https://thecorporation.space*

Method | HTTP request | Description
------------- | ------------- | -------------
[**closeAuction**](InfluenceSystemApi.md#closeauction) | **POST** /api/v0/influence_system/auction/close | Close an auction by ID
[**createAuction**](InfluenceSystemApi.md#createauction) | **POST** /api/v0/influence_system/auction | Create a new auction
[**deleteAuction**](InfluenceSystemApi.md#deleteauction) | **DELETE** /api/v0/influence_system/auction | Delete an auction by ID (ID in POST data)
[**getInfluence**](InfluenceSystemApi.md#getinfluence) | **GET** /api/v0/influence_system/profile/{influence_type}/{type}/{title} | Get current influence
[**getProfile**](InfluenceSystemApi.md#getprofile) | **GET** /api/v0/influence_system/profile | Get influence system profile
[**getRanks**](InfluenceSystemApi.md#getranks) | **GET** /api/v0/influence_system/ranks | List of all influence system ranks
[**getTributeHistory**](InfluenceSystemApi.md#gettributehistory) | **GET** /api/v0/influence_system/profile/tribute_history/{type}/{request}/{page} | Get tribute transaction history
[**getUserInfluenceStats**](InfluenceSystemApi.md#getuserinfluencestats) | **GET** /api/v0/influence_system/profile/stats | Get influence stats
[**listAuctions**](InfluenceSystemApi.md#listauctions) | **GET** /api/v0/influence_system/auction | Get a list of all auctions
[**placeBet**](InfluenceSystemApi.md#placebet) | **POST** /api/v0/influence_system/auction/bet | Place a bet on an auction
[**sendTribute**](InfluenceSystemApi.md#sendtribute) | **POST** /api/v0/influence_system/transfer | Endpoint to send tribute to another corporateer
[**updateAccount**](InfluenceSystemApi.md#updateaccount) | **GET** /api/v0/influence_system/update | Update influence system account


# **closeAuction**
> CloseAuction200Response closeAuction(deleteAuctionRequest)

Close an auction by ID

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getInfluenceSystemApi();
final DeleteAuctionRequest deleteAuctionRequest = ; // DeleteAuctionRequest | Auction ID to close

try {
    final response = api.closeAuction(deleteAuctionRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling InfluenceSystemApi->closeAuction: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **deleteAuctionRequest** | [**DeleteAuctionRequest**](DeleteAuctionRequest.md)| Auction ID to close | [optional] 

### Return type

[**CloseAuction200Response**](CloseAuction200Response.md)

### Authorization

[corp_access_pass](../README.md#corp_access_pass)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createAuction**
> CreateAuction201Response createAuction(createAuctionRequest)

Create a new auction

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getInfluenceSystemApi();
final CreateAuctionRequest createAuctionRequest = ; // CreateAuctionRequest | Auction creation data

try {
    final response = api.createAuction(createAuctionRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling InfluenceSystemApi->createAuction: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createAuctionRequest** | [**CreateAuctionRequest**](CreateAuctionRequest.md)| Auction creation data | [optional] 

### Return type

[**CreateAuction201Response**](CreateAuction201Response.md)

### Authorization

[corp_access_pass](../README.md#corp_access_pass)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteAuction**
> DeleteAuction200Response deleteAuction(deleteAuctionRequest)

Delete an auction by ID (ID in POST data)

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getInfluenceSystemApi();
final DeleteAuctionRequest deleteAuctionRequest = ; // DeleteAuctionRequest | Auction ID to delete

try {
    final response = api.deleteAuction(deleteAuctionRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling InfluenceSystemApi->deleteAuction: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **deleteAuctionRequest** | [**DeleteAuctionRequest**](DeleteAuctionRequest.md)| Auction ID to delete | [optional] 

### Return type

[**DeleteAuction200Response**](DeleteAuction200Response.md)

### Authorization

[corp_access_pass](../README.md#corp_access_pass)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

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

# **getUserInfluenceStats**
> GetUserInfluenceStats200Response getUserInfluenceStats()

Get influence stats

<br/>This endpoint provide the current amount of specified influence<br/>

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getInfluenceSystemApi();

try {
    final response = api.getUserInfluenceStats();
    print(response);
} catch on DioException (e) {
    print('Exception when calling InfluenceSystemApi->getUserInfluenceStats: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**GetUserInfluenceStats200Response**](GetUserInfluenceStats200Response.md)

### Authorization

[corp_access_pass](../README.md#corp_access_pass)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listAuctions**
> BuiltList<ListAuctions200ResponseInner> listAuctions()

Get a list of all auctions

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getInfluenceSystemApi();

try {
    final response = api.listAuctions();
    print(response);
} catch on DioException (e) {
    print('Exception when calling InfluenceSystemApi->listAuctions: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;ListAuctions200ResponseInner&gt;**](ListAuctions200ResponseInner.md)

### Authorization

[corp_access_pass](../README.md#corp_access_pass)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **placeBet**
> PlaceBet200Response placeBet(placeBetRequest)

Place a bet on an auction

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getInfluenceSystemApi();
final PlaceBetRequest placeBetRequest = ; // PlaceBetRequest | Bet information

try {
    final response = api.placeBet(placeBetRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling InfluenceSystemApi->placeBet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **placeBetRequest** | [**PlaceBetRequest**](PlaceBetRequest.md)| Bet information | [optional] 

### Return type

[**PlaceBet200Response**](PlaceBet200Response.md)

### Authorization

[corp_access_pass](../README.md#corp_access_pass)

### HTTP request headers

 - **Content-Type**: application/json
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

# **updateAccount**
> updateAccount()

Update influence system account

<br/>This endpoint updates the influence system account<br/>

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getInfluenceSystemApi();

try {
    api.updateAccount();
} catch on DioException (e) {
    print('Exception when calling InfluenceSystemApi->updateAccount: $e\n');
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

