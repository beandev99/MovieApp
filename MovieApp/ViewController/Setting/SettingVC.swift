//
//  SettingVC.swift
//  MovieApp
//
//  Created by Tuan Le on 08/06/2021.
//

import UIKit

class SettingVC: UIViewController {

    @IBOutlet weak var collectionSetting: UICollectionView!
    let INFOR_CELL = "InforSettingCell"
    let SETTING_CELL = "SettingCell"
    let arrTitleSettings = ["Account Settings", "App Settings", "Rate us on Appstore", "Inbox", "Sign out"]
    var imgSettings = ["ic-account-settins", "ic-app-settings", "ic-rate-app", "ic-inbox", "ic-sign-out"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        // Do any additional setup after loading the view.
    }
    
    func configUI() {
        collectionSetting.delegate = self
        collectionSetting.dataSource = self
        collectionSetting.register(UINib(nibName: INFOR_CELL, bundle: nil), forCellWithReuseIdentifier: INFOR_CELL)
        collectionSetting.register(UINib(nibName: SETTING_CELL, bundle: nil), forCellWithReuseIdentifier: SETTING_CELL)
        collectionSetting.showsVerticalScrollIndicator = false
    }

}
extension SettingVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionSetting.dequeueReusableCell(withReuseIdentifier: INFOR_CELL, for: indexPath) as? InforSettingCell
            return cell!
        }
        else {
            let cell = collectionSetting.dequeueReusableCell(withReuseIdentifier: SETTING_CELL, for: indexPath) as? SettingCell
            cell?.imgSetting.image = UIImage(named: imgSettings[indexPath.row-1])
            cell?.lblNameSetting.text = arrTitleSettings[indexPath.row-1]
            return cell!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthCell = collectionSetting.frame.width
        var heightCell = CGFloat(0)
        if indexPath.row == 0 {
            heightCell = collectionSetting.frame.height/2.5
            return CGSize(width: widthCell, height: heightCell)
        }
        else {
            heightCell = collectionSetting.frame.height/12
            return CGSize(width: widthCell, height: heightCell)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
}
