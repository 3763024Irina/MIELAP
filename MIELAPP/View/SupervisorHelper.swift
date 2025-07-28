import UIKit
import OpenAPIClient
import AnyCodable

struct SupervisorHelper {
    struct Info {
        let fullName: String
        let officeName: String
        let photoURL: URL?
        let quotas: Int
        let invitations: Int
        let date: String
    }

    static func fetch(headerView: SupervisorHeaderView, completion: ((Info?) -> Void)? = nil) {
        ApiAPI.apiInfoRetrieve { info, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    print("SupervisorHelper API error:", error?.localizedDescription ?? "unknown")
                    headerView.configure(
                        fullName: "Супервайзер",
                        date: DateFormatter.localizedString(from: Date(), dateStyle: .long, timeStyle: .none),
                        photoURL: nil,
                        office: "",
                        quotas: 0,
                        invitations: 0
                    )
                    completion?(nil)
                    return
                }
                
                print("SupervisorHelper API info?.value:", info?.value ?? "nil")

                // Универсальный формат: массив или словарь
                var dict: [String: Any]? = nil
                if let array = info?.value as? [[String: Any]], let first = array.first {
                    dict = first
                } else if let map = info?.value as? [String: Any] {
                    dict = map
                }
                
                guard let dict = dict else {
                    headerView.configure(
                        fullName: "Супервайзер",
                        date: DateFormatter.localizedString(from: Date(), dateStyle: .long, timeStyle: .none),
                        photoURL: nil,
                        office: "",
                        quotas: 0,
                        invitations: 0
                    )
                    completion?(nil)
                    return
                }
                
                let fullName = dict["full_name"] as? String ?? "Супервайзер"
                let officeName = dict["office_name"] as? String ?? ""
                let photoURL = (dict["photo"] as? String).flatMap { URL(string: $0) }
                let quotas = Int(dict["office_quota"] as? String ?? "\(dict["office_quota"] ?? 0)") ?? 0
                let invitations = Int(dict["office_used_quota"] as? String ?? "\(dict["office_used_quota"] ?? 0)") ?? 0
                let date = DateFormatter.localizedString(from: Date(), dateStyle: .long, timeStyle: .none)

                headerView.configure(
                    fullName: fullName,
                    date: date,
                    photoURL: photoURL,
                    office: officeName,
                    quotas: quotas,
                    invitations: invitations
                )

                completion?(Info(
                    fullName: fullName,
                    officeName: officeName,
                    photoURL: photoURL,
                    quotas: quotas,
                    invitations: invitations,
                    date: date
                ))
            }
        }
    }
}
