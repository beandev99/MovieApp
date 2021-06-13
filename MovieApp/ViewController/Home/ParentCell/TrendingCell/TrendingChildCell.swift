//
//  RecommendChildCell.swift
//  MovieApp
//
//  Created by Tuan Le on 08/06/2021.
//

import UIKit

class TrendingChildCell: UICollectionViewCell {

    @IBOutlet weak var imgRecommend: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imgRecommend.layer.cornerRadius = 10
        // Initialization code
    }

}
