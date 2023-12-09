//
//  DeskModel.swift
//  DigitalFlakeAssignment
//
//  Created by mahesh gaykar on 09/12/23.
//

import Foundation

// MARK: - SlotsModel
struct SlotsModel: Codable {
    let slots: [Slot]?
    
    enum CodingKeys: CodingKey {
        case slots
    }
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<SlotsModel.CodingKeys> = try decoder.container(keyedBy: SlotsModel.CodingKeys.self)
        
        self.slots = try container.decodeIfPresent([Slot].self, forKey: SlotsModel.CodingKeys.slots)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<SlotsModel.CodingKeys> = encoder.container(keyedBy: SlotsModel.CodingKeys.self)
        
        try container.encodeIfPresent(self.slots, forKey: SlotsModel.CodingKeys.slots)
    }
}

// MARK: - Slot
struct Slot: Codable {
    let slotName: String?
    let slotID: Int?
    let slotActive: Bool?

    enum CodingKeys: String, CodingKey {
        case slotName = "slot_name"
        case slotID = "slot_id"
        case slotActive = "slot_active"
    }

    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Slot.CodingKeys> = try decoder.container(keyedBy: Slot.CodingKeys.self)
        
        self.slotName = try container.decodeIfPresent(String.self, forKey: Slot.CodingKeys.slotName)
        self.slotID = try container.decodeIfPresent(Int.self, forKey: Slot.CodingKeys.slotID)
        self.slotActive = try container.decodeIfPresent(Bool.self, forKey: Slot.CodingKeys.slotActive)
    }
    
    func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Slot.CodingKeys> = encoder.container(keyedBy: Slot.CodingKeys.self)
        
        try container.encodeIfPresent(self.slotName, forKey: Slot.CodingKeys.slotName)
        try container.encodeIfPresent(self.slotID, forKey: Slot.CodingKeys.slotID)
        try container.encodeIfPresent(self.slotActive, forKey: Slot.CodingKeys.slotActive)
    }
}
