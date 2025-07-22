import Foundation
import OpenAPIClient
import AnyCodable
    extension ApiAPI {
    static func apiGetLink(completion: @escaping (String?, Error?) -> Void) {
            ApiAPI.apiLinkRetrieve { data, error in
                if let error = error {
                    completion(nil, error)
                    return
                }
                if let dict = data?.value as? [String: Any], let link = dict["link"] as? String {
                    completion(link, nil)
                } else {
                    completion(nil, NSError(domain: "NoLink", code: 0, userInfo: [NSLocalizedDescriptionKey: "Ссылка не найдена"]))
                }
            }
        }
    }

