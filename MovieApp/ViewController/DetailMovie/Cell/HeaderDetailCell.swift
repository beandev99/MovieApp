//
//  HeaderDetailCell.swift
//  MovieApp
//
//  Created by Tuan Le on 12/06/2021.
//
import AVPlayerViewControllerSubtitles
import UIKit
import NVActivityIndicatorView
import AVKit


class HeaderDetailCell: UICollectionViewCell {
    @IBOutlet weak var imgPreview: UIImageView!
    @IBOutlet weak var viewLoading: NVActivityIndicatorView!
    @IBOutlet weak var btnPlay: UIButton!
    var urlMovie: String?
    var subURL: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewLoading.startAnimating()
        viewLoading.type = .ballRotate
        viewLoading.color = UIColor.init(hex: "FFD130")
        print(imgPreview.frame.origin.x)
    }

    @IBAction func play(_ sender: Any) {
        guard let urlMovie = urlMovie else {return}
        guard let subURL = subURL else {return}
        let moviePlayer = AVPlayerViewController()
        moviePlayer.player = AVPlayer(url: URL(string: urlMovie)!)
        UIApplication.getTopViewController()?.present(moviePlayer, animated: true, completion: nil)
        if let subPath = getURLSub() {
            moviePlayer.addSubtitles().open(fileFromRemote: subPath, encoding: String.Encoding.utf8)
        }
        moviePlayer.subtitleLabel?.textColor = UIColor.init(hex: "FFD130")
        moviePlayer.player?.play()
    }
    
    func getURLSub() -> URL? {
        let fileManager = FileManager.default
        let path = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(SUBTITLE_URL)
        return path
    }

}
