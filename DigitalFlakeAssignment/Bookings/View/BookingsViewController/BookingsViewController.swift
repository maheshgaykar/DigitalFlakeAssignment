//
//  BookingsViewController.swift
//  DigitalFlakeAssignment
//
//  Created by mahesh gaykar on 08/12/23.
//

import UIKit

class BookingsViewController: UIViewController {
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblBookings: UILabel!
    @IBOutlet weak var bookingsTableView: UITableView!
    var bookingsList: [Booking] = []
    var bookingViewModel: BookingViewModel = BookingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setOfProperties()
        self.bookingViewModel.getBookingsAPICall(userId: "1") { isSuccess, dataMessage, bookings in
            if isSuccess{
                self.bookingsList = bookings
            }
            DispatchQueue.main.async {
                self.bookingsTableView.reloadData()
            }
        }
    }
    
    
    @IBAction func btnBackIsPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension BookingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookingsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookingsTableViewCell", for: indexPath) as? BookingsTableViewCell else { return UITableViewCell()}
        let index = indexPath.item
        cell.configureCell(deskId: bookingsList[index].workspaceID ?? 0, name: bookingsList[index].workspaceName ?? "", bookedOn: bookingsList[index].bookingDate ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}


extension BookingsViewController {
    
    func setOfProperties(){
        btnBack.setImage(UIImage(named: "ep.back"), for: UIControl.State.normal)
        self.lblBookings.text = "Booking History"
        self.lblBookings.font = DFFonts.Poppins20
        bookingsTableView.register(UINib(nibName: "BookingsTableViewCell", bundle: nil), forCellReuseIdentifier: "BookingsTableViewCell")
        bookingsTableView.dataSource = self
        bookingsTableView.delegate = self
        
        bookingsTableView.separatorInset = .zero
        bookingsTableView.separatorStyle = .none
    }
}
