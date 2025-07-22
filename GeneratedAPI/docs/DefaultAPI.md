# DefaultAPI

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**rootRetrieve**](DefaultAPI.md#rootretrieve) | **GET** /api/schema/ | 


# **rootRetrieve**
```swift
    open class func rootRetrieve(format: Format_rootRetrieve? = nil, lang: Lang_rootRetrieve? = nil, completion: @escaping (_ data: [String: AnyCodable]?, _ error: Error?) -> Void)
```



OpenApi3 schema for this API. Format can be selected via content negotiation.  - YAML: application/vnd.oai.openapi - JSON: application/vnd.oai.openapi+json

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let format = "format_example" // String |  (optional)
let lang = "lang_example" // String |  (optional)

DefaultAPI.rootRetrieve(format: format, lang: lang) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **format** | **String** |  | [optional] 
 **lang** | **String** |  | [optional] 

### Return type

**[String: AnyCodable]**

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/vnd.oai.openapi, application/yaml, application/vnd.oai.openapi+json, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

