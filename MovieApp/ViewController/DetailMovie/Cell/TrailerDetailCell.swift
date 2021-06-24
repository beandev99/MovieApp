//
//  TrailerDetailCell.swift
//  MovieApp
//
//  Created by Tuan Le on 14/06/2021.
//

import UIKit
import youtube_ios_player_helper


class TrailerDetailCell: UICollectionViewCell {

    @IBOutlet weak var viewTrailer: YTPlayerView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupPlayer(id: String?) {
        if let id = id {
            viewTrailer.load(withVideoId: id)
        }
    }

}
