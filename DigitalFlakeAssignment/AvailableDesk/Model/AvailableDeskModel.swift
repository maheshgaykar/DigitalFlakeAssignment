//
//  AvailableDeskModel.swift
//  DigitalFlakeAssignment
//
//  Created by mahesh gaykar on 09/12/23.
//

import Foundation

// MARK: - AvailabilityModel
struct AvailabilityModel: Codable {
    let availability: [Availability]?
    
    enum CodingKeys: CodingKey {
        case availability
    }
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<AvailabilityModel.CodingKeys> = try decoder.container(keyedBy: AvailabilityModel.CodingKeys.self)
        
        self.availability = try container.decodeIfPresent([Availability].self, forKey: AvailabilityModel.CodingKeys.availability)
    }
    
    func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<AvailabilityModel.CodingKeys> = encoder.container(keyedBy: AvailabilityModel.CodingKeys.self)
        
        try container.encodeIfPresent(self.availability, forKey: AvailabilityModel.CodingKeys.availability)
    }
}

// MARK: - Availability
struct Availability: Codable {
    let workspaceName: String?
    let workspaceID: Int?
    let workspaceActive: Bool?

    enum CodingKeys: String, CodingKey {
        case workspaceName = "workspace_name"
        case workspaceID = "workspace_id"
        case workspaceActive = "workspace_active"
    }
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Availability.CodingKeys> = try decoder.container(keyedBy: Availability.CodingKeys.self)
        
        self.workspaceName = try container.decodeIfPresent(String.self, forKey: Availability.CodingKeys.workspaceName)
        self.workspaceID = try container.decodeIfPresent(Int.self, forKey: Availability.CodingKeys.workspaceID)
        self.workspaceActive = try container.decodeIfPresent(Bool.self, forKey: Availability.CodingKeys.workspaceActive)
    }
    
    func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Availability.CodingKeys> = encoder.container(keyedBy: Availability.CodingKeys.self)
        
        try container.encodeIfPresent(self.workspaceName, forKey: Availability.CodingKeys.workspaceName)
        try container.encodeIfPresent(self.workspaceID, forKey: Availability.CodingKeys.workspaceID)
        try container.encodeIfPresent(self.workspaceActive, forKey: Availability.CodingKeys.workspaceActive)
    }
}


