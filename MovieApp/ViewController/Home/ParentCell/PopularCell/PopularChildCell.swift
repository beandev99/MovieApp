//
//  PopularChildCell.swift
//  MovieApp
//
//  Created by Tuan Le on 08/06/2021.
//

import UIKit

class PopularChildCell: UICollectionViewCell {

    @IBOutlet weak var imgPopular: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgPopular.layer.cornerRadius = 10
        // Initialization code
    }

}
