//
//  StringExtension.swift
//  DigitalFlakeAssignment
//
//  Created by mahesh gaykar on 08/12/23.
//

import Foundation

public extension String {
    
    func isValidPhoneNumber() -> Bool {
        let regEx = "^[0-9]{10}$"
        let phoneCheck = NSPredicate(format: "SELF MATCHES[c] %@", regEx)
        return phoneCheck.evaluate(with: self)
    }

    func isValidEmail() -> Bool {
        
        let emailRegEx =  "^[^.][A-Za-z0-9._%+-]{1,64}@[A-Za-z0-9.-]{1,255}\\.[A-Za-z]{2,}$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: self)
    }
    
    func isValidName() -> Bool {
        let firstNameRegex = "^[A-Za-z]+$"
        let firstNameTest = NSPredicate(format: "SELF MATCHES %@", firstNameRegex)
        return firstNameTest.evaluate(with: self)
    }
}

