//
//  LogInModel.swift
//  DigitalFlakeAssignment
//
//  Created by mahesh gaykar on 09/12/23.
//

import Foundation

class LogInModel: Codable{
    var user_id : Int?
    var message : String?
    
    enum CodingKeys: CodingKey {
        case user_id
        case message
    }
    
    required init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<LogInModel.CodingKeys> = try decoder.container(keyedBy: LogInModel.CodingKeys.self)
        
        self.user_id = try container.decodeIfPresent(Int.self, forKey: LogInModel.CodingKeys.user_id)
        self.message = try container.decodeIfPresent(String.self, forKey: LogInModel.CodingKeys.message)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<LogInModel.CodingKeys> = encoder.container(keyedBy: LogInModel.CodingKeys.self)
        
        try container.encodeIfPresent(self.user_id, forKey: LogInModel.CodingKeys.user_id)
        try container.encodeIfPresent(self.message, forKey: LogInModel.CodingKeys.message)
    }
}
