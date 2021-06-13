//
//  NowPlayingChildCell.swift
//  MovieApp
//
//  Created by Tuan Le on 08/06/2021.
//

import UIKit

class NowPlayingChildCell: UICollectionViewCell {

    @IBOutlet weak var imgNowPlaying: UIImageView!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblNameMovie: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        imgNowPlaying.layer.cornerRadius = 10
    }

}
