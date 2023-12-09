//
//  AvailableDeskViewModel.swift
//  DigitalFlakeAssignment
//
//  Created by mahesh gaykar on 08/12/23.
//

import Foundation

class  AvailableDeskViewModel{
    
    var selectedAvailableDesks : Set<String> = []
    var selectedworkSpaceId : Set<Int> = []
    
    typealias getAvailabilityHandler = (_ isSuccess :Bool,_ dataMessage: String,_ availability: [Availability]) -> Void
    
    // get_availability in API call
    func getAvailabilityAPICall(date: String, slotId: String, typeOfSlot: String, completion: @escaping getAvailabilityHandler) {
        
        let queryItems: [String: String] = ["date": date, "slot_id": slotId,"type": typeOfSlot]
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
        
        NetworkManager.shared.request(DigitalFlakeUrl.getAvailability+sQueryItems, method: .get) { result in
            switch result {
            case .success(let val) :
                if let data = try? JSONDecoder().decode(AvailabilityModel.self, from: val){
                    completion(true, "", data.availability ?? [])
                }else{
                    completion(false, "getAvailabilty API Failed", [])
                }
            case .failure(let err):
                completion(false, err.localizedDescription, [])
            }
        }
    }
    
    func selectItemWorkspaceName(_ item: String) {
        if let selectedItem = selectedAvailableDesks.first {
            if selectedItem == item {
                selectedAvailableDesks.remove(selectedItem)         //to remove element
            } else {
                selectedAvailableDesks = [item]
            }
        } else {
            selectedAvailableDesks = [item]
        }
    }
    
    func selectItemWorkspaceId(_ item: Int) {
        if let selectedItem = selectedworkSpaceId.first {
            if selectedItem == item {
                selectedworkSpaceId.remove(selectedItem)         //to remove element
            } else {
                selectedworkSpaceId = [item]
            }
        } else {
            selectedworkSpaceId = [item]
        }
    }
}
