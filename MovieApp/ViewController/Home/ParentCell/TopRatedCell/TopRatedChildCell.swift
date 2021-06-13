//
//  TrendingChildCell.swift
//  MovieApp
//
//  Created by Tuan Le on 08/06/2021.
//

import UIKit

class TopRatedChildCell: UICollectionViewCell {

    @IBOutlet weak var imgTrending: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imgTrending.layer.cornerRadius = 10
        // Initialization code
    }

}
