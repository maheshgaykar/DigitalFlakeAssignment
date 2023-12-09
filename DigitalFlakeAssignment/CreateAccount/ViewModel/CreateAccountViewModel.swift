//
//  CreateAccountViewModel.swift
//  DigitalFlakeAssignment
//
//  Created by mahesh gaykar on 08/12/23.
//

import Foundation

class CreateAccountViewModel {
    
    typealias createAccountHandler = (_ isSuccess :Bool,_ dataMessage: String,_ id: Int) -> Void
    // create in API call
    func createAccountAPICall(email: String, password: String, mobile: String, completion: @escaping createAccountHandler) {
        
        var param : [String:String] = [:]
        param["email"] = email
        param["password"] = password
        
        NetworkManager.shared.request(DigitalFlakeUrl.createAccount, encoding: JSONDataEncoding(val: param)) { result in
            switch result {
            case .success(let val) :
                if let data = try? JSONDecoder().decode(LogInModel.self, from: val){
                    if data.user_id ?? 0 != 0{
                        completion(true, data.message ?? "", data.user_id ?? 0)
                    }else{
                        completion(false, "createAccount API Failed", 0)
                    }
                }else{
                    completion(false, "createAccount API Failed", 0)
                }
            case .failure(let err):
                completion(false, err.localizedDescription, 0)
            }
        }
    }
}
