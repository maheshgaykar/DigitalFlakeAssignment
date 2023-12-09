//
//  HomeScreenViewModel.swift
//  DigitalFlakeAssignment
//
//  Created by mahesh gaykar on 08/12/23.
//

import Foundation

class HomeScreenViewModel {
    
    var selctedIndex: Set<Int> = []
    
    func selectIndexId(_ item: Int) {
        if let selectedItem = selctedIndex.first {
            if selectedItem == item {
                selctedIndex.remove(selectedItem)         //to remove element
            } else {
                selctedIndex = [item]
            }
        } else {
            selctedIndex = [item]
        }
    }
    
}
