//
// AdminInvitation.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct AdminInvitation: Codable, JSONEncodable, Hashable {

    public var id: Int
    public var status: Status0d0Enum?
    public var createdAt: Date
    public var officeName: String
    public var supervisor: String
    public var office: Int

    public init(id: Int, status: Status0d0Enum? = nil, createdAt: Date, officeName: String, supervisor: String, office: Int) {
        self.id = id
        self.status = status
        self.createdAt = createdAt
        self.officeName = officeName
        self.supervisor = supervisor
        self.office = office
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case status
        case createdAt = "created_at"
        case officeName = "office_name"
        case supervisor
        case office
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encodeIfPresent(status, forKey: .status)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(officeName, forKey: .officeName)
        try container.encode(supervisor, forKey: .supervisor)
        try container.encode(office, forKey: .office)
    }
}


@available(iOS 13, tvOS 13, watchOS 6, macOS 10.15, *)
extension AdminInvitation: Identifiable {}
