//
//  HeaderDetailCell.swift
//  MovieApp
//
//  Created by Tuan Le on 12/06/2021.
//

import UIKit
import NVActivityIndicatorView
import AVKit

class HeaderDetailCell: UICollectionViewCell {
    @IBOutlet weak var imgPreview: UIImageView!
    @IBOutlet weak var viewLoading: NVActivityIndicatorView!
    @IBOutlet weak var btnPlay: UIButton!
    var urlMovie: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewLoading.startAnimating()
        viewLoading.type = .ballRotate
        viewLoading.color = UIColor.init(hex: "FFD130")
        print(imgPreview.frame.origin.x)
    }

    @IBAction func play(_ sender: Any) {
        let vc = AVPlayerViewController()
        let player = AVPlayer(url: URL(string: urlMovie!)!)
        vc.player = player
        UIApplication.getTopViewController()?.present(vc, animated: true, completion: nil)
        
    }

}
