//
// InvitationStatistics.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct InvitationStatistics: Codable, JSONEncodable, Hashable {

    public var fullName: String
    public var photo: String
    public var age: Int
    public var city: String
    public var status: Status0d0Enum?
    public var updatedAt: Date

    public init(fullName: String, photo: String, age: Int, city: String, status: Status0d0Enum? = nil, updatedAt: Date) {
        self.fullName = fullName
        self.photo = photo
        self.age = age
        self.city = city
        self.status = status
        self.updatedAt = updatedAt
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case fullName = "full_name"
        case photo
        case age
        case city
        case status
        case updatedAt = "updated_at"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(fullName, forKey: .fullName)
        try container.encode(photo, forKey: .photo)
        try container.encode(age, forKey: .age)
        try container.encode(city, forKey: .city)
        try container.encodeIfPresent(status, forKey: .status)
        try container.encode(updatedAt, forKey: .updatedAt)
    }
}

