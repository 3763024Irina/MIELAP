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
                print("SupervisorHelper API info?.value:", info?.value ?? "nil")
                print("SupervisorHelper API error:", error?.localizedDescription ?? "nil")

                // Универсально: и массив, и словарь
                var dict: [String: Any]? = nil

                if let arr = info?.value as? [[String: Any]], let first = arr.first {
                    dict = first
                } else if let d = info?.value as? [String: Any] {
                    dict = d
                }

                guard let dict = dict, error == nil else {
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
                let quotas: Int = {
                    if let q = dict["office_quota"] as? Int { return q }
                    if let q = dict["office_quota"] as? String, let n = Int(q) { return n }
                    return 0
                }()
                let invitations: Int = {
                    if let i = dict["office_used_quota"] as? Int { return i }
                    if let i = dict["office_used_quota"] as? String, let n = Int(i) { return n }
                    return 0
                }()
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
