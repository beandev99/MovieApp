//
//  TrendingCell.swift
//  MovieApp
//
//  Created by Tuan Le on 08/06/2021.
//

import UIKit
import SDWebImage

class TrendingCell: UICollectionViewCell {

    @IBOutlet weak var collectionTrending: UICollectionView!
    let CHILD_CELL = "TrendingChildCell"
    var dataTrending: MovieModel?
    var delegate: MoreDelegate?
    var index: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        collectionTrending.delegate = self
        collectionTrending.dataSource = self
        collectionTrending.register(UINib(nibName: CHILD_CELL, bundle: nil), forCellWithReuseIdentifier: CHILD_CELL)
        collectionTrending.showsHorizontalScrollIndicator = false
    }
    
    func setupData() {
        
    }

    @IBAction func more(_ sender: Any) {
        if let index = index {
            delegate?.more(index: index)
        }
    }
}
extension TrendingCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataTrending?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionTrending.dequeueReusableCell(withReuseIdentifier: CHILD_CELL, for: indexPath) as? TrendingChildCell {
            if let dataTrending = dataTrending {
                if let backdropPath = dataTrending.results[indexPath.row].backdropPath {
                    let url = URL(string: DEFAULT_URL_IMG_500+backdropPath)
                    cell.imgRecommend.sd_setImage(with: url, completed: nil)
                }
            }

            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthCell = collectionTrending.frame.width - 30
        let heightCell = collectionTrending.frame.height
        return CGSize(width: widthCell, height: heightCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let result = dataTrending?.results[indexPath.row] else {return}
        delegate?.indexSelect(movie: result)
    }
}

protocol MoreDelegate {
    func more(index: Int)
    func indexSelect(movie: Result)
}

