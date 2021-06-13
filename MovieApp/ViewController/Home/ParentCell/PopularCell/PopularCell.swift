//
//  PopularCell.swift
//  MovieApp
//
//  Created by Tuan Le on 08/06/2021.
//

import UIKit

class PopularCell: UICollectionViewCell {

    @IBOutlet weak var collectionPopular: UICollectionView!
    let CHILD_CELL = "PopularChildCell"
    var dataPopular: MovieModel?
    var index: Int?
    var delegate: MoreDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        collectionPopular.delegate = self
        collectionPopular.dataSource = self
        collectionPopular.register(UINib(nibName: CHILD_CELL, bundle: nil), forCellWithReuseIdentifier: CHILD_CELL)
    }
    
    @IBAction func more(_ sender: Any) {
        if let index = index {
            delegate?.more(index: index)
        }
    }
    

}
extension PopularCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataPopular?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionPopular.dequeueReusableCell(withReuseIdentifier: CHILD_CELL, for: indexPath) as? PopularChildCell {
            if let dataPopular = dataPopular {
                if let backdropPath = dataPopular.results[indexPath.row].backdropPath {
                    let url = URL(string: DEFAULT_URL_IMG_500+backdropPath)!
                    cell.imgPopular.sd_setImage(with: url, completed: nil)
                }
                cell.lblName.text = dataPopular.results[indexPath.row].originalTitle
                cell.lblDesc.text = dataPopular.results[indexPath.row].overview
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthCell = collectionPopular.frame.width/1.7
        let heightCell = collectionPopular.frame.height
        return CGSize(width: widthCell, height: heightCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let result = dataPopular?.results[indexPath.row] else {return}
        delegate?.indexSelect(movie: result)
    }
    
}
