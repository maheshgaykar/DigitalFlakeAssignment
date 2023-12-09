//
//  NetworkEndPoints.swift
//  DigitalFlakeAssignment
//
//  Created by mahesh gaykar on 08/12/23.
//

import Foundation

class DigitalFlakeUrl {
    
    static let baseUrl = "https://demo0413095.mockable.io/digitalflake/api/"
    // EndPoints
    static let login = baseUrl + "login"
    static let createAccount = baseUrl + "create_account"
    static let getSlots = baseUrl + "get_slots"
    static let getAvailability = baseUrl + "get_availability"
    static let confirmBooking = baseUrl + "confirm_booking"
    static let getBooking = baseUrl + "get_bookings"
    
    
    
}
