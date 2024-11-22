# corp_api.api.InformationApi

## Load the API package
```dart
import 'package:corp_api/api.dart';
```

All URIs are relative to *http://localhost:5000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getCorporateers**](InformationApi.md#getcorporateers) | **GET** /api/v0/corporateers | List of all corporateer


# **getCorporateers**
> BuiltList<GetCorporateers200ResponseInner> getCorporateers()

List of all corporateer

<br/>Returns a list of all the corporateers registered on the website.<br/>

### Example
```dart
import 'package:corp_api/api.dart';
// TODO Configure API key authorization: cookieAuth
//defaultApiClient.getAuthentication<ApiKeyAuth>('cookieAuth').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('cookieAuth').apiKeyPrefix = 'Bearer';

final api = CorpApi().getInformationApi();

try {
    final response = api.getCorporateers();
    print(response);
} catch on DioException (e) {
    print('Exception when calling InformationApi->getCorporateers: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;GetCorporateers200ResponseInner&gt;**](GetCorporateers200ResponseInner.md)

### Authorization

[cookieAuth](../README.md#cookieAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

