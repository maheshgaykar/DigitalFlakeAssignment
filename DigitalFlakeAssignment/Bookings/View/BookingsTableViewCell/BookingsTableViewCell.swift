//
//  BookingsTableViewCell.swift
//  DigitalFlakeAssignment
//
//  Created by mahesh gaykar on 08/12/23.
//

import UIKit

class BookingsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var lblDeskIdkey: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblBookedOn: UILabel!
    @IBOutlet weak var lblDeskIdVal: UILabel!
    @IBOutlet weak var lblNameVal: UILabel!
    @IBOutlet weak var lblBookedOnVal: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        self.setProperties()
        self.bgView.layer.cornerRadius = 10
        self.bgView.layer.backgroundColor = DFColor.primaryBlue.withAlphaComponent(0.1).cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell(deskId: Int, name: String, bookedOn: String){
        lblDeskIdVal.text = "\(deskId)"
        lblNameVal.text = name
        lblBookedOnVal.text = bookedOn
    }
    
}

extension BookingsTableViewCell{
    func setProperties(){
        self.lblDeskIdkey.text = "Desk ID"
        self.lblDeskIdkey.font = DFFonts.Poppins12
        self.lblName.text = "Name"
        self.lblName.font = DFFonts.Poppins12
        self.lblBookedOn.text = "Booked On"
        self.lblBookedOn.font = DFFonts.Poppins12
        
        lblDeskIdVal.font = DFFonts.Poppins14
        lblNameVal.font = DFFonts.Poppins14
        lblBookedOnVal.font = DFFonts.Poppins14
    }
}
