//
//  InforSettingCell.swift
//  MovieApp
//
//  Created by Tuan Le on 09/07/2021.
//

import UIKit

class InforSettingCell: UICollectionViewCell {

    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var viewInfor: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgUser.layer.cornerRadius = imgUser.frame.width/2
        viewInfor.layer.cornerRadius = 20
        viewInfor.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
    }

}
