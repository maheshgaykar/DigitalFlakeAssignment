//
//  HomeScreenCollectionViewCell.swift
//  DigitalFlakeAssignment
//
//  Created by mahesh gaykar on 08/12/23.
//

import UIKit
import Foundation

class HomeScreenCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblNameList: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        bgView.layer.cornerRadius = 10
        bgView.layer.borderWidth = 1
        bgView.layer.borderColor = DFColor.primaryBlue.withAlphaComponent(0.5).cgColor
        bgView.backgroundColor = DFColor.primaryBlue.withAlphaComponent(0.5)
        lblNameList.numberOfLines = 2
        self.lblNameList.font = DFFonts.Poppins20
        
    }
    
    func configureCell(name: String, index: Int, selectedItem: Set<Int>) {
        
        if selectedItem.contains(index){
            bgView.backgroundColor = .blue.withAlphaComponent(0.8)
        }else{
            bgView.backgroundColor = .blue.withAlphaComponent(0.5)
        }
        
        lblNameList.text = name
        if index == 0 {
            imgView.image = UIImage(named: "book.work.station")
        }else if index == 1 {
            imgView.image = UIImage(named: "meeting.room")
        }
    }

}
