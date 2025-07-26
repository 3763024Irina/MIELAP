import XCTest
import AnyCodable
import OpenAPIClient
@testable import MIELAPP

final class APIServiceTests: XCTestCase {
    
    override func setUpWithError() throws {
        OpenAPIClientAPI.basePath = "https://miel.sayrrx.cfd"
        OpenAPIClientAPI.customHeaders.removeAll()
        UserDefaults.standard.removeObject(forKey: "authToken")
    }
   //Успешность входа в систему через эндпоинт /api/login/. Убедиться, что сервер возвращает ответ на логин без ошибок.
    func testLogin() {
        let exp = expectation(description: "login")
        let body: [String: String] = ["username": "supervisor", "password": "supervisor"]
        let anyBody = AnyCodable(body)
        
        ApiAPI.apiLoginCreate(body: anyBody) { data, error in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
    }
    //Что API не отдаёт приватные данные без авторизационного токена.Сервер правильно защищает эндпоинт от неавторизованных запросов.
    func testInfoWithoutToken() {
        let exp = expectation(description: "Info without token")
        ApiAPI.apiInfoRetrieve { data, error in
            XCTAssertNotNil(error, "Ожидали ошибку 401, но error == nil")
            XCTAssertNil(data, "Данные не должны прийти без токена")
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5.0)
    }
    
    func testLoginAndSaveToken() {
        let exp = expectation(description: "Login and save token")
        let body: [String: String] = ["username": "supervisor", "password": "supervisor"]
        let anyBody = AnyCodable(body)
        
        ApiAPI.apiLoginCreate(body: anyBody) { data, error in
            XCTAssertNil(error, "Ошибка входа: \(String(describing: error))")
            XCTAssertNotNil(data, "Ответ на логин пустой")
            
            if let value = data?.value,
               let dict = value as? [String: Any],
               let token = dict["token"] as? String {
                UserDefaults.standard.set(token, forKey: "authToken")
                OpenAPIClientAPI.customHeaders["Authorization"] = "Token \(token)"
                XCTAssertFalse(token.isEmpty, "Токен пустой")
            } else {
                XCTFail("Нет токена в ответе или неправильный формат")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5.0)
    }
    
    func testGetCandidates() {
        let loginExpectation = expectation(description: "Login first")
        let getCandidatesExpectation = expectation(description: "Get candidates")
        
        let body: [String: String] = ["username": "supervisor", "password": "supervisor"]
        let anyBody = AnyCodable(body)
        
        ApiAPI.apiLoginCreate(body: anyBody) { data, error in
            XCTAssertNil(error)
            guard
                let value = data?.value as? [String: Any],
                let token = value["token"] as? String
            else {
                XCTFail("Нет токена")
                loginExpectation.fulfill()
                getCandidatesExpectation.fulfill()
                return
            }
            
            UserDefaults.standard.set(token, forKey: "authToken")
            OpenAPIClientAPI.customHeaders["Authorization"] = "Token \(token)"
            loginExpectation.fulfill()
            
            let url = URL(string: "\(OpenAPIClientAPI.basePath)/api/supervisor/candidates/")!
            var request = URLRequest(url: url)
            request.addValue("Token \(token)", forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                XCTAssertNil(error)
                XCTAssertNotNil(data)
                guard let data = data else {
                    XCTFail("Нет данных")
                    getCandidatesExpectation.fulfill()
                    return
                }
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .custom { decoder -> Date in
                    let container = try decoder.singleValueContainer()
                    let dateString = try container.decode(String.self).trimmingCharacters(in: .whitespacesAndNewlines)
                    if dateString.isEmpty { return Date(timeIntervalSince1970: 0) }
                    let formats = [
                        "dd.MM.yyyy",
                        "yyyy-MM-dd",
                        "yyyy-MM-dd'T'HH:mm:ss.SSSSSS", // с микросекундами
                        "yyyy-MM-dd'T'HH:mm:ss.SSSZ",
                        "yyyy-MM-dd'T'HH:mm:ssZ"
                    ]
                    let df = DateFormatter()
                    df.locale = Locale(identifier: "en_US_POSIX")
                    df.timeZone = TimeZone(secondsFromGMT: 0)
                    for fmt in formats {
                        df.dateFormat = fmt
                        if let date = df.date(from: dateString) { return date }
                    }
                    throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date: \(dateString)")
                }
                
                do {
                    struct SafeCandidateInfo: Decodable {
                        let id: Int
                        let favorite_id: Int?
                        let name: String?
                        let birth: Date?
                        let updated_at: Date?
                    }
                    let candidates = try decoder.decode([SafeCandidateInfo].self, from: data)
                    XCTAssertFalse(candidates.isEmpty, "Список пуст")
                } catch {
                    XCTFail("Ошибка ручного декодирования: \(error)")
                }
                getCandidatesExpectation.fulfill()
            }.resume()
        }
        wait(for: [loginExpectation, getCandidatesExpectation], timeout: 10.0)
    }
    
}
