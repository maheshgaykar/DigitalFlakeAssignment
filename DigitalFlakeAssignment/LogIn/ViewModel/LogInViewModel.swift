//
//  LogInViewModel.swift
//  DigitalFlakeAssignment
//
//  Created by mahesh gaykar on 08/12/23.
//

import Foundation

class logInViewModel {
    
    var iconClick = true
    typealias logInHandler = (_ isSuccess :Bool,_ dataMessage: String,_ id: Int) -> Void
    // Log in API call
    func logInAPICall(email: String, password: String, completion: @escaping logInHandler) {
        var param : [String:String] = [:]
        param["email"] = email
        param["password"] = password
        
        NetworkManager.shared.request(DigitalFlakeUrl.login, encoding: JSONDataEncoding(val: param)) { result in
            switch result {
            case .success(let val) :
                if let data = try? JSONDecoder().decode(LogInModel.self, from: val){
                    if data.user_id ?? 0 != 0{
                        completion(true, data.message ?? "", data.user_id ?? 0)
                    }else{
                        completion(false, "logIn API Failed", 0)
                    }
                }else{
                    completion(false, "logIn API Failed", 0)
                }
            case .failure(let err):
                completion(false, err.localizedDescription, 0)
            }
        }
    }
}
