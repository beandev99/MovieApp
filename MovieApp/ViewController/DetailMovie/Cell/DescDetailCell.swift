//
//  DescDetailCell.swift
//  MovieApp
//
//  Created by Tuan Le on 12/06/2021.
//

import UIKit

class DescDetailCell: UICollectionViewCell {

    @IBOutlet weak var lblOverview: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        contentView.layer.cornerRadius = 20
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentView.backgroundColor = UIColor.init(hex: "25272A")
    }
    
    func setupTrailer() {
        
    }

}
