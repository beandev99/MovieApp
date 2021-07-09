//
//  ResultsSearchCell.swift
//  MovieApp
//
//  Created by Tuan Le on 05/07/2021.
//

import UIKit
import NVActivityIndicatorView

class ResultsSearchCell: UICollectionViewCell {

    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var viewLoading: NVActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewLoading.type = .ballZigZag
        viewLoading.color = UIColor.init(hex: "FFD130")
        viewLoading.startAnimating()
        // Initialization code
    }

}
