# QuotaRequestsAPI

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiAdminRequestsCreate**](QuotaRequestsAPI.md#apiadminrequestscreate) | **POST** /api/admin/requests/ | Создать новый запрос на квоту
[**apiAdminRequestsDestroy**](QuotaRequestsAPI.md#apiadminrequestsdestroy) | **DELETE** /api/admin/requests/{id}/ | Удалить запрос на квоту
[**apiAdminRequestsDetailsRetrieve**](QuotaRequestsAPI.md#apiadminrequestsdetailsretrieve) | **GET** /api/admin/requests/{id}/details/ | Получить детальную информацию о квоте
[**apiAdminRequestsList**](QuotaRequestsAPI.md#apiadminrequestslist) | **GET** /api/admin/requests/ | Получить список запросов на квоты
[**apiAdminRequestsPartialUpdate**](QuotaRequestsAPI.md#apiadminrequestspartialupdate) | **PATCH** /api/admin/requests/{id}/ | Частично обновить запрос на квоту
[**apiAdminRequestsRetrieve**](QuotaRequestsAPI.md#apiadminrequestsretrieve) | **GET** /api/admin/requests/{id}/ | Получить информацию о конкретном запросе на квоту
[**apiAdminRequestsUpdate**](QuotaRequestsAPI.md#apiadminrequestsupdate) | **PUT** /api/admin/requests/{id}/ | Обновить данные запроса на квоту


# **apiAdminRequestsCreate**
```swift
    open class func apiAdminRequestsCreate(quotaRequest: QuotaRequest, completion: @escaping (_ data: QuotaRequest?, _ error: Error?) -> Void)
```

Создать новый запрос на квоту

Создаёт новый запрос на квоту. Требуются данные о офисе и сумме.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let quotaRequest = QuotaRequest(id: 123, office: 123, officeName: "officeName_example", amount: 123, status: StatusA13Enum(), createdAt: Date(), updatedAt: Date()) // QuotaRequest | 

// Создать новый запрос на квоту
QuotaRequestsAPI.apiAdminRequestsCreate(quotaRequest: quotaRequest) { (response, error) in
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
 **quotaRequest** | [**QuotaRequest**](QuotaRequest.md) |  | 

### Return type

[**QuotaRequest**](QuotaRequest.md)

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded, multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAdminRequestsDestroy**
```swift
    open class func apiAdminRequestsDestroy(id: Int, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Удалить запрос на квоту

Удаляет запрос на квоту по его ID.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Int | A unique integer value identifying this Запрос.

// Удалить запрос на квоту
QuotaRequestsAPI.apiAdminRequestsDestroy(id: id) { (response, error) in
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
 **id** | **Int** | A unique integer value identifying this Запрос. | 

### Return type

Void (empty response body)

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAdminRequestsDetailsRetrieve**
```swift
    open class func apiAdminRequestsDetailsRetrieve(id: Int, completion: @escaping (_ data: QuotaRequestDetail?, _ error: Error?) -> Void)
```

Получить детальную информацию о квоте

Возвращает детальную информацию о конкретной квоте, включая историю последних 5 запросов.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Int | A unique integer value identifying this Запрос.

// Получить детальную информацию о квоте
QuotaRequestsAPI.apiAdminRequestsDetailsRetrieve(id: id) { (response, error) in
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
 **id** | **Int** | A unique integer value identifying this Запрос. | 

### Return type

[**QuotaRequestDetail**](QuotaRequestDetail.md)

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAdminRequestsList**
```swift
    open class func apiAdminRequestsList(completion: @escaping (_ data: [QuotaRequest]?, _ error: Error?) -> Void)
```

Получить список запросов на квоты

Возвращает список квот со статусом `waited`. Доступно только администраторам.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient


// Получить список запросов на квоты
QuotaRequestsAPI.apiAdminRequestsList() { (response, error) in
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
This endpoint does not need any parameter.

### Return type

[**[QuotaRequest]**](QuotaRequest.md)

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAdminRequestsPartialUpdate**
```swift
    open class func apiAdminRequestsPartialUpdate(id: Int, patchedQuotaRequest: PatchedQuotaRequest? = nil, completion: @escaping (_ data: QuotaRequest?, _ error: Error?) -> Void)
```

Частично обновить запрос на квоту

Позволяет обновить отдельные поля запроса на квоту.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Int | A unique integer value identifying this Запрос.
let patchedQuotaRequest = PatchedQuotaRequest(id: 123, office: 123, officeName: "officeName_example", amount: 123, status: StatusA13Enum(), createdAt: Date(), updatedAt: Date()) // PatchedQuotaRequest |  (optional)

// Частично обновить запрос на квоту
QuotaRequestsAPI.apiAdminRequestsPartialUpdate(id: id, patchedQuotaRequest: patchedQuotaRequest) { (response, error) in
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
 **id** | **Int** | A unique integer value identifying this Запрос. | 
 **patchedQuotaRequest** | [**PatchedQuotaRequest**](PatchedQuotaRequest.md) |  | [optional] 

### Return type

[**QuotaRequest**](QuotaRequest.md)

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded, multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAdminRequestsRetrieve**
```swift
    open class func apiAdminRequestsRetrieve(id: Int, completion: @escaping (_ data: QuotaRequest?, _ error: Error?) -> Void)
```

Получить информацию о конкретном запросе на квоту

Возвращает детальную информацию о запросе на квоту по его ID.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Int | A unique integer value identifying this Запрос.

// Получить информацию о конкретном запросе на квоту
QuotaRequestsAPI.apiAdminRequestsRetrieve(id: id) { (response, error) in
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
 **id** | **Int** | A unique integer value identifying this Запрос. | 

### Return type

[**QuotaRequest**](QuotaRequest.md)

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAdminRequestsUpdate**
```swift
    open class func apiAdminRequestsUpdate(id: Int, quotaRequest: QuotaRequest, completion: @escaping (_ data: QuotaRequest?, _ error: Error?) -> Void)
```

Обновить данные запроса на квоту

Полностью обновляет данные запроса на квоту по его ID.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Int | A unique integer value identifying this Запрос.
let quotaRequest = QuotaRequest(id: 123, office: 123, officeName: "officeName_example", amount: 123, status: StatusA13Enum(), createdAt: Date(), updatedAt: Date()) // QuotaRequest | 

// Обновить данные запроса на квоту
QuotaRequestsAPI.apiAdminRequestsUpdate(id: id, quotaRequest: quotaRequest) { (response, error) in
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
 **id** | **Int** | A unique integer value identifying this Запрос. | 
 **quotaRequest** | [**QuotaRequest**](QuotaRequest.md) |  | 

### Return type

[**QuotaRequest**](QuotaRequest.md)

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded, multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

