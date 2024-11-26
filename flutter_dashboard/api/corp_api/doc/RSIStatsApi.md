# corp_api.api.RSIStatsApi

## Load the API package
```dart
import 'package:corp_api/api.dart';
```

All URIs are relative to *http://localhost:5000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getCurrentFunding**](RSIStatsApi.md#getcurrentfunding) | **GET** /api/v0/current_funding | List of all influence system ranks


# **getCurrentFunding**
> GetCurrentFunding200Response getCurrentFunding()

List of all influence system ranks

<br/>This endpoint fetch the current funding from RSI website<br/>

### Example
```dart
import 'package:corp_api/api.dart';

final api = CorpApi().getRSIStatsApi();

try {
    final response = api.getCurrentFunding();
    print(response);
} catch on DioException (e) {
    print('Exception when calling RSIStatsApi->getCurrentFunding: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**GetCurrentFunding200Response**](GetCurrentFunding200Response.md)

### Authorization

[corp_access_pass](../README.md#corp_access_pass)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

