//
//  TrendingCell.swift
//  MovieApp
//
//  Created by Tuan Le on 08/06/2021.
//

import UIKit
import SDWebImage

class TopRatedCell: UICollectionViewCell {

    @IBOutlet weak var collectionTopRated: UICollectionView!
    let CHILD_CELL = "TopRatedChildCell"
    var dataTopRated: MovieModel?
    var index: Int?
    var delegate: MoreDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        collectionTopRated.delegate = self
        collectionTopRated.dataSource = self
        collectionTopRated.register(UINib(nibName: CHILD_CELL, bundle: nil), forCellWithReuseIdentifier: CHILD_CELL)
        collectionTopRated.showsHorizontalScrollIndicator = false
    }

    @IBAction func more(_ sender: Any) {
        if let index = index {
            delegate?.more(index: index)
        }
    }
}
extension TopRatedCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataTopRated?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionTopRated.dequeueReusableCell(withReuseIdentifier: CHILD_CELL, for: indexPath) as? TopRatedChildCell {
            if let dataTopRated = dataTopRated {
                if let backdropPath = dataTopRated.results[indexPath.row].backdropPath {
                    let url = URL(string: DEFAULT_URL_IMG_500+backdropPath)
                    cell.imgTrending.sd_setImage(with: url, completed: nil)
                }
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthCell = collectionTopRated.frame.width/2.7
        let heightCell = collectionTopRated.frame.height
        return CGSize(width: widthCell, height: heightCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let result = dataTopRated?.results[indexPath.row] else {return}
        delegate?.indexSelect(movie: result)
    }
    
}
