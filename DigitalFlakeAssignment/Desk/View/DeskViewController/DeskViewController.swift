//
//  DeskViewController.swift
//  DigitalFlakeAssignment
//
//  Created by mahesh gaykar on 08/12/23.
//

import UIKit
import FSCalendar

class DeskViewController: UIViewController {
    
    @IBOutlet weak var fsCalenderView: FSCalendar!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblSelectyDateAndSlot: UILabel!
    @IBOutlet weak var deskCollectionView: UICollectionView!
    @IBOutlet weak var btnNext: UIButton!
    
    var listDesk: [Slot] = []
    var deskViewModel = DeskViewModel()
    
    var currentDate = ""
    var selectedDate = ""
    var bookworkOrMeetingRoom: Int
    
    init(bookworkOrMeetingRoom: Int) {
        self.bookworkOrMeetingRoom = bookworkOrMeetingRoom
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Storyboard are a pain")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpOfProperties()
        deskViewModel.getSlots(date: deskViewModel.dateConverterToyyyyMMDD(date: Date()) ) { isSuccess, dataMessage, slots in
            self.currentDate = self.deskViewModel.dateConverterToEdMMM(date: Date())
            self.selectedDate = self.deskViewModel.dateConverterToyyyyMMDD(date: Date())
            if isSuccess{
                self.listDesk = slots
            }
            DispatchQueue.main.async {
                self.deskCollectionView.reloadData()
            }
        }
    }
    
    @IBAction func btnBackIsPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNextIsPressed(_ sender: Any) {
        self.navigationController?.pushViewController(AvailableDeskViewController(bookworkOrMeetingRoom: bookworkOrMeetingRoom, currentDate: currentDate, selectedDate: self.selectedDate, selectedSlotId: deskViewModel.selectedTiming.first ?? 0, selectedSlotTime: deskViewModel.selectedTimingSlot.first ?? ""), animated: true)
    }
}

extension DeskViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listDesk.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DeskCollectionViewCell", for: indexPath) as? DeskCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(slotTiming: self.listDesk[indexPath.item].slotName ?? "", isAvialble: self.listDesk[indexPath.item].slotActive ?? false, slot: self.listDesk[indexPath.item].slotID ?? 0, selectedTiming: deskViewModel.selectedTiming)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if self.listDesk[indexPath.item].slotActive ?? false {
            self.deskViewModel.selectItemAvailabilities(self.listDesk[indexPath.item].slotID ?? 0)
            self.deskViewModel.selectItemTimingSlot(self.listDesk[indexPath.item].slotName ?? "")
            DispatchQueue.main.async {
                self.deskCollectionView.reloadData()
            }
        }
        
        if self.deskViewModel.selectedTiming.count > 0 {
            self.btnNext.layer.backgroundColor = DFColor.primaryBlue.withAlphaComponent(0.8) .cgColor
            self.btnNext.isUserInteractionEnabled = true
        }else {
            self.btnNext.layer.backgroundColor = DFColor.primaryBlue.withAlphaComponent(0.3) .cgColor
            self.btnNext.isUserInteractionEnabled = false
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width)/2 - 2, height: 42)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
}

extension DeskViewController{
    
    func setUpOfProperties(){
        
        self.btnNext.setTitle("Next", for: .normal)
        self.btnNext.titleLabel?.font = DFFonts.PoppinsBold16
        self.btnNext.setTitleColor(UIColor.white, for: .normal)
        self.btnNext.layer.backgroundColor = DFColor.primaryBlue.cgColor
        self.btnNext.layer.cornerRadius = 5.0
        
        self.lblSelectyDateAndSlot.text = "Select Date And Slot"
        self.lblSelectyDateAndSlot.font = DFFonts.Poppins20
        self.btnBack.setImage(UIImage(named: "ep.back"), for: UIControl.State.normal)
        
        self.deskCollectionView.register(UINib(nibName: "DeskCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DeskCollectionViewCell")
        self.deskCollectionView.dataSource = self
        self.deskCollectionView.delegate = self
        
        self.btnNext.layer.backgroundColor = DFColor.primaryBlue.withAlphaComponent(0.3).cgColor
        self.btnNext.isUserInteractionEnabled = false
        
        fsCalenderView.dataSource = self
        fsCalenderView.delegate = self
        fsCalenderView.scope = .week
        fsCalenderView.headerHeight = 25
        fsCalenderView.weekdayHeight = 40
        fsCalenderView.fs_height = 100
        fsCalenderView.collectionView.reloadData()
    }
}

extension DeskViewController: FSCalendarDataSource,FSCalendarDelegate,FSCalendarCollectionViewInternalDelegate{
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        if self.selectedDate != self.deskViewModel.dateConverterToyyyyMMDD(date: date){
            self.deskViewModel.getSlots(date: deskViewModel.dateConverterToyyyyMMDD(date: date) ) { isSuccess, dataMessage, slots in
                if isSuccess {
                    self.currentDate = self.deskViewModel.dateConverterToEdMMM(date: date)
                    self.selectedDate = self.deskViewModel.dateConverterToyyyyMMDD(date: date)
                    self.deskViewModel.selectedTiming = []
                    self.btnNext.isUserInteractionEnabled = false
                    self.btnNext.layer.backgroundColor = DFColor.primaryBlue.withAlphaComponent(0.3) .cgColor
                    
                    self.listDesk = slots
                    print("Slots Updated as per date")
                }
                DispatchQueue.main.async {
                    self.deskCollectionView.reloadData()
                }
            }
        }
    }
}
