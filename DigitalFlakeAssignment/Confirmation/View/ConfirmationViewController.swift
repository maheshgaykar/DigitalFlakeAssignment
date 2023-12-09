//
//  ConfirmationViewController.swift
//  DigitalFlakeAssignment
//
//  Created by mahesh gaykar on 08/12/23.
//

import UIKit

class ConfirmationViewController: UIViewController {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var bookingConfirmView: UIView!
    @IBOutlet weak var lblDeskId: UILabel!
    @IBOutlet weak var lblDeskIdVal: UILabel!
    @IBOutlet weak var lblDeskKey: UILabel!
    @IBOutlet weak var lblDeskKeyVal: UILabel!
    @IBOutlet weak var lblSlotkey: UILabel!
    @IBOutlet weak var lblSlotVal: UILabel!
    @IBOutlet weak var bookingconfirmSubView: UIView!
    @IBOutlet weak var lblBookingConfirm: UILabel!
    @IBOutlet weak var btnBookingDismiss: UIButton!
    @IBOutlet weak var btnConfirm: UIButton!
    
    var confirmationViewModel = ConfirmationViewModel()
    var currentDate: String
    var selectedDate: String
    var bookworkOrMeetingRoom: Int
    var selectedSlotId : Int
    var selectedSlotTime: String
    var selectedworkSpaceId: Int
    
    init(bookworkOrMeetingRoom: Int, currentDate: String, selectedDate: String, selectedSlotId: Int, selectedSlotTime: String, selectedworkSpaceId: Int) {
        self.bookworkOrMeetingRoom = bookworkOrMeetingRoom
        self.selectedSlotId = selectedSlotId
        self.currentDate = currentDate
        self.selectedSlotTime = selectedSlotTime
        self.selectedDate = selectedDate
        self.selectedworkSpaceId = selectedworkSpaceId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Storyboard are a pain")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpProperties()
        self.setUpValues()
    }
    
    @IBAction func btnConfirmPressed(_ sender: Any) {
        
        confirmationViewModel.confirmBookingAPICall(date: "\(selectedDate)", slotId: "\(selectedSlotId)", workpaceId: "\(selectedworkSpaceId)", type: "\(bookworkOrMeetingRoom)") { isSuccess, message in
            if isSuccess{
                print("message: \(message)")
                let sceneDelegate = UIApplication.shared.connectedScenes
                    .first!.delegate as? SceneDelegate
                sceneDelegate?.window?.rootViewController = UINavigationController(rootViewController: HomeScreenViewController())
            }else {
                print("message: \(message)")
            }
        }
        
    }
    
    @IBAction func btnDismissIsPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension ConfirmationViewController{
    
    func setUpValues(){
        self.lblDeskKeyVal.text = "\(selectedworkSpaceId)"
        self.lblSlotVal.text = "\(currentDate) \(selectedSlotTime)"
        self.lblDeskIdVal.text = "\(selectedSlotId)"
    }
    
    func setUpProperties(){
        
        lblDeskId.font = DFFonts.Poppins10
        lblDeskIdVal.font = DFFonts.Poppins12
        lblDeskKey.font = DFFonts.Poppins14
        lblDeskKeyVal.font = DFFonts.Poppins14
        lblSlotkey.font = DFFonts.Poppins10
        lblSlotVal.font = DFFonts.Poppins12
        
        bgView.backgroundColor = DFColor.primaryGray.withAlphaComponent(0.8)
        bookingConfirmView.layer.cornerRadius = 10
        bookingconfirmSubView.layer.cornerRadius = 10
        bookingconfirmSubView.clipsToBounds = true
        bookingconfirmSubView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        bookingconfirmSubView.layer.backgroundColor = DFColor.primaryBlue.withAlphaComponent(0.1).cgColor
        bookingConfirmView.layer.backgroundColor = UIColor.white.cgColor
        
        self.lblBookingConfirm.text = "Confirm booking"
        self.lblDeskId.text = "Desk Id :"
        self.lblDeskKey.text = "Desk"
        self.lblSlotkey.text = "Slot"

        self.btnBookingDismiss.setImage(UIImage(named: "ic_round-cancel"), for: .normal)
        
        self.btnConfirm.setTitle("  Confirm  ", for: .normal)
        self.btnConfirm.setTitleColor(UIColor.white, for: .normal)
        self.btnConfirm.titleLabel?.font = DFFonts.PoppinsBold16
        self.btnConfirm.layer.backgroundColor = DFColor.primaryBlue.withAlphaComponent(0.8) .cgColor
        self.btnConfirm.layer.cornerRadius = 5.0
    }
}
