import XCTest
import OpenAPIClient

final class APIServiceTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Установи basePath и токен авторизации для тестов
        OpenAPIClientAPI.basePath = "https://miel.sayrrx.cfd"
        OpenAPIClientAPI.customHeaders["Authorization"] = "Token 7d2898dbe35b33670224c24ed43ff73b676bc6cc"
    }
    
    // 1. Получить список кандидатов
    func testGetCandidates() {
        let expectation = XCTestExpectation(description: "Загрузка кандидатов")

        ApiAPI.apiSupervisorCandidatesList { candidates, error in
            XCTAssertNil(error, "Ошибка при загрузке кандидатов: \(error?.localizedDescription ?? "")")
            XCTAssertNotNil(candidates, "Нет ответа от сервера")
            if let candidates = candidates {
                print("Всего кандидатов: \(candidates.count)")
                for candidate in candidates {
                    print("ID: \(candidate.id), ФИО: \(candidate.name) \(candidate.surname)")
                }
                XCTAssertTrue(candidates.count > 0, "Список кандидатов пуст!")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10)
    }


    
    // 2. Получить ссылку на чат
    func testGetChatLink() {
        let expectation = XCTestExpectation(description: "Получение ссылки на чат")
        ApiAPI.apiLinkRetrieve { response, error in
            XCTAssertNil(error, "Ошибка при получении ссылки: \(error?.localizedDescription ?? "")")
            // Проверь, что ссылка присутствует
            if let value = response?.value as? String {
                XCTAssertTrue(value.starts(with: "http"), "Ссылка не начинается с http")
            } else if let dict = response?.value as? [String: Any], let link = dict["link"] as? String {
                XCTAssertTrue(link.starts(with: "http"), "Ссылка не начинается с http")
            } else {
                XCTFail("Нет валидной ссылки в ответе")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    // 3. Отправить приглашение кандидату
    func testSendInvitation() {
        let expectation = XCTestExpectation(description: "Отправка приглашения")
        
        let candidateId = 1 // <-- ВСТАВЬ СЮДА НАСТОЯЩИЙ id кандидата из теста выше!

        let invitation = Invitation(
            id: 0, // если не нужен, не отправлять!
            candidate: 123, // реальный id кандидата
            name: "Иван",
            surname: "Иванов",
            patronymic: "Иванович",
            city: "Москва",
            age: 25,
            photo: "https://...",
            status: "pending", // или null, если не нужен
            updatedAt: "" // возможно, вообще не нужен
        )

        
        ApiAPI.apiSupervisorInvitationsCreate(invitation: invitation) { result, error in
            XCTAssertNil(error, "Ошибка при создании приглашения: \(error?.localizedDescription ?? "")")
            XCTAssertNotNil(result, "Ответ не получен")
            XCTAssertEqual(result?.candidate, invitation.candidate, "ID кандидата не совпадает")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
}
