//
//  HeaderDetailCell.swift
//  MovieApp
//
//  Created by Tuan Le on 12/06/2021.
//

import UIKit
import NVActivityIndicatorView

class HeaderDetailCell: UICollectionViewCell {
    @IBOutlet weak var imgPreview: UIImageView!
    @IBOutlet weak var viewLoading: NVActivityIndicatorView!
    @IBOutlet weak var btnPlay: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewLoading.startAnimating()
        viewLoading.type = .ballRotate
        viewLoading.color = UIColor.init(hex: "FFD130")
    }

    @IBAction func play(_ sender: Any) {
    }

}
