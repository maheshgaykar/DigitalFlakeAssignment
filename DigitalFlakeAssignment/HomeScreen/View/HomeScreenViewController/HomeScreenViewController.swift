//
//  HomeScreenViewController.swift
//  DigitalFlakeAssignment
//
//  Created by mahesh gaykar on 08/12/23.
//

import UIKit

class HomeScreenViewController: UIViewController{
    
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblCoWorking: UILabel!
    @IBOutlet weak var btnBookingHistory: UIButton!
    @IBOutlet weak var listCollectionView: UICollectionView!
    
    var list = ["Book Work Station", " Meeting Room "]
    
    var bookworkOrMeetingRoom = 0 // 0= book work 1= meeting room
    var homeScreenVM = HomeScreenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let cvLayout = listCollectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            cvLayout.estimatedItemSize = .zero
        }
        self.lblCoWorking.text = "Co-working"
        self.lblCoWorking.font = DFFonts.PoppinsBold14
        self.btnBookingHistory.setTitle("   Booking History   ", for: .normal)
        self.btnBookingHistory.titleLabel?.font = DFFonts.PoppinsMedium14
        self.btnBookingHistory.backgroundColor = DFColor.primaryBlue
        self.btnBookingHistory.layer.cornerRadius = 5.0
        imgLogo.image = UIImage(named: "DF.Icon")
        
        self.listCollectionView.register(UINib(nibName: "HomeScreenCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeScreenCollectionViewCell")
        self.listCollectionView.dataSource = self
        self.listCollectionView.delegate = self
        
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btnBookingHistoryPressed(_ sender: Any) {
        self.navigationController?.pushViewController(BookingsViewController(), animated: true)
    }
}

extension HomeScreenViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeScreenCollectionViewCell", for: indexPath) as? HomeScreenCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(name: list[indexPath.item], index:  indexPath.item, selectedItem: homeScreenVM.selctedIndex)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if list[indexPath.item] == "Book Work Station"{
            self.bookworkOrMeetingRoom = 0 // Book Work
        }else {
            self.bookworkOrMeetingRoom = 1 // meeting
        }
        self.homeScreenVM.selectIndexId(indexPath.item)
        DispatchQueue.main.async {
            self.listCollectionView.reloadData()
        }
        self.navigationController?.pushViewController(DeskViewController(bookworkOrMeetingRoom: self.bookworkOrMeetingRoom), animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width)/2 - 10, height: 200)
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
