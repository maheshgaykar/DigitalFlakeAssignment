//
//  DeskCollectionViewCell.swift
//  DigitalFlakeAssignment
//
//  Created by mahesh gaykar on 08/12/23.
//

import UIKit

class DeskCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var lblTiming: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setUpProperties()
    }
    
    func configureCell(slotTiming: String, isAvialble: Bool , slot: Int, selectedTiming: Set<Int>){
        self.lblTiming.text = slotTiming
        if selectedTiming.contains(slot){
            self.bgView.layer.backgroundColor = DFColor.primaryBlue.withAlphaComponent(0.8).cgColor
            lblTiming.textColor = UIColor.white
        } else if isAvialble{
            self.bgView.layer.backgroundColor = DFColor.primaryBlue.withAlphaComponent(0.3).cgColor
            lblTiming.textColor = UIColor.black
        }else{
            self.bgView.layer.backgroundColor = DFColor.primaryGray.withAlphaComponent(0.8).cgColor
            lblTiming.textColor = UIColor.white
        }
    }
    
    func setUpProperties(){
        lblTiming.font = DFFonts.Poppins14
        bgView.layer.cornerRadius = 5
    }

}
