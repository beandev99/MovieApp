//
//  DetailActorVC.swift
//  MovieApp
//
//  Created by Tuan Le on 02/07/2021.
//

import UIKit

class DetailActorVC: UIViewController {

    @IBOutlet weak var collectionDetailActor: UICollectionView!
    let apiHelper = RepositoryServiceLocator.shared.apiHelper
    var personID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configData()
        configUI()
    }
    
    func configUI() {
//        collectionDetailActor.delegate = self
//        collectionDetailActor.dataSource = self
    }
    
    func configData() {
        guard let personID = personID else {return}
        apiHelper.getDetailActor(idActor: personID) { isSuccess, dataActor in
            
        }
    }
    
}
//ACTION
extension DetailActorVC {
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
//extension DetailActorVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        <#code#>
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
//    
//    
//}
