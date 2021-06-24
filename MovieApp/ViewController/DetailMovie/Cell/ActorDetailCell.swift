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
                apiHelper.getImage(pathImg: path, width: .w_400) { isSuccess, img in
                    if isSuccess {
                        cell?.imgActor.image = img
                    }
                }
            }
  
        }
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthCell = collectionActor.frame.width/3
        let heightCell = collectionActor.frame.height
        return CGSize(width: widthCell, height: heightCell)
    }
    
    
}
