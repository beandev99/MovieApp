//
//  UpcommingChildCell.swift
//  MovieApp
//
//  Created by Tuan Le on 08/06/2021.
//

import UIKit

class UpcommingChildCell: UICollectionViewCell {

    @IBOutlet weak var imgUpcomming: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgUpcomming.layer.cornerRadius = 10
    }

}
