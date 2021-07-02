//
//  ActorDetailCell.swift
//  MovieApp
//
//  Created by Tuan Le on 20/06/2021.
//

import UIKit

class ActorDetailCell: UICollectionViewCell {

    @IBOutlet weak var collectionActor: UICollectionView!
    let CELL = "ActorCell"
    var dataActor: ActorMovie?
    let apiHelper = RepositoryServiceLocator.shared.apiHelper
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }
    
    func configUI() {
        collectionActor.delegate = self
        collectionActor.dataSource = self
        collectionActor.register(UINib(nibName: CELL, bundle: nil), forCellWithReuseIdentifier: CELL)
    }

}
extension ActorDetailCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataActor?.cast.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionActor.dequeueReusableCell(withReuseIdentifier: CELL, for: indexPath) as? ActorCell
        if let dataActor = dataActor {
            cell?.lblNameActor.text = dataActor.cast[indexPath.row].name
            if let path = dataActor.cast[indexPath.row].profilePath {
                let width = WidthImage.original
                let url = URL(string: DEFAULT_URL_IMG+width.rawValue+"/\(path)")
                cell?.imgActor.sd_setImage(with: url!, completed: nil)
            }
        }
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthCell = collectionActor.frame.width/3
        let heightCell = collectionActor.frame.height
        return CGSize(width: widthCell, height: heightCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
