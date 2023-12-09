//
//  CreateAccountViewController.swift
//  DigitalFlakeAssignment
//
//  Created by mahesh gaykar on 08/12/23.
//

import UIKit

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var lblCreateAnAccount: UILabel!
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var tfFullName: UITextField!
    @IBOutlet weak var lblMobileNumber: UILabel!
    @IBOutlet weak var tfMobileNumber: UITextField!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var btnCreateAccount: UIButton!
    @IBOutlet weak var btnLogIn: UIButton!
    @IBOutlet weak var lblExistingUser: UILabel!
    
    var createAccountViewModel = CreateAccountViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.isHidden = true
        self.setUpProperties()
    }
    
    @IBAction func btnCreateAccountISPressed(_ sender: Any) {
        // API call to create account
        createAccountViewModel.createAccountAPICall(email: "", password: "", mobile: "") { isSuccess, dataMessage, id in
            if isSuccess{
                let sceneDelegate = UIApplication.shared.connectedScenes
                       .first!.delegate as? SceneDelegate
                sceneDelegate?.window?.rootViewController = UINavigationController(rootViewController: HomeScreenViewController())
            }
        }
    }
    
    @IBAction func btnLogInPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension CreateAccountViewController{
    
    func setUpProperties(){
        lblExistingUser.font = DFFonts.Poppins14
        self.lblEmail.text = "Email ID"
        self.lblEmail.font = DFFonts.Poppins16
        self.lblFullName.text = "Full Name"
        self.lblFullName.font = DFFonts.Poppins16
        self.lblMobileNumber.text = "mobile Number"
        self.lblMobileNumber.font = DFFonts.Poppins16
        
        self.lblCreateAnAccount.text = "Create an Account"
        self.lblCreateAnAccount.font = DFFonts.Poppins24
        self.tfFullName.delegate = self
        self.tfMobileNumber.delegate = self
        self.tfEmail.delegate = self
        
        tfFullName.autocorrectionType = .no
        tfFullName.keyboardType = .alphabet
        tfMobileNumber.autocorrectionType = .no
        tfMobileNumber.keyboardType = .numberPad
        tfEmail.autocorrectionType = .no
        tfEmail.keyboardType = .emailAddress
        
        self.btnCreateAccount.setTitle("Create an account", for: .normal)
        self.btnCreateAccount.setTitleColor(UIColor.white, for: .normal)
        self.btnCreateAccount.titleLabel?.font = DFFonts.PoppinsBold16
        self.btnCreateAccount.layer.backgroundColor = DFColor.primaryBlue.withAlphaComponent(0.3).cgColor
        self.btnCreateAccount.isUserInteractionEnabled = false
        self.btnCreateAccount.layer.cornerRadius = 5.0
        
        let yourAttributes: [NSAttributedString.Key: Any] = [
            .font: DFFonts.Poppins16 as Any,
            .foregroundColor: DFColor.primaryBlue,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let attributeString = NSMutableAttributedString(
            string: "Log In",
            attributes: yourAttributes
        )
        btnLogIn.setAttributedTitle(attributeString, for: .normal)
    }
}

extension CreateAccountViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == self.tfFullName || textField == self.tfEmail       || textField == self.tfMobileNumber ) {
            if (self.tfEmail.text?.isValidEmail() ?? false && self.tfFullName.text?.isValidName() ?? false && self.tfMobileNumber.text?.isValidPhoneNumber() ?? false ){
                self.btnCreateAccount.isUserInteractionEnabled = true
                self.btnCreateAccount.layer.backgroundColor = DFColor.primaryBlue.withAlphaComponent(0.8).cgColor
            }else{
                self.btnCreateAccount.isUserInteractionEnabled = false
                self.btnCreateAccount.layer.backgroundColor = DFColor.primaryBlue.withAlphaComponent(0.3).cgColor
            }
        }
        textField.resignFirstResponder()
        return true
    }
}
