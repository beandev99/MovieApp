//
//  UpcommingCell.swift
//  MovieApp
//
//  Created by Tuan Le on 08/06/2021.
//

import UIKit
import SDWebImage

class UpcommingCell: UICollectionViewCell {

    @IBOutlet weak var collectionUpcomming: UICollectionView!
    let CHILD_CELL = "UpcommingChildCell"
    var dataUpComming: MovieModel?
    var index: Int?
    var delegate: MoreDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        collectionUpcomming.delegate = self
        collectionUpcomming.dataSource = self
        collectionUpcomming.register(UINib(nibName: CHILD_CELL, bundle: nil), forCellWithReuseIdentifier: CHILD_CELL)
    }

    @IBAction func more(_ sender: Any) {
        if let index = index {
            delegate?.more(index: index)
        }
    }
}
extension UpcommingCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataUpComming?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionUpcomming.dequeueReusableCell(withReuseIdentifier: CHILD_CELL, for: indexPath) as? UpcommingChildCell {
            if let dataUpComming = dataUpComming {
                if let backdropPath = dataUpComming.results[indexPath.row].backdropPath {
                    let url = URL(string: DEFAULT_URL_IMG_500+backdropPath)
                    cell.imgUpcomming.sd_setImage(with: url, completed: nil)
                }
                cell.lblName.text = dataUpComming.results[indexPath.row].originalTitle
                cell.lblDesc.text = dataUpComming.results[indexPath.row].overview
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widhthCell = collectionUpcomming.frame.width/2.8
        let heightCell = collectionUpcomming.frame.height
        return CGSize(width: widhthCell, height: heightCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let result = dataUpComming?.results[indexPath.row] else {return}
        delegate?.indexSelect(movie: result)
    }
}
