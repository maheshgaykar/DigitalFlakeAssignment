//
//  ConfirmationModel.swift
//  DigitalFlakeAssignment
//
//  Created by mahesh gaykar on 09/12/23.
//

import Foundation

class ConfirmBookingModel: Codable{
    var message : String?
    
    enum CodingKeys: CodingKey {
        case message
    }
    
    required init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<ConfirmBookingModel.CodingKeys> = try decoder.container(keyedBy: ConfirmBookingModel.CodingKeys.self)
        
        self.message = try container.decodeIfPresent(String.self, forKey: ConfirmBookingModel.CodingKeys.message)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<ConfirmBookingModel.CodingKeys> = encoder.container(keyedBy: ConfirmBookingModel.CodingKeys.self)
        
        try container.encodeIfPresent(self.message, forKey: ConfirmBookingModel.CodingKeys.message)
    }
}
