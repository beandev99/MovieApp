//
//  CategoryMovieCell.swift
//  MovieApp
//
//  Created by Tuan Le on 10/06/2021.
//

import UIKit

class CategoryMovieCell: UICollectionViewCell {

    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgMovie.layer.cornerRadius = 10
        // Initialization code
    }

}
