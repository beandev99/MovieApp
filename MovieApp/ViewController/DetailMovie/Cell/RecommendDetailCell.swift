//
//  RecommendDetailCell.swift
//  MovieApp
//
//  Created by Tuan Le on 14/06/2021.
//

import UIKit

class RecommendDetailCell: UICollectionViewCell {

    @IBOutlet weak var collectionRecomend: UICollectionView!
    var dataMovie: MovieModel?
    let CELL = "RecomendDetailCell"
    let apiHelper = RepositoryServiceLocator.shared.apiHelper
    var delegate: MovieRecomendDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }
    
    func configUI() {
        collectionRecomend.delegate = self
        collectionRecomend.dataSource = self
        collectionRecomend.register(UINib(nibName: CELL, bundle: nil), forCellWithReuseIdentifier: CELL)
        collectionRecomend.showsHorizontalScrollIndicator = false
    }

}

extension RecommendDetailCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataMovie?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionRecomend.dequeueReusableCell(withReuseIdentifier: CELL, for: indexPath) as? RecomendDetailCell
        if let dataMovie = dataMovie {
            cell?.lblNameMovie.text = dataMovie.results[indexPath.row].name ?? dataMovie.results[indexPath.row].title
            if let backdropPath = dataMovie.results[indexPath.row].backdropPath {
                apiHelper.getImage(pathImg: backdropPath, width: .w_400) { isSuccess , image in
                    if isSuccess {
                        cell?.imgMovie.image = image
                        cell?.imgMovie.layer.cornerRadius = 10
                    }
                }
            }
        }
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthCell = collectionRecomend.frame.width/2.5 - 10
        let heightCell = collectionRecomend.frame.height
        return CGSize(width: widthCell, height: heightCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let dataMovie = dataMovie {
            delegate?.selectMovie(result: dataMovie.results[indexPath.row])
        }
    }
    
}

protocol MovieRecomendDelegate {
    func selectMovie(result: Result?)
}
