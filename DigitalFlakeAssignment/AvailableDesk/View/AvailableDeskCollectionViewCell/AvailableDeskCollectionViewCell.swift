//
//  AvailableDeskCollectionViewCell.swift
//  DigitalFlakeAssignment
//
//  Created by mahesh gaykar on 08/12/23.
//

import UIKit

class AvailableDeskCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var lblDeskId: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bgView.layer.borderWidth = 0.5
        self.bgView.layer.cornerRadius = 5
    }
    
    func configureCell(deskId: String , isAvailable: Bool,selectedAvailableDesks: Set<String>){
        lblDeskId.text = deskId
        if selectedAvailableDesks.contains(deskId){
            self.bgView.layer.borderColor = DFColor.primaryBlue.withAlphaComponent(0.8).cgColor
            self.bgView.layer.backgroundColor = DFColor.primaryBlue.withAlphaComponent(0.8).cgColor
            lblDeskId.textColor = UIColor.white
        }else if isAvailable {
            self.bgView.layer.borderColor = DFColor.primaryBlue.withAlphaComponent(0.3).cgColor
            self.bgView.layer.backgroundColor = DFColor.primaryBlue.withAlphaComponent(0.3).cgColor
            lblDeskId.textColor = UIColor.black
        }else {
            self.bgView.layer.borderColor = DFColor.primaryGray.withAlphaComponent(0.5).cgColor
            self.bgView.layer.backgroundColor = DFColor.primaryGray.withAlphaComponent(0.5).cgColor
            lblDeskId.textColor = UIColor.white
        }
    }

}
