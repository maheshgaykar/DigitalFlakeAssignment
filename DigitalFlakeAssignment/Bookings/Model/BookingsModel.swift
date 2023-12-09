//
//  BookingsModel.swift
//  DigitalFlakeAssignment
//
//  Created by mahesh gaykar on 09/12/23.
//

import Foundation

// MARK: - BookingModel
struct BookingModel: Codable {
    let bookings: [Booking]?
    
    enum CodingKeys: CodingKey {
        case bookings
    }
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<BookingModel.CodingKeys> = try decoder.container(keyedBy: BookingModel.CodingKeys.self)
        
        self.bookings = try container.decodeIfPresent([Booking].self, forKey: BookingModel.CodingKeys.bookings)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<BookingModel.CodingKeys> = encoder.container(keyedBy: BookingModel.CodingKeys.self)
        
        try container.encodeIfPresent(self.bookings, forKey: BookingModel.CodingKeys.bookings)
    }
}

// MARK: - Booking
struct Booking: Codable {
    let workspaceName: String?
    let workspaceID: Int?
    let bookingDate: String?

    enum CodingKeys: String, CodingKey {
        case workspaceName = "workspace_name"
        case workspaceID = "workspace_id"
        case bookingDate = "booking_date"
    }
    
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Booking.CodingKeys> = try decoder.container(keyedBy: Booking.CodingKeys.self)
        
        self.workspaceName = try container.decodeIfPresent(String.self, forKey: Booking.CodingKeys.workspaceName)
        self.workspaceID = try container.decodeIfPresent(Int.self, forKey: Booking.CodingKeys.workspaceID)
        self.bookingDate = try container.decodeIfPresent(String.self, forKey: Booking.CodingKeys.bookingDate)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Booking.CodingKeys> = encoder.container(keyedBy: Booking.CodingKeys.self)
        
        try container.encodeIfPresent(self.workspaceName, forKey: Booking.CodingKeys.workspaceName)
        try container.encodeIfPresent(self.workspaceID, forKey: Booking.CodingKeys.workspaceID)
        try container.encodeIfPresent(self.bookingDate, forKey: Booking.CodingKeys.bookingDate)
    }
}
