//
//  LogInViewController.swift
//  DigitalFlakeAssignment
//
//  Created by mahesh gaykar on 08/12/23.
//

import UIKit
import Foundation

class LogInViewController: UIViewController {
    
    @IBOutlet weak var imgDigitalFlake: UIImageView!
    @IBOutlet weak var lblCoworking: UILabel!
    @IBOutlet weak var lblMobileNumberEmail: UILabel!
    @IBOutlet weak var tfMobileNumberEmail: UITextField!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnLogIn: UIButton!
    @IBOutlet weak var btnCreateAnAccount: UIButton!
    @IBOutlet weak var lblNewUser: UILabel!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var btnIsShowPassword: UIButton!
    
    
    var logInVm = logInViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.isHidden = true
        self.setUpProperties()
    }
    
    @IBAction func createAnAccountisPressed(_ sender: Any) {
        self.navigationController?.pushViewController(CreateAccountViewController(), animated: true)
    }
    
    @IBAction func btnLogInIsPressed(_ sender: Any) {
        print("btnLogInIsPressed")
        
        self.logInVm.logInAPICall(email: "", password: "") { (isSuccess, dataMessage, id) in
            if isSuccess {
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(HomeScreenViewController(), animated: true)
                }
            }
        }
    }
    
    @IBAction func iconAction(sender: AnyObject) {
        if logInVm.iconClick {
            tfPassword.isSecureTextEntry = false
            btnIsShowPassword.setImage(UIImage(systemName: "eye"), for: .normal)
        } else {
            tfPassword.isSecureTextEntry = true
            btnIsShowPassword.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
        logInVm.iconClick = !logInVm.iconClick
    }
}

extension LogInViewController{
    
    func setUpProperties(){
        
        self.lblNewUser.text = "New user?"
        self.lblNewUser.font = DFFonts.Poppins14
        
        self.lblPassword.font = DFFonts.Poppins16
        self.imgDigitalFlake.image = UIImage(named: "DF.Icon")
        self.lblCoworking.text = "Co-working"
        self.lblCoworking.font = DFFonts.Poppins24
        self.lblMobileNumberEmail.text = "Mobile number or Email"
        self.lblMobileNumberEmail.font = DFFonts.Poppins16
        self.lblPassword.text = "Password"
        self.lblPassword.font = DFFonts.Poppins16
        self.tfPassword.delegate = self
        self.tfMobileNumberEmail.delegate = self
        
        tfPassword.autocorrectionType = .no
        tfPassword.keyboardType = .alphabet
        tfPassword.isSecureTextEntry = true
        
        tfMobileNumberEmail.autocorrectionType = .no
        tfMobileNumberEmail.keyboardType = .alphabet
       
        self.passwordView.layer.cornerRadius = 5.0
        self.passwordView.layer.borderWidth = 0.3
        self.passwordView.layer.borderColor = DFColor.primaryGray.cgColor
        
        btnIsShowPassword.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        btnIsShowPassword.tintColor = DFColor.primaryGray.withAlphaComponent(0.5)
        self.btnLogIn.setTitle("Log In", for: .normal)
        self.btnLogIn.titleLabel?.font = DFFonts.PoppinsBold16
        self.btnLogIn.setTitleColor(UIColor.white, for: .normal)
        self.btnLogIn.isUserInteractionEnabled = false
        self.btnLogIn.layer.backgroundColor = DFColor.primaryBlue.withAlphaComponent(0.3).cgColor
        self.btnLogIn.layer.cornerRadius = 5.0
       
        let yourAttributes: [NSAttributedString.Key: Any] = [
            .font: DFFonts.Poppins16 as Any,
            .foregroundColor: DFColor.primaryBlue,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let attributeString = NSMutableAttributedString(
            string: "Create An Account",
            attributes: yourAttributes
        )
        btnCreateAnAccount.setAttributedTitle(attributeString, for: .normal)
    }
}

extension LogInViewController: UITextFieldDelegate  {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == tfPassword {
            self.tfPassword.resignFirstResponder()
        }else if textField == tfMobileNumberEmail {
            self.tfMobileNumberEmail.resignFirstResponder()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == self.tfMobileNumberEmail || textField == self.tfPassword) {
            if (self.tfMobileNumberEmail.text?.count ?? 0 > 0 && self.tfPassword.text?.isValidPassword() ?? false){
                self.btnLogIn.isUserInteractionEnabled = true
                self.btnLogIn.layer.backgroundColor = DFColor.primaryBlue.withAlphaComponent(0.8).cgColor
            }else{
                self.btnLogIn.isUserInteractionEnabled = false
                self.btnLogIn.layer.backgroundColor = DFColor.primaryBlue.withAlphaComponent(0.3).cgColor
            }
        }
        textField.resignFirstResponder()
        return true
    }
    
}
