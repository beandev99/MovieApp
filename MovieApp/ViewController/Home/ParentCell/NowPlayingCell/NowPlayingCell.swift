//
//  NowplayingCell.swift
//  MovieApp
//
//  Created by Tuan Le on 08/06/2021.
//

import UIKit
import SDWebImage

class NowPlayingCell: UICollectionViewCell {

    @IBOutlet weak var collectionNowPlaying: UICollectionView!
    let CHILD_CELL = "NowPlayingChildCell"
    var dataNowPlaying: MovieModel?
    var index: Int?
    var delegate: MoreDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        collectionNowPlaying.delegate = self
        collectionNowPlaying.dataSource = self
        collectionNowPlaying.register(UINib(nibName: CHILD_CELL, bundle: nil), forCellWithReuseIdentifier: CHILD_CELL)
        collectionNowPlaying.showsHorizontalScrollIndicator = false
    }
    
    @IBAction func more(_ sender: Any) {
        if let index = index {
            delegate?.more(index: index)
        }
    }
    
}
extension NowPlayingCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataNowPlaying?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionNowPlaying.dequeueReusableCell(withReuseIdentifier: CHILD_CELL, for: indexPath) as? NowPlayingChildCell {
            if let dataNowPlaying = dataNowPlaying {
                if let backdropPath = dataNowPlaying.results[indexPath.row].backdropPath {
                    let url = URL(string: DEFAULT_URL_IMG_500+backdropPath)
                    cell.imgNowPlaying.sd_setImage(with: url, completed: nil)

                }
                cell.lblNameMovie.text = dataNowPlaying.results[indexPath.row].originalTitle
                cell.lblYear.text = dataNowPlaying.results[indexPath.row].releaseDate

            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthCell = collectionNowPlaying.frame.width - 30
        let heightCell = collectionNowPlaying.frame.height
        return CGSize(width: widthCell, height: heightCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let result = dataNowPlaying?.results[indexPath.row] else {return}
        delegate?.indexSelect(movie: result)
    }
}
