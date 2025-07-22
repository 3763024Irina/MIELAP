# ApiAPI

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiAdminArchiveList**](ApiAPI.md#apiadminarchivelist) | **GET** /api/admin/archive/ | Получение информации о архивных кандидатах
[**apiAdminArchiveRestoreCreate**](ApiAPI.md#apiadminarchiverestorecreate) | **POST** /api/admin/archive/restore/ | Восстановление архивированных кандидатов
[**apiAdminCandidatesCreate**](ApiAPI.md#apiadmincandidatescreate) | **POST** /api/admin/candidates/ | Список кандидатов
[**apiAdminCandidatesDestroy**](ApiAPI.md#apiadmincandidatesdestroy) | **DELETE** /api/admin/candidates/{id}/ | Список кандидатов
[**apiAdminCandidatesInvitationsPartialUpdate**](ApiAPI.md#apiadmincandidatesinvitationspartialupdate) | **PATCH** /api/admin/candidates/{candidate_id}/invitations/{invitation_id}/ | Обновление статуса приглашения
[**apiAdminCandidatesInvitationsRetrieve**](ApiAPI.md#apiadmincandidatesinvitationsretrieve) | **GET** /api/admin/candidates/{id}/invitations/ | Получение приглашений кандидата
[**apiAdminCandidatesList**](ApiAPI.md#apiadmincandidateslist) | **GET** /api/admin/candidates/ | Список кандидатов
[**apiAdminCandidatesList2**](ApiAPI.md#apiadmincandidateslist2) | **GET** /api/admin/candidates/{id}/ | Список кандидатов
[**apiAdminCandidatesPartialUpdate**](ApiAPI.md#apiadmincandidatespartialupdate) | **PATCH** /api/admin/candidates/{id}/ | Список кандидатов
[**apiAdminCandidatesUpdate**](ApiAPI.md#apiadmincandidatesupdate) | **PUT** /api/admin/candidates/{id}/ | Список кандидатов
[**apiAdminOfficesCreate**](ApiAPI.md#apiadminofficescreate) | **POST** /api/admin/offices/ | Получить список офисов
[**apiAdminOfficesDestroy**](ApiAPI.md#apiadminofficesdestroy) | **DELETE** /api/admin/offices/{id}/ | Получить список офисов
[**apiAdminOfficesList**](ApiAPI.md#apiadminofficeslist) | **GET** /api/admin/offices/ | Получить список офисов
[**apiAdminOfficesPartialUpdate**](ApiAPI.md#apiadminofficespartialupdate) | **PATCH** /api/admin/offices/{id}/ | Получить список офисов
[**apiAdminOfficesRetrieve**](ApiAPI.md#apiadminofficesretrieve) | **GET** /api/admin/offices/{id}/ | Получить список офисов
[**apiAdminOfficesUpdate**](ApiAPI.md#apiadminofficesupdate) | **PUT** /api/admin/offices/{id}/ | Получить список офисов
[**apiAdminQuotasUpdateCreate**](ApiAPI.md#apiadminquotasupdatecreate) | **POST** /api/admin/quotas/update/ | Массовое обновление квот офисов
[**apiAdminStatisticInvitationsList**](ApiAPI.md#apiadminstatisticinvitationslist) | **GET** /api/admin/statistic/invitations/ | Статистика приглашений
[**apiAdminStatisticQuotasRetrieve**](ApiAPI.md#apiadminstatisticquotasretrieve) | **GET** /api/admin/statistic/quotas/ | Получение статистики по месяцам для администратора
[**apiAdminSupervisorsCreate**](ApiAPI.md#apiadminsupervisorscreate) | **POST** /api/admin/supervisors/ | Список супервайзеров
[**apiAdminSupervisorsDestroy**](ApiAPI.md#apiadminsupervisorsdestroy) | **DELETE** /api/admin/supervisors/{id}/ | Список супервайзеров
[**apiAdminSupervisorsList**](ApiAPI.md#apiadminsupervisorslist) | **GET** /api/admin/supervisors/ | Список супервайзеров
[**apiAdminSupervisorsList2**](ApiAPI.md#apiadminsupervisorslist2) | **GET** /api/admin/supervisors/{id}/ | Список супервайзеров
[**apiAdminSupervisorsPartialUpdate**](ApiAPI.md#apiadminsupervisorspartialupdate) | **PATCH** /api/admin/supervisors/{id}/ | Список супервайзеров
[**apiAdminSupervisorsUpdate**](ApiAPI.md#apiadminsupervisorsupdate) | **PUT** /api/admin/supervisors/{id}/ | Список супервайзеров
[**apiInfoRetrieve**](ApiAPI.md#apiinforetrieve) | **GET** /api/info/ | Получение полной информации о пользователе
[**apiLinkCreate**](ApiAPI.md#apilinkcreate) | **POST** /api/link/ | Обновление ссылки чата
[**apiLinkRetrieve**](ApiAPI.md#apilinkretrieve) | **GET** /api/link/ | Получение ссылки чата
[**apiLoginCreate**](ApiAPI.md#apilogincreate) | **POST** /api/login/ | Авторизация пользователя
[**apiLogoutCreate**](ApiAPI.md#apilogoutcreate) | **POST** /api/logout/ | Выход из системы
[**apiSupervisorCandidatesList**](ApiAPI.md#apisupervisorcandidateslist) | **GET** /api/supervisor/candidates/ | Получение информации о кандидатах
[**apiSupervisorFavoritesCreate**](ApiAPI.md#apisupervisorfavoritescreate) | **POST** /api/supervisor/favorites/ | Добавить в избранное
[**apiSupervisorFavoritesDestroy**](ApiAPI.md#apisupervisorfavoritesdestroy) | **DELETE** /api/supervisor/favorites/{id}/ | Удалить из избранного
[**apiSupervisorFavoritesList**](ApiAPI.md#apisupervisorfavoriteslist) | **GET** /api/supervisor/favorites/ | Получить список избранного
[**apiSupervisorFavoritesPartialUpdate**](ApiAPI.md#apisupervisorfavoritespartialupdate) | **PATCH** /api/supervisor/favorites/{id}/ | 
[**apiSupervisorFavoritesRetrieve**](ApiAPI.md#apisupervisorfavoritesretrieve) | **GET** /api/supervisor/favorites/{id}/ | Получить избранный объект
[**apiSupervisorFavoritesUpdate**](ApiAPI.md#apisupervisorfavoritesupdate) | **PUT** /api/supervisor/favorites/{id}/ | Обновить избранный объект
[**apiSupervisorInvitationsCreate**](ApiAPI.md#apisupervisorinvitationscreate) | **POST** /api/supervisor/invitations/ | Создать новое приглашение
[**apiSupervisorInvitationsRetrieve**](ApiAPI.md#apisupervisorinvitationsretrieve) | **GET** /api/supervisor/invitations/ | Получение списка приглашённых кандидатов
[**apiSupervisorStatisticQuotasList**](ApiAPI.md#apisupervisorstatisticquotaslist) | **GET** /api/supervisor/statistic/quotas/ | Статистика по месяцам
[**apiTodoStatsRetrieve**](ApiAPI.md#apitodostatsretrieve) | **GET** /api/todo-stats/ | Получить статистику TODO
[**apiTodosCreate**](ApiAPI.md#apitodoscreate) | **POST** /api/todos/ | Получение списка задач
[**apiTodosDestroy**](ApiAPI.md#apitodosdestroy) | **DELETE** /api/todos/{id}/ | Получение списка задач
[**apiTodosList**](ApiAPI.md#apitodoslist) | **GET** /api/todos/ | Получение списка задач
[**apiTodosPartialUpdate**](ApiAPI.md#apitodospartialupdate) | **PATCH** /api/todos/{id}/ | Получение списка задач
[**apiTodosRetrieve**](ApiAPI.md#apitodosretrieve) | **GET** /api/todos/{id}/ | Получение списка задач
[**apiTodosUpdate**](ApiAPI.md#apitodosupdate) | **PUT** /api/todos/{id}/ | Получение списка задач


# **apiAdminArchiveList**
```swift
    open class func apiAdminArchiveList(endDate: Date? = nil, startDate: Date? = nil, completion: @escaping (_ data: [ArchiveCandidate]?, _ error: Error?) -> Void)
```

Получение информации о архивных кандидатах

Возвращает список архивированных кандидатов. Кандидаты фильтруются по датам обновления в зависимости от параметров запроса 'start_date' и 'end_date'.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let endDate = Date() // Date | Дата конца фильтрации по дате обновления (в формате YYYY-MM-DD). (optional)
let startDate = Date() // Date | Дата начала фильтрации по дате обновления (в формате YYYY-MM-DD). (optional)

// Получение информации о архивных кандидатах
ApiAPI.apiAdminArchiveList(endDate: endDate, startDate: startDate) { (response, error) in
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
 **endDate** | **Date** | Дата конца фильтрации по дате обновления (в формате YYYY-MM-DD). | [optional] 
 **startDate** | **Date** | Дата начала фильтрации по дате обновления (в формате YYYY-MM-DD). | [optional] 

### Return type

[**[ArchiveCandidate]**](ArchiveCandidate.md)

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAdminArchiveRestoreCreate**
```swift
    open class func apiAdminArchiveRestoreCreate(candidateIds: String, completion: @escaping (_ data: AnyCodable?, _ error: Error?) -> Void)
```

Восстановление архивированных кандидатов

Позволяет восстановить кандидатов из архива. Требуется передать список ID кандидатов, разделённых запятой, в теле запроса. Если ID кандидатов некорректны, будет возвращена ошибка.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let candidateIds = "candidateIds_example" // String | Строка с ID кандидатов, разделённая запятой. Например: '1, 2, 3'.

// Восстановление архивированных кандидатов
ApiAPI.apiAdminArchiveRestoreCreate(candidateIds: candidateIds) { (response, error) in
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
 **candidateIds** | **String** | Строка с ID кандидатов, разделённая запятой. Например: &#39;1, 2, 3&#39;. | 

### Return type

**AnyCodable**

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAdminCandidatesCreate**
```swift
    open class func apiAdminCandidatesCreate(candidate: Candidate, isFree: String? = nil, search: String? = nil, completion: @escaping (_ data: [Candidate]?, _ error: Error?) -> Void)
```

Список кандидатов

Возвращает список кандидатов с возможностью фильтрации по состоянию и имени.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let candidate = Candidate(id: 123, age: 123, officeName: "officeName_example", courses: [Course(id: 123, name: "name_example")], coursesIds: [123], birth: Date(), isArchive: false, name: "name_example", surname: "surname_example", patronymic: "patronymic_example", education: "education_example", photo: "photo_example", country: "country_example", city: "city_example", email: "email_example", phone: "phone_example", resume: "resume_example", agreement: "agreement_example", isFree: false, achivmentObjects: 123, achivmentClients: 123, achivmentLeads: 123, achivmentExclusives: 123, achivmentDeals: 123, createdAt: Date(), updatedAt: Date(), office: 123) // Candidate | 
let isFree = "isFree_example" // String | Фильтрация кандидатов по состоянию: свободен (true/false). (optional)
let search = "search_example" // String | Поиск кандидатов по имени (регистронезависимый). (optional)

// Список кандидатов
ApiAPI.apiAdminCandidatesCreate(candidate: candidate, isFree: isFree, search: search) { (response, error) in
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
 **candidate** | [**Candidate**](Candidate.md) |  | 
 **isFree** | **String** | Фильтрация кандидатов по состоянию: свободен (true/false). | [optional] 
 **search** | **String** | Поиск кандидатов по имени (регистронезависимый). | [optional] 

### Return type

[**[Candidate]**](Candidate.md)

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded, multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAdminCandidatesDestroy**
```swift
    open class func apiAdminCandidatesDestroy(id: Int, isFree: String? = nil, search: String? = nil, completion: @escaping (_ data: [Candidate]?, _ error: Error?) -> Void)
```

Список кандидатов

Возвращает список кандидатов с возможностью фильтрации по состоянию и имени.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Int | A unique integer value identifying this Кандидат.
let isFree = "isFree_example" // String | Фильтрация кандидатов по состоянию: свободен (true/false). (optional)
let search = "search_example" // String | Поиск кандидатов по имени (регистронезависимый). (optional)

// Список кандидатов
ApiAPI.apiAdminCandidatesDestroy(id: id, isFree: isFree, search: search) { (response, error) in
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
 **id** | **Int** | A unique integer value identifying this Кандидат. | 
 **isFree** | **String** | Фильтрация кандидатов по состоянию: свободен (true/false). | [optional] 
 **search** | **String** | Поиск кандидатов по имени (регистронезависимый). | [optional] 

### Return type

[**[Candidate]**](Candidate.md)

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAdminCandidatesInvitationsPartialUpdate**
```swift
    open class func apiAdminCandidatesInvitationsPartialUpdate(candidateId: Int, invitationId: Int, body: AnyCodable? = nil, completion: @escaping (_ data: AnyCodable?, _ error: Error?) -> Void)
```

Обновление статуса приглашения

Позволяет обновить статус конкретного приглашения кандидата.  Поддерживаемые статусы: 'accepted', 'invited', 'rejected', 'self_rejected'.в случае, если передан accepted все остальные приглашения кандидата будут отклонены

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let candidateId = 987 // Int | Идентификатор кандидата
let invitationId = 987 // Int | Идентификатор приглашения
let body =  // AnyCodable |  (optional)

// Обновление статуса приглашения
ApiAPI.apiAdminCandidatesInvitationsPartialUpdate(candidateId: candidateId, invitationId: invitationId, body: body) { (response, error) in
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
 **candidateId** | **Int** | Идентификатор кандидата | 
 **invitationId** | **Int** | Идентификатор приглашения | 
 **body** | **AnyCodable** |  | [optional] 

### Return type

**AnyCodable**

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAdminCandidatesInvitationsRetrieve**
```swift
    open class func apiAdminCandidatesInvitationsRetrieve(id: Int, completion: @escaping (_ data: [AdminInvitation]?, _ error: Error?) -> Void)
```

Получение приглашений кандидата

Возвращает список приглашений, связанных с указанным кандидатом. Требует идентификатор кандидата в URL.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Int | Идентификатор кандидата

// Получение приглашений кандидата
ApiAPI.apiAdminCandidatesInvitationsRetrieve(id: id) { (response, error) in
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
 **id** | **Int** | Идентификатор кандидата | 

### Return type

[**[AdminInvitation]**](AdminInvitation.md)

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAdminCandidatesList**
```swift
    open class func apiAdminCandidatesList(isFree: String? = nil, search: String? = nil, completion: @escaping (_ data: [Candidate]?, _ error: Error?) -> Void)
```

Список кандидатов

Возвращает список кандидатов с возможностью фильтрации по состоянию и имени.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let isFree = "isFree_example" // String | Фильтрация кандидатов по состоянию: свободен (true/false). (optional)
let search = "search_example" // String | Поиск кандидатов по имени (регистронезависимый). (optional)

// Список кандидатов
ApiAPI.apiAdminCandidatesList(isFree: isFree, search: search) { (response, error) in
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
 **isFree** | **String** | Фильтрация кандидатов по состоянию: свободен (true/false). | [optional] 
 **search** | **String** | Поиск кандидатов по имени (регистронезависимый). | [optional] 

### Return type

[**[Candidate]**](Candidate.md)

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAdminCandidatesList2**
```swift
    open class func apiAdminCandidatesList2(id: Int, isFree: String? = nil, search: String? = nil, completion: @escaping (_ data: [Candidate]?, _ error: Error?) -> Void)
```

Список кандидатов

Возвращает список кандидатов с возможностью фильтрации по состоянию и имени.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Int | A unique integer value identifying this Кандидат.
let isFree = "isFree_example" // String | Фильтрация кандидатов по состоянию: свободен (true/false). (optional)
let search = "search_example" // String | Поиск кандидатов по имени (регистронезависимый). (optional)

// Список кандидатов
ApiAPI.apiAdminCandidatesList2(id: id, isFree: isFree, search: search) { (response, error) in
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
 **id** | **Int** | A unique integer value identifying this Кандидат. | 
 **isFree** | **String** | Фильтрация кандидатов по состоянию: свободен (true/false). | [optional] 
 **search** | **String** | Поиск кандидатов по имени (регистронезависимый). | [optional] 

### Return type

[**[Candidate]**](Candidate.md)

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAdminCandidatesPartialUpdate**
```swift
    open class func apiAdminCandidatesPartialUpdate(id: Int, isFree: String? = nil, search: String? = nil, patchedCandidate: PatchedCandidate? = nil, completion: @escaping (_ data: [Candidate]?, _ error: Error?) -> Void)
```

Список кандидатов

Возвращает список кандидатов с возможностью фильтрации по состоянию и имени.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Int | A unique integer value identifying this Кандидат.
let isFree = "isFree_example" // String | Фильтрация кандидатов по состоянию: свободен (true/false). (optional)
let search = "search_example" // String | Поиск кандидатов по имени (регистронезависимый). (optional)
let patchedCandidate = PatchedCandidate(id: 123, age: 123, officeName: "officeName_example", courses: [Course(id: 123, name: "name_example")], coursesIds: [123], birth: Date(), isArchive: false, name: "name_example", surname: "surname_example", patronymic: "patronymic_example", education: "education_example", photo: "photo_example", country: "country_example", city: "city_example", email: "email_example", phone: "phone_example", resume: "resume_example", agreement: "agreement_example", isFree: false, achivmentObjects: 123, achivmentClients: 123, achivmentLeads: 123, achivmentExclusives: 123, achivmentDeals: 123, createdAt: Date(), updatedAt: Date(), office: 123) // PatchedCandidate |  (optional)

// Список кандидатов
ApiAPI.apiAdminCandidatesPartialUpdate(id: id, isFree: isFree, search: search, patchedCandidate: patchedCandidate) { (response, error) in
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
 **id** | **Int** | A unique integer value identifying this Кандидат. | 
 **isFree** | **String** | Фильтрация кандидатов по состоянию: свободен (true/false). | [optional] 
 **search** | **String** | Поиск кандидатов по имени (регистронезависимый). | [optional] 
 **patchedCandidate** | [**PatchedCandidate**](PatchedCandidate.md) |  | [optional] 

### Return type

[**[Candidate]**](Candidate.md)

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded, multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAdminCandidatesUpdate**
```swift
    open class func apiAdminCandidatesUpdate(id: Int, candidate: Candidate, isFree: String? = nil, search: String? = nil, completion: @escaping (_ data: [Candidate]?, _ error: Error?) -> Void)
```

Список кандидатов

Возвращает список кандидатов с возможностью фильтрации по состоянию и имени.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Int | A unique integer value identifying this Кандидат.
let candidate = Candidate(id: 123, age: 123, officeName: "officeName_example", courses: [Course(id: 123, name: "name_example")], coursesIds: [123], birth: Date(), isArchive: false, name: "name_example", surname: "surname_example", patronymic: "patronymic_example", education: "education_example", photo: "photo_example", country: "country_example", city: "city_example", email: "email_example", phone: "phone_example", resume: "resume_example", agreement: "agreement_example", isFree: false, achivmentObjects: 123, achivmentClients: 123, achivmentLeads: 123, achivmentExclusives: 123, achivmentDeals: 123, createdAt: Date(), updatedAt: Date(), office: 123) // Candidate | 
let isFree = "isFree_example" // String | Фильтрация кандидатов по состоянию: свободен (true/false). (optional)
let search = "search_example" // String | Поиск кандидатов по имени (регистронезависимый). (optional)

// Список кандидатов
ApiAPI.apiAdminCandidatesUpdate(id: id, candidate: candidate, isFree: isFree, search: search) { (response, error) in
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
 **id** | **Int** | A unique integer value identifying this Кандидат. | 
 **candidate** | [**Candidate**](Candidate.md) |  | 
 **isFree** | **String** | Фильтрация кандидатов по состоянию: свободен (true/false). | [optional] 
 **search** | **String** | Поиск кандидатов по имени (регистронезависимый). | [optional] 

### Return type

[**[Candidate]**](Candidate.md)

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded, multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAdminOfficesCreate**
```swift
    open class func apiAdminOfficesCreate(office: Office, search: String? = nil, completion: @escaping (_ data: Office?, _ error: Error?) -> Void)
```

Получить список офисов

Возвращает список офисов с возможностью фильтрации по имени. Используйте параметр `search` для поиска.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let office = Office(id: 123, name: "name_example", location: "location_example", phone: "phone_example", quota: 123, usedQuota: 123, createdAt: Date()) // Office | 
let search = "search_example" // String | Фильтр по названию офиса (регистронезависимый поиск). (optional)

// Получить список офисов
ApiAPI.apiAdminOfficesCreate(office: office, search: search) { (response, error) in
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
 **office** | [**Office**](Office.md) |  | 
 **search** | **String** | Фильтр по названию офиса (регистронезависимый поиск). | [optional] 

### Return type

[**Office**](Office.md)

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded, multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAdminOfficesDestroy**
```swift
    open class func apiAdminOfficesDestroy(id: Int, search: String? = nil, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Получить список офисов

Возвращает список офисов с возможностью фильтрации по имени. Используйте параметр `search` для поиска.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Int | A unique integer value identifying this Офис.
let search = "search_example" // String | Фильтр по названию офиса (регистронезависимый поиск). (optional)

// Получить список офисов
ApiAPI.apiAdminOfficesDestroy(id: id, search: search) { (response, error) in
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
 **id** | **Int** | A unique integer value identifying this Офис. | 
 **search** | **String** | Фильтр по названию офиса (регистронезависимый поиск). | [optional] 

### Return type

Void (empty response body)

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAdminOfficesList**
```swift
    open class func apiAdminOfficesList(search: String? = nil, completion: @escaping (_ data: [Office]?, _ error: Error?) -> Void)
```

Получить список офисов

Возвращает список офисов с возможностью фильтрации по имени. Используйте параметр `search` для поиска.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let search = "search_example" // String | Фильтр по названию офиса (регистронезависимый поиск). (optional)

// Получить список офисов
ApiAPI.apiAdminOfficesList(search: search) { (response, error) in
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
 **search** | **String** | Фильтр по названию офиса (регистронезависимый поиск). | [optional] 

### Return type

[**[Office]**](Office.md)

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAdminOfficesPartialUpdate**
```swift
    open class func apiAdminOfficesPartialUpdate(id: Int, search: String? = nil, patchedOffice: PatchedOffice? = nil, completion: @escaping (_ data: Office?, _ error: Error?) -> Void)
```

Получить список офисов

Возвращает список офисов с возможностью фильтрации по имени. Используйте параметр `search` для поиска.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Int | A unique integer value identifying this Офис.
let search = "search_example" // String | Фильтр по названию офиса (регистронезависимый поиск). (optional)
let patchedOffice = PatchedOffice(id: 123, name: "name_example", location: "location_example", phone: "phone_example", quota: 123, usedQuota: 123, createdAt: Date()) // PatchedOffice |  (optional)

// Получить список офисов
ApiAPI.apiAdminOfficesPartialUpdate(id: id, search: search, patchedOffice: patchedOffice) { (response, error) in
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
 **id** | **Int** | A unique integer value identifying this Офис. | 
 **search** | **String** | Фильтр по названию офиса (регистронезависимый поиск). | [optional] 
 **patchedOffice** | [**PatchedOffice**](PatchedOffice.md) |  | [optional] 

### Return type

[**Office**](Office.md)

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded, multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAdminOfficesRetrieve**
```swift
    open class func apiAdminOfficesRetrieve(id: Int, search: String? = nil, completion: @escaping (_ data: Office?, _ error: Error?) -> Void)
```

Получить список офисов

Возвращает список офисов с возможностью фильтрации по имени. Используйте параметр `search` для поиска.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Int | A unique integer value identifying this Офис.
let search = "search_example" // String | Фильтр по названию офиса (регистронезависимый поиск). (optional)

// Получить список офисов
ApiAPI.apiAdminOfficesRetrieve(id: id, search: search) { (response, error) in
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
 **id** | **Int** | A unique integer value identifying this Офис. | 
 **search** | **String** | Фильтр по названию офиса (регистронезависимый поиск). | [optional] 

### Return type

[**Office**](Office.md)

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAdminOfficesUpdate**
```swift
    open class func apiAdminOfficesUpdate(id: Int, office: Office, search: String? = nil, completion: @escaping (_ data: Office?, _ error: Error?) -> Void)
```

Получить список офисов

Возвращает список офисов с возможностью фильтрации по имени. Используйте параметр `search` для поиска.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Int | A unique integer value identifying this Офис.
let office = Office(id: 123, name: "name_example", location: "location_example", phone: "phone_example", quota: 123, usedQuota: 123, createdAt: Date()) // Office | 
let search = "search_example" // String | Фильтр по названию офиса (регистронезависимый поиск). (optional)

// Получить список офисов
ApiAPI.apiAdminOfficesUpdate(id: id, office: office, search: search) { (response, error) in
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
 **id** | **Int** | A unique integer value identifying this Офис. | 
 **office** | [**Office**](Office.md) |  | 
 **search** | **String** | Фильтр по названию офиса (регистронезависимый поиск). | [optional] 

### Return type

[**Office**](Office.md)

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded, multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAdminQuotasUpdateCreate**
```swift
    open class func apiAdminQuotasUpdateCreate(body: AnyCodable? = nil, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Массовое обновление квот офисов

Позволяет администратору изменить квоты нескольких офисов сразу. Если новое значение квоты больше текущего, происходит увеличение, если меньше — уменьшение. Для каждой операции создается транзакция.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let body = 987 // AnyCodable |  (optional)

// Массовое обновление квот офисов
ApiAPI.apiAdminQuotasUpdateCreate(body: body) { (response, error) in
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
 **body** | **AnyCodable** |  | [optional] 

### Return type

Void (empty response body)

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAdminStatisticInvitationsList**
```swift
    open class func apiAdminStatisticInvitationsList(endDate: String? = nil, officeId: String? = nil, startDate: String? = nil, completion: @escaping (_ data: [InvitationStatistics]?, _ error: Error?) -> Void)
```

Статистика приглашений

Позволяет получить статистику по приглашениям с фильтрацией по диапазону дат.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let endDate = "endDate_example" // String | Конечная дата в формате YYYY-MM-DDTHH:MM:SSZ. (optional)
let officeId = "officeId_example" // String | id фильтруемого оффиса (optional)
let startDate = "startDate_example" // String | Начальная дата в формате YYYY-MM-DDTHH:MM:SSZ. (optional)

// Статистика приглашений
ApiAPI.apiAdminStatisticInvitationsList(endDate: endDate, officeId: officeId, startDate: startDate) { (response, error) in
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
 **endDate** | **String** | Конечная дата в формате YYYY-MM-DDTHH:MM:SSZ. | [optional] 
 **officeId** | **String** | id фильтруемого оффиса | [optional] 
 **startDate** | **String** | Начальная дата в формате YYYY-MM-DDTHH:MM:SSZ. | [optional] 

### Return type

[**[InvitationStatistics]**](InvitationStatistics.md)

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAdminStatisticQuotasRetrieve**
```swift
    open class func apiAdminStatisticQuotasRetrieve(year: Int? = nil, completion: @escaping (_ data: AnyCodable?, _ error: Error?) -> Void)
```

Получение статистики по месяцам для администратора

Возвращает статистику по транзакциям и приглашениям по месяцам за указанный год. Если год не указан, возвращаются данные за последние 10 месяцев.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let year = 987 // Int | Год, за который необходимо получить статистику. По умолчанию 10 последних месяцев. (optional)

// Получение статистики по месяцам для администратора
ApiAPI.apiAdminStatisticQuotasRetrieve(year: year) { (response, error) in
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
 **year** | **Int** | Год, за который необходимо получить статистику. По умолчанию 10 последних месяцев. | [optional] 

### Return type

**AnyCodable**

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAdminSupervisorsCreate**
```swift
    open class func apiAdminSupervisorsCreate(supervisor: Supervisor, search: String? = nil, completion: @escaping (_ data: [Supervisor]?, _ error: Error?) -> Void)
```

Список супервайзеров

Возвращает список супервайзеров, с возможностью фильтрации по имени, фамилии и отчеству.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let supervisor = Supervisor(id: 123, user: User(username: "username_example", password: "password_example", email: "email_example", firstName: "firstName_example", lastName: "lastName_example", patronymic: "patronymic_example", phone: "phone_example", photo: "photo_example", fullName: "fullName_example"), office: 123, officeName: "officeName_example", department: "department_example") // Supervisor | 
let search = "search_example" // String | Поиск по имени, фамилии или отчество пользователя. (optional)

// Список супервайзеров
ApiAPI.apiAdminSupervisorsCreate(supervisor: supervisor, search: search) { (response, error) in
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
 **supervisor** | [**Supervisor**](Supervisor.md) |  | 
 **search** | **String** | Поиск по имени, фамилии или отчество пользователя. | [optional] 

### Return type

[**[Supervisor]**](Supervisor.md)

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded, multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAdminSupervisorsDestroy**
```swift
    open class func apiAdminSupervisorsDestroy(id: Int, search: String? = nil, completion: @escaping (_ data: [Supervisor]?, _ error: Error?) -> Void)
```

Список супервайзеров

Возвращает список супервайзеров, с возможностью фильтрации по имени, фамилии и отчеству.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Int | A unique integer value identifying this Руководитель.
let search = "search_example" // String | Поиск по имени, фамилии или отчество пользователя. (optional)

// Список супервайзеров
ApiAPI.apiAdminSupervisorsDestroy(id: id, search: search) { (response, error) in
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
 **id** | **Int** | A unique integer value identifying this Руководитель. | 
 **search** | **String** | Поиск по имени, фамилии или отчество пользователя. | [optional] 

### Return type

[**[Supervisor]**](Supervisor.md)

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAdminSupervisorsList**
```swift
    open class func apiAdminSupervisorsList(search: String? = nil, completion: @escaping (_ data: [Supervisor]?, _ error: Error?) -> Void)
```

Список супервайзеров

Возвращает список супервайзеров, с возможностью фильтрации по имени, фамилии и отчеству.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let search = "search_example" // String | Поиск по имени, фамилии или отчество пользователя. (optional)

// Список супервайзеров
ApiAPI.apiAdminSupervisorsList(search: search) { (response, error) in
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
 **search** | **String** | Поиск по имени, фамилии или отчество пользователя. | [optional] 

### Return type

[**[Supervisor]**](Supervisor.md)

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAdminSupervisorsList2**
```swift
    open class func apiAdminSupervisorsList2(id: Int, search: String? = nil, completion: @escaping (_ data: [Supervisor]?, _ error: Error?) -> Void)
```

Список супервайзеров

Возвращает список супервайзеров, с возможностью фильтрации по имени, фамилии и отчеству.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Int | A unique integer value identifying this Руководитель.
let search = "search_example" // String | Поиск по имени, фамилии или отчество пользователя. (optional)

// Список супервайзеров
ApiAPI.apiAdminSupervisorsList2(id: id, search: search) { (response, error) in
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
 **id** | **Int** | A unique integer value identifying this Руководитель. | 
 **search** | **String** | Поиск по имени, фамилии или отчество пользователя. | [optional] 

### Return type

[**[Supervisor]**](Supervisor.md)

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAdminSupervisorsPartialUpdate**
```swift
    open class func apiAdminSupervisorsPartialUpdate(id: Int, search: String? = nil, patchedSupervisor: PatchedSupervisor? = nil, completion: @escaping (_ data: [Supervisor]?, _ error: Error?) -> Void)
```

Список супервайзеров

Возвращает список супервайзеров, с возможностью фильтрации по имени, фамилии и отчеству.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Int | A unique integer value identifying this Руководитель.
let search = "search_example" // String | Поиск по имени, фамилии или отчество пользователя. (optional)
let patchedSupervisor = PatchedSupervisor(id: 123, user: User(username: "username_example", password: "password_example", email: "email_example", firstName: "firstName_example", lastName: "lastName_example", patronymic: "patronymic_example", phone: "phone_example", photo: "photo_example", fullName: "fullName_example"), office: 123, officeName: "officeName_example", department: "department_example") // PatchedSupervisor |  (optional)

// Список супервайзеров
ApiAPI.apiAdminSupervisorsPartialUpdate(id: id, search: search, patchedSupervisor: patchedSupervisor) { (response, error) in
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
 **id** | **Int** | A unique integer value identifying this Руководитель. | 
 **search** | **String** | Поиск по имени, фамилии или отчество пользователя. | [optional] 
 **patchedSupervisor** | [**PatchedSupervisor**](PatchedSupervisor.md) |  | [optional] 

### Return type

[**[Supervisor]**](Supervisor.md)

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded, multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAdminSupervisorsUpdate**
```swift
    open class func apiAdminSupervisorsUpdate(id: Int, supervisor: Supervisor, search: String? = nil, completion: @escaping (_ data: [Supervisor]?, _ error: Error?) -> Void)
```

Список супервайзеров

Возвращает список супервайзеров, с возможностью фильтрации по имени, фамилии и отчеству.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Int | A unique integer value identifying this Руководитель.
let supervisor = Supervisor(id: 123, user: User(username: "username_example", password: "password_example", email: "email_example", firstName: "firstName_example", lastName: "lastName_example", patronymic: "patronymic_example", phone: "phone_example", photo: "photo_example", fullName: "fullName_example"), office: 123, officeName: "officeName_example", department: "department_example") // Supervisor | 
let search = "search_example" // String | Поиск по имени, фамилии или отчество пользователя. (optional)

// Список супервайзеров
ApiAPI.apiAdminSupervisorsUpdate(id: id, supervisor: supervisor, search: search) { (response, error) in
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
 **id** | **Int** | A unique integer value identifying this Руководитель. | 
 **supervisor** | [**Supervisor**](Supervisor.md) |  | 
 **search** | **String** | Поиск по имени, фамилии или отчество пользователя. | [optional] 

### Return type

[**[Supervisor]**](Supervisor.md)

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded, multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiInfoRetrieve**
```swift
    open class func apiInfoRetrieve(completion: @escaping (_ data: AnyCodable?, _ error: Error?) -> Void)
```

Получение полной информации о пользователе

Возвращает информацию о пользователе в зависимости от его роли. Если пользователь администратор, возвращаются данные об администраторе. Если супервайзер, возвращаются данные о супервайзере. Иначе ошибка.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient


// Получение полной информации о пользователе
ApiAPI.apiInfoRetrieve() { (response, error) in
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

**AnyCodable**

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiLinkCreate**
```swift
    open class func apiLinkCreate(link: String, platform: String, completion: @escaping (_ data: AnyCodable?, _ error: Error?) -> Void)
```

Обновление ссылки чата

Метод POST позволяет администраторам обновить ссылку чата для платформы 'telegram' или 'whatsapp'. Ссылка должна быть валидной (начинаться с 'https').

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let link = "link_example" // String | Ссылка на чат, должна начинаться с 'https'
let platform = "platform_example" // String | Платформа чата, доступные значения: 'telegram', 'whatsapp'

// Обновление ссылки чата
ApiAPI.apiLinkCreate(link: link, platform: platform) { (response, error) in
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
 **link** | **String** | Ссылка на чат, должна начинаться с &#39;https&#39; | 
 **platform** | **String** | Платформа чата, доступные значения: &#39;telegram&#39;, &#39;whatsapp&#39; | 

### Return type

**AnyCodable**

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiLinkRetrieve**
```swift
    open class func apiLinkRetrieve(completion: @escaping (_ data: AnyCodable?, _ error: Error?) -> Void)
```

Получение ссылки чата

Метод GET позволяет получить текущую ссылку чата на чат с администратором

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient


// Получение ссылки чата
ApiAPI.apiLinkRetrieve() { (response, error) in
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

**AnyCodable**

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiLoginCreate**
```swift
    open class func apiLoginCreate(body: AnyCodable? = nil, completion: @escaping (_ data: AnyCodable?, _ error: Error?) -> Void)
```

Авторизация пользователя

Позволяет пользователю авторизоваться, предоставив имя пользователя и пароль. Возвращает токен доступа, если учетные данные верны.полученный токен нужно передавать в headers в поле Authorization в формате Token <token>

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let body = 987 // AnyCodable |  (optional)

// Авторизация пользователя
ApiAPI.apiLoginCreate(body: body) { (response, error) in
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
 **body** | **AnyCodable** |  | [optional] 

### Return type

**AnyCodable**

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiLogoutCreate**
```swift
    open class func apiLogoutCreate(completion: @escaping (_ data: AnyCodable?, _ error: Error?) -> Void)
```

Выход из системы

Удаляет токен текущего пользователя, завершая его сессию.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient


// Выход из системы
ApiAPI.apiLogoutCreate() { (response, error) in
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

**AnyCodable**

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSupervisorCandidatesList**
```swift
    open class func apiSupervisorCandidatesList(age: Int? = nil, ageMax: Int? = nil, ageMin: Int? = nil, byNew: String? = nil, courses: String? = nil, completion: @escaping (_ data: [CandidateInfo]?, _ error: Error?) -> Void)
```

Получение информации о кандидатах

Возвращает список доступных кандидатов с фильтрацией по возрасту, курсам и дате создания.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let age = 987 // Int | Фильтрация по точному возрасту кандидата. (optional)
let ageMax = 987 // Int | Максимальный возраст для фильтрации кандидатов. (optional)
let ageMin = 987 // Int | Минимальный возраст для фильтрации кандидатов. (optional)
let byNew = "byNew_example" // String | Сортировка по дате создания. Значения: true (по убыванию), false (по возрастанию). (optional)
let courses = "courses_example" // String | Фильтрация по пройденным курсам. Укажите через запятую. Возможные значения: `course_rieltor_join` (курс риэлторов), `basic_legal_course` (базовый юридический курс), `course_mortgage` (курс ипотечного кредитования), `course_taxation` (курс по налогообложению). (optional)

// Получение информации о кандидатах
ApiAPI.apiSupervisorCandidatesList(age: age, ageMax: ageMax, ageMin: ageMin, byNew: byNew, courses: courses) { (response, error) in
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
 **age** | **Int** | Фильтрация по точному возрасту кандидата. | [optional] 
 **ageMax** | **Int** | Максимальный возраст для фильтрации кандидатов. | [optional] 
 **ageMin** | **Int** | Минимальный возраст для фильтрации кандидатов. | [optional] 
 **byNew** | **String** | Сортировка по дате создания. Значения: true (по убыванию), false (по возрастанию). | [optional] 
 **courses** | **String** | Фильтрация по пройденным курсам. Укажите через запятую. Возможные значения: &#x60;course_rieltor_join&#x60; (курс риэлторов), &#x60;basic_legal_course&#x60; (базовый юридический курс), &#x60;course_mortgage&#x60; (курс ипотечного кредитования), &#x60;course_taxation&#x60; (курс по налогообложению). | [optional] 

### Return type

[**[CandidateInfo]**](CandidateInfo.md)

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSupervisorFavoritesCreate**
```swift
    open class func apiSupervisorFavoritesCreate(favorite: Favorite, completion: @escaping (_ data: Favorite?, _ error: Error?) -> Void)
```

Добавить в избранное

Добавляет новый объект в избранное для текущего пользователя.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let favorite = Favorite(id: 123, candidate: 123, candidateInfo: CandidateInfo(id: 123, name: "name_example", surname: "surname_example", patronymic: "patronymic_example", birth: Date(), age: 123, education: "education_example", photo: "photo_example", country: "country_example", city: "city_example", resume: "resume_example", courses: [Course(id: 123, name: "name_example")], updatedAt: Date(), isFavorite: false, favoriteId: 123, isInvited: false, achivmentObjects: 123, achivmentClients: 123, achivmentLeads: 123, achivmentExclusives: 123, achivmentDeals: 123), createdAt: Date()) // Favorite | 

// Добавить в избранное
ApiAPI.apiSupervisorFavoritesCreate(favorite: favorite) { (response, error) in
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
 **favorite** | [**Favorite**](Favorite.md) |  | 

### Return type

[**Favorite**](Favorite.md)

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded, multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSupervisorFavoritesDestroy**
```swift
    open class func apiSupervisorFavoritesDestroy(id: String, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Удалить из избранного

Удаляет объект из избранного пользователя.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = "id_example" // String | 

// Удалить из избранного
ApiAPI.apiSupervisorFavoritesDestroy(id: id) { (response, error) in
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
 **id** | **String** |  | 

### Return type

Void (empty response body)

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSupervisorFavoritesList**
```swift
    open class func apiSupervisorFavoritesList(completion: @escaping (_ data: [Favorite]?, _ error: Error?) -> Void)
```

Получить список избранного

Возвращает список избранных объектов пользователя.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient


// Получить список избранного
ApiAPI.apiSupervisorFavoritesList() { (response, error) in
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

[**[Favorite]**](Favorite.md)

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSupervisorFavoritesPartialUpdate**
```swift
    open class func apiSupervisorFavoritesPartialUpdate(id: String, patchedFavorite: PatchedFavorite? = nil, completion: @escaping (_ data: Favorite?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = "id_example" // String | 
let patchedFavorite = PatchedFavorite(id: 123, candidate: 123, candidateInfo: CandidateInfo(id: 123, name: "name_example", surname: "surname_example", patronymic: "patronymic_example", birth: Date(), age: 123, education: "education_example", photo: "photo_example", country: "country_example", city: "city_example", resume: "resume_example", courses: [Course(id: 123, name: "name_example")], updatedAt: Date(), isFavorite: false, favoriteId: 123, isInvited: false, achivmentObjects: 123, achivmentClients: 123, achivmentLeads: 123, achivmentExclusives: 123, achivmentDeals: 123), createdAt: Date()) // PatchedFavorite |  (optional)

ApiAPI.apiSupervisorFavoritesPartialUpdate(id: id, patchedFavorite: patchedFavorite) { (response, error) in
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
 **id** | **String** |  | 
 **patchedFavorite** | [**PatchedFavorite**](PatchedFavorite.md) |  | [optional] 

### Return type

[**Favorite**](Favorite.md)

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded, multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSupervisorFavoritesRetrieve**
```swift
    open class func apiSupervisorFavoritesRetrieve(id: String, completion: @escaping (_ data: Favorite?, _ error: Error?) -> Void)
```

Получить избранный объект

Возвращает подробную информацию об объекте в избранном.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = "id_example" // String | 

// Получить избранный объект
ApiAPI.apiSupervisorFavoritesRetrieve(id: id) { (response, error) in
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
 **id** | **String** |  | 

### Return type

[**Favorite**](Favorite.md)

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSupervisorFavoritesUpdate**
```swift
    open class func apiSupervisorFavoritesUpdate(id: String, favorite: Favorite, completion: @escaping (_ data: Favorite?, _ error: Error?) -> Void)
```

Обновить избранный объект

Обновляет данные избранного объекта.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = "id_example" // String | 
let favorite = Favorite(id: 123, candidate: 123, candidateInfo: CandidateInfo(id: 123, name: "name_example", surname: "surname_example", patronymic: "patronymic_example", birth: Date(), age: 123, education: "education_example", photo: "photo_example", country: "country_example", city: "city_example", resume: "resume_example", courses: [Course(id: 123, name: "name_example")], updatedAt: Date(), isFavorite: false, favoriteId: 123, isInvited: false, achivmentObjects: 123, achivmentClients: 123, achivmentLeads: 123, achivmentExclusives: 123, achivmentDeals: 123), createdAt: Date()) // Favorite | 

// Обновить избранный объект
ApiAPI.apiSupervisorFavoritesUpdate(id: id, favorite: favorite) { (response, error) in
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
 **id** | **String** |  | 
 **favorite** | [**Favorite**](Favorite.md) |  | 

### Return type

[**Favorite**](Favorite.md)

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded, multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSupervisorInvitationsCreate**
```swift
    open class func apiSupervisorInvitationsCreate(invitation: Invitation, completion: @escaping (_ data: Invitation?, _ error: Error?) -> Void)
```

Создать новое приглашение

Создает новое приглашение для кандидата, проверяя наличие квоты у офиса.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let invitation = Invitation(candidate: 123, name: "name_example", surname: "surname_example", patronymic: "patronymic_example", city: "city_example", age: 123, photo: "photo_example", status: "status_example", updatedAt: "updatedAt_example") // Invitation | 

// Создать новое приглашение
ApiAPI.apiSupervisorInvitationsCreate(invitation: invitation) { (response, error) in
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
 **invitation** | [**Invitation**](Invitation.md) |  | 

### Return type

[**Invitation**](Invitation.md)

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded, multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSupervisorInvitationsRetrieve**
```swift
    open class func apiSupervisorInvitationsRetrieve(endDate: String? = nil, startDate: String? = nil, status: String? = nil, completion: @escaping (_ data: [Invitation]?, _ error: Error?) -> Void)
```

Получение списка приглашённых кандидатов

Возвращает список приглашённых рук-лем кандидатов, с поддержкой фильтрации и отправкой новых приглашений

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let endDate = "endDate_example" // String | Фильтр по дате: конец диапазона (формат 'YYYY-MM-DD'). (optional)
let startDate = "startDate_example" // String | Фильтр по дате: начало диапазона (формат 'YYYY-MM-DD'). (optional)
let status = "status_example" // String | Фильтр по статусу приглашений (invited, accepted, rejected, self_rejected). (optional)

// Получение списка приглашённых кандидатов
ApiAPI.apiSupervisorInvitationsRetrieve(endDate: endDate, startDate: startDate, status: status) { (response, error) in
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
 **endDate** | **String** | Фильтр по дате: конец диапазона (формат &#39;YYYY-MM-DD&#39;). | [optional] 
 **startDate** | **String** | Фильтр по дате: начало диапазона (формат &#39;YYYY-MM-DD&#39;). | [optional] 
 **status** | **String** | Фильтр по статусу приглашений (invited, accepted, rejected, self_rejected). | [optional] 

### Return type

[**[Invitation]**](Invitation.md)

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSupervisorStatisticQuotasList**
```swift
    open class func apiSupervisorStatisticQuotasList(year: Int? = nil, completion: @escaping (_ data: [MonthlyStatistic]?, _ error: Error?) -> Void)
```

Статистика по месяцам

Возвращает статистику по месяцам за указанный год или последние 10 месяцев по умолчанию. Для фильтрации можно передать параметр `year` (например, ?year=2024).

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let year = 987 // Int | Год для фильтрации статистики (например, 2024). (optional)

// Статистика по месяцам
ApiAPI.apiSupervisorStatisticQuotasList(year: year) { (response, error) in
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
 **year** | **Int** | Год для фильтрации статистики (например, 2024). | [optional] 

### Return type

[**[MonthlyStatistic]**](MonthlyStatistic.md)

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiTodoStatsRetrieve**
```swift
    open class func apiTodoStatsRetrieve(endDate: Date? = nil, startDate: Date? = nil, completion: @escaping (_ data: [String: AnyCodable]?, _ error: Error?) -> Void)
```

Получить статистику TODO

Возвращает статистику задач пользователя: общее количество созданных, завершённых, удалённых задач, а также дни недели с максимальной активностью.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let endDate = Date() // Date | Фильтр задач по конечной дате создания (формат 'YYYY-MM-DD'). (optional)
let startDate = Date() // Date | Фильтр задач по начальной дате создания (формат 'YYYY-MM-DD'). (optional)

// Получить статистику TODO
ApiAPI.apiTodoStatsRetrieve(endDate: endDate, startDate: startDate) { (response, error) in
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
 **endDate** | **Date** | Фильтр задач по конечной дате создания (формат &#39;YYYY-MM-DD&#39;). | [optional] 
 **startDate** | **Date** | Фильтр задач по начальной дате создания (формат &#39;YYYY-MM-DD&#39;). | [optional] 

### Return type

**[String: AnyCodable]**

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiTodosCreate**
```swift
    open class func apiTodosCreate(todo: Todo, dueDate: String? = nil, completion: @escaping (_ data: [Todo]?, _ error: Error?) -> Void)
```

Получение списка задач

Возвращает список задач текущего пользователя. Поддерживается фильтрация по `status` и `due_date`.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let todo = Todo(id: 123, user: "user_example", task: "task_example", dueDate: Date(), isComplete: false, isDeleted: false, createdAt: Date()) // Todo | 
let dueDate = "dueDate_example" // String | Фильтр задач по дате выполнения (в формате 'YYYY-MM-DD') (optional)

// Получение списка задач
ApiAPI.apiTodosCreate(todo: todo, dueDate: dueDate) { (response, error) in
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
 **todo** | [**Todo**](Todo.md) |  | 
 **dueDate** | **String** | Фильтр задач по дате выполнения (в формате &#39;YYYY-MM-DD&#39;) | [optional] 

### Return type

[**[Todo]**](Todo.md)

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded, multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiTodosDestroy**
```swift
    open class func apiTodosDestroy(id: Int, dueDate: String? = nil, completion: @escaping (_ data: [Todo]?, _ error: Error?) -> Void)
```

Получение списка задач

Возвращает список задач текущего пользователя. Поддерживается фильтрация по `status` и `due_date`.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Int | A unique integer value identifying this Задача.
let dueDate = "dueDate_example" // String | Фильтр задач по дате выполнения (в формате 'YYYY-MM-DD') (optional)

// Получение списка задач
ApiAPI.apiTodosDestroy(id: id, dueDate: dueDate) { (response, error) in
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
 **id** | **Int** | A unique integer value identifying this Задача. | 
 **dueDate** | **String** | Фильтр задач по дате выполнения (в формате &#39;YYYY-MM-DD&#39;) | [optional] 

### Return type

[**[Todo]**](Todo.md)

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiTodosList**
```swift
    open class func apiTodosList(dueDate: String? = nil, completion: @escaping (_ data: [Todo]?, _ error: Error?) -> Void)
```

Получение списка задач

Возвращает список задач текущего пользователя. Поддерживается фильтрация по `status` и `due_date`.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let dueDate = "dueDate_example" // String | Фильтр задач по дате выполнения (в формате 'YYYY-MM-DD') (optional)

// Получение списка задач
ApiAPI.apiTodosList(dueDate: dueDate) { (response, error) in
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
 **dueDate** | **String** | Фильтр задач по дате выполнения (в формате &#39;YYYY-MM-DD&#39;) | [optional] 

### Return type

[**[Todo]**](Todo.md)

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiTodosPartialUpdate**
```swift
    open class func apiTodosPartialUpdate(id: Int, dueDate: String? = nil, patchedTodo: PatchedTodo? = nil, completion: @escaping (_ data: [Todo]?, _ error: Error?) -> Void)
```

Получение списка задач

Возвращает список задач текущего пользователя. Поддерживается фильтрация по `status` и `due_date`.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Int | A unique integer value identifying this Задача.
let dueDate = "dueDate_example" // String | Фильтр задач по дате выполнения (в формате 'YYYY-MM-DD') (optional)
let patchedTodo = PatchedTodo(id: 123, user: "user_example", task: "task_example", dueDate: Date(), isComplete: false, isDeleted: false, createdAt: Date()) // PatchedTodo |  (optional)

// Получение списка задач
ApiAPI.apiTodosPartialUpdate(id: id, dueDate: dueDate, patchedTodo: patchedTodo) { (response, error) in
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
 **id** | **Int** | A unique integer value identifying this Задача. | 
 **dueDate** | **String** | Фильтр задач по дате выполнения (в формате &#39;YYYY-MM-DD&#39;) | [optional] 
 **patchedTodo** | [**PatchedTodo**](PatchedTodo.md) |  | [optional] 

### Return type

[**[Todo]**](Todo.md)

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded, multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiTodosRetrieve**
```swift
    open class func apiTodosRetrieve(id: Int, dueDate: String? = nil, completion: @escaping (_ data: [Todo]?, _ error: Error?) -> Void)
```

Получение списка задач

Возвращает список задач текущего пользователя. Поддерживается фильтрация по `status` и `due_date`.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Int | A unique integer value identifying this Задача.
let dueDate = "dueDate_example" // String | Фильтр задач по дате выполнения (в формате 'YYYY-MM-DD') (optional)

// Получение списка задач
ApiAPI.apiTodosRetrieve(id: id, dueDate: dueDate) { (response, error) in
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
 **id** | **Int** | A unique integer value identifying this Задача. | 
 **dueDate** | **String** | Фильтр задач по дате выполнения (в формате &#39;YYYY-MM-DD&#39;) | [optional] 

### Return type

[**[Todo]**](Todo.md)

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiTodosUpdate**
```swift
    open class func apiTodosUpdate(id: Int, todo: Todo, dueDate: String? = nil, completion: @escaping (_ data: [Todo]?, _ error: Error?) -> Void)
```

Получение списка задач

Возвращает список задач текущего пользователя. Поддерживается фильтрация по `status` и `due_date`.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Int | A unique integer value identifying this Задача.
let todo = Todo(id: 123, user: "user_example", task: "task_example", dueDate: Date(), isComplete: false, isDeleted: false, createdAt: Date()) // Todo | 
let dueDate = "dueDate_example" // String | Фильтр задач по дате выполнения (в формате 'YYYY-MM-DD') (optional)

// Получение списка задач
ApiAPI.apiTodosUpdate(id: id, todo: todo, dueDate: dueDate) { (response, error) in
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
 **id** | **Int** | A unique integer value identifying this Задача. | 
 **todo** | [**Todo**](Todo.md) |  | 
 **dueDate** | **String** | Фильтр задач по дате выполнения (в формате &#39;YYYY-MM-DD&#39;) | [optional] 

### Return type

[**[Todo]**](Todo.md)

### Authorization

[tokenAuth](../README.md#tokenAuth)

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded, multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

