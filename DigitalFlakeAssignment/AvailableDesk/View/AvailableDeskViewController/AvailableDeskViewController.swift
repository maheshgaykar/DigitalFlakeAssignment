//
//  AvailableDeskViewController.swift
//  DigitalFlakeAssignment
//
//  Created by mahesh gaykar on 08/12/23.
//

import UIKit

class AvailableDeskViewController: UIViewController {
    
    @IBOutlet weak var lblAvailability: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblTimingOfSlots: UILabel!
    @IBOutlet weak var availabiiltySolotCollectionView: UICollectionView!
    @IBOutlet weak var btnBookDesk: UIButton!
    
    var availableDesks: [Availability] = []
    var availableDeskViewModel = AvailableDeskViewModel()
    var selectedAvailableDesks : Set<String> = []
    
    var currentDate: String
    var selectedDate: String
    var bookworkOrMeetingRoom: Int
    var selectedSlotId : Int
    var selectedSlotTime: String
    
    init(bookworkOrMeetingRoom: Int, currentDate: String, selectedDate: String, selectedSlotId: Int, selectedSlotTime: String) {
        self.bookworkOrMeetingRoom = bookworkOrMeetingRoom
        self.selectedSlotId = selectedSlotId
        self.currentDate = currentDate
        self.selectedSlotTime = selectedSlotTime
        self.selectedDate = selectedDate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Storyboard are a pain")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpProperties()
        self.availableDeskViewModel.getAvailabilityAPICall(date: self.selectedDate, slotId: "\(self.selectedSlotId)", typeOfSlot: "\(self.bookworkOrMeetingRoom)") { isSuccess, dataMessage, availability in
            self.availableDesks = availability
            
            DispatchQueue.main.async {
                self.availabiiltySolotCollectionView.reloadData()
            }
        }
    }
    
    @IBAction func btnBookDeskPressed(_ sender: Any) {
        let vc = ConfirmationViewController(bookworkOrMeetingRoom: self.bookworkOrMeetingRoom, currentDate: self.currentDate, selectedDate: self.selectedDate, selectedSlotId: self.selectedSlotId, selectedSlotTime: self.selectedSlotTime, selectedworkSpaceId: self.availableDeskViewModel.selectedworkSpaceId.first ?? 0)
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    @IBAction func btnBackIsPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension AvailableDeskViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return availableDesks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AvailableDeskCollectionViewCell", for: indexPath) as? AvailableDeskCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(deskId: availableDesks[indexPath.item].workspaceName ?? "", isAvailable: self.availableDesks[indexPath.row].workspaceActive ?? false, selectedAvailableDesks:  availableDeskViewModel.selectedAvailableDesks)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if availableDesks[indexPath.item].workspaceActive ?? false {
            self.availableDeskViewModel.selectItemWorkspaceName(availableDesks[indexPath.item].workspaceName ?? "")
            self.availableDeskViewModel.selectItemWorkspaceId(availableDesks[indexPath.item].workspaceID ?? 0)
            
            print("workspaceName", availableDesks[indexPath.item].workspaceName ?? "")
            DispatchQueue.main.async {
                self.availabiiltySolotCollectionView.reloadData()
            }
        }
        if self.availableDeskViewModel.selectedAvailableDesks.count > 0 {
            self.btnBookDesk.layer.backgroundColor = DFColor.primaryBlue.withAlphaComponent(0.8) .cgColor
            self.btnBookDesk.isUserInteractionEnabled = true
        }else {
            self.btnBookDesk.layer.backgroundColor = DFColor.primaryBlue.withAlphaComponent(0.3) .cgColor
            self.btnBookDesk.isUserInteractionEnabled = false
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width)/6 - 10, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
}


extension AvailableDeskViewController {
    
    func setUpProperties(){
        
        self.btnBack.setImage(UIImage(named: "ep.back"), for: .normal)
        self.lblAvailability.text = "Available Desks"
        self.lblAvailability.font = DFFonts.Poppins20
        
        self.lblTimingOfSlots.text = "\(currentDate) \(selectedSlotTime)"
        self.lblTimingOfSlots.font = DFFonts.Poppins13
        
        self.btnBookDesk.setTitle("Book Desk", for: .normal)
        self.btnBookDesk.setTitleColor(UIColor.white, for: .normal)
        self.btnBookDesk.layer.backgroundColor = DFColor.primaryBlue.withAlphaComponent(0.3) .cgColor
        self.btnBookDesk.titleLabel?.font = DFFonts.PoppinsBold16
        self.btnBookDesk.isUserInteractionEnabled = false
        self.btnBookDesk.layer.cornerRadius = 5.0
        
        self.availabiiltySolotCollectionView.register(UINib(nibName: "AvailableDeskCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AvailableDeskCollectionViewCell")
        self.availabiiltySolotCollectionView.dataSource = self
        self.availabiiltySolotCollectionView.delegate = self
    }
}
