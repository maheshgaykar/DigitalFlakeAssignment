//
//  ConfirmationViewModel.swift
//  DigitalFlakeAssignment
//
//  Created by mahesh gaykar on 08/12/23.
//

import Foundation

class ConfirmationViewModel {
    
    typealias confirmationHandler = (_ isSuccess: Bool ,_ message: String) -> Void
    // confirm_booking
    func confirmBookingAPICall(date: String, slotId: String, workpaceId: String ,type: String, completion: @escaping confirmationHandler) {
        var param : [String:String] = [:]
        param["date"] = date
        param["slot_id"] = slotId
        param["workspace_id"] = workpaceId
        param["type"] = type
        
        NetworkManager.shared.request(DigitalFlakeUrl.confirmBooking, encoding: JSONDataEncoding(val: param)) { result in
            switch result {
            case .success(let val) :
                if let data = try? JSONDecoder().decode(ConfirmBookingModel.self, from: val){
                    completion(true, data.message ?? "")
                }else {
                    completion(true, "confirmBooking API Failed")
                }
            case .failure(let err):
                completion(true, err.localizedDescription)
            }
        }
    }
    
    
}
