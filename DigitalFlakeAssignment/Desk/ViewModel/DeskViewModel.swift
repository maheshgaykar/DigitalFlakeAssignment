//
//  DeskViewModel.swift
//  DigitalFlakeAssignment
//
//  Created by mahesh gaykar on 08/12/23.
//

import Foundation

class DeskViewModel {
    
    var selectedTiming: Set<Int> = []
    var selectedTimingSlot: Set<String> = []
    typealias getSlotsAccountHandler = (_ isSuccess :Bool,_ dataMessage: String,_ slots: [Slot]) -> Void
    // getSlots in API call
    func getSlots(date: String, completion: @escaping getSlotsAccountHandler) {
        
        let queryItems: [String: String] = ["date": date]
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
        
        NetworkManager.shared.request(DigitalFlakeUrl.getSlots+sQueryItems, method: .get) { result in
            switch result {
            case .success(let val) :
                if let data = try? JSONDecoder().decode(SlotsModel.self, from: val){
                    if data.slots?.count ?? 0 > 0{
                        completion(true, "", data.slots ?? [])
                    }else{
                        completion(false, "get_slots API Failed", [])
                    }
                }else {
                    completion(false, "get_slots API Failed", [])
                }
            case .failure(let err):
                completion(false, err.localizedDescription, [])
            }
        }
    }
    
    func dateConverterToyyyyMMDD(date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    func dateConverterToEdMMM(date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM"
        print("date_E, d MMM: ",dateFormatter.string(from: date))
        return dateFormatter.string(from: date)
    }

    func selectItemAvailabilities(_ item: Int) {
        if let selectedItem = selectedTiming.first {
            if selectedItem == item {
                selectedTiming.remove(selectedItem)         //to remove element
            } else {
                selectedTiming = [item]
            }
        } else {
            selectedTiming = [item]
        }
    }
    
    func selectItemTimingSlot(_ item: String) {
        if let selectedItem = selectedTimingSlot.first {
            if selectedItem == item {
                selectedTimingSlot.remove(selectedItem)         //to remove element
            } else {
                selectedTimingSlot = [item]
            }
        } else {
            selectedTimingSlot = [item]
        }
    }
}
