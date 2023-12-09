//
//  BookingViewModel.swift
//  DigitalFlakeAssignment
//
//  Created by mahesh gaykar on 08/12/23.
//

import Foundation

class BookingViewModel{
    
    typealias bookingsHandler = (_ isSuccess :Bool,_ dataMessage: String,_ bookings: [Booking]) -> Void
    
    func getBookingsAPICall(userId: String, comp: @escaping bookingsHandler) {
        
        let queryItems: [String: String] = ["user_id": userId]
        var sQueryItems = ""
        for(key, value) in queryItems {
            sQueryItems += key + "=" + value + "&"
        }
        if !sQueryItems.isEmpty {
            sQueryItems = "?" + sQueryItems
            if (sQueryItems.hasSuffix("&")) {
                sQueryItems.removeLast()
            }
        }
        
        NetworkManager.shared.request(DigitalFlakeUrl.getBooking+sQueryItems, method: .get) { result in
            switch result {
            case .success(let val) :
                if let data = try? JSONDecoder().decode(BookingModel.self, from: val){
                    comp(true, "", data.bookings ?? [] )
                }else{
                    comp(false, "bookingsAPI Failed", [])
                }
            case .failure(let err):
                comp(false, err.localizedDescription, [])
            }
        }
    }
}
