//
// Favorite.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct Favorite: Codable, JSONEncodable, Hashable {

    public var id: Int
    public var candidate: Int
    public var candidateInfo: CandidateInfo
    public var createdAt: Date

    public init(id: Int, candidate: Int, candidateInfo: CandidateInfo, createdAt: Date) {
        self.id = id
        self.candidate = candidate
        self.candidateInfo = candidateInfo
        self.createdAt = createdAt
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case candidate
        case candidateInfo = "candidate_info"
        case createdAt = "created_at"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(candidate, forKey: .candidate)
        try container.encode(candidateInfo, forKey: .candidateInfo)
        try container.encode(createdAt, forKey: .createdAt)
    }
}


@available(iOS 13, tvOS 13, watchOS 6, macOS 10.15, *)
extension Favorite: Identifiable {}
