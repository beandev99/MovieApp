//
//  DetailMovieVC.swift
//  MovieApp
//
//  Created by Tuan Le on 12/06/2021.
//

import UIKit

class DetailMovieVC: UIViewController {
    
    @IBOutlet weak var collectionDetail: UICollectionView!
    var dataMovie: Result?
    var delegate: BackDelegate?
    let HEADER_CELL = "HeaderDetailCell"
    let INFOR_CELL = "InforDetailCell"
    let DESC_CELL = "DescDetailCell"
    let apiHelper = RepositoryServiceLocator.shared.apiHelper
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupData()
    }
    
    func setupUI() {
        collectionDetail.delegate = self
        collectionDetail.dataSource = self
        collectionDetail.register(UINib(nibName: HEADER_CELL, bundle: nil), forCellWithReuseIdentifier: HEADER_CELL)
        collectionDetail.register(UINib(nibName: INFOR_CELL, bundle: nil), forCellWithReuseIdentifier: INFOR_CELL)
        collectionDetail.register(UINib(nibName: DESC_CELL, bundle: nil), forCellWithReuseIdentifier: DESC_CELL)
        collectionDetail.showsVerticalScrollIndicator = false
    }
    
    func setupData() {
        collectionDetail.reloadData()
        apiHelper.getURLTrailerMovie(idMovie: (dataMovie?.id)!) { isSuccess , data, error in
            if isSuccess {
                print("🌲: \(data)")
            }
            else {
                print("🌲: error")
            }
        }
    }
    
    @IBAction func back(_ sender: Any) {
        delegate?.back()
    }
    
}
extension DetailMovieVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            let cell = collectionDetail.dequeueReusableCell(withReuseIdentifier: HEADER_CELL, for: indexPath) as? HeaderDetailCell
            if let backdropPath = dataMovie?.backdropPath {
                apiHelper.getImage(pathImg: backdropPath, width: .w_500, completed: { isSuccess, img in
                    if isSuccess {
                        if let img = img {
                            cell?.imgPreview.image = img
                            cell?.viewLoading.isHidden = true
                            cell?.btnPlay.isHidden = false
                        }
                    }
                })
            }
            return cell!
        case 1:
            let cell = collectionDetail.dequeueReusableCell(withReuseIdentifier: INFOR_CELL, for: indexPath) as? InforDetailCell
            cell?.lblName.text = dataMovie?.name ?? dataMovie?.originalName ?? dataMovie?.title ?? dataMovie?.originalTitle
            var txtInfor = ""
            if let year = dataMovie?.releaseDate?.split(separator: "-").first {
                txtInfor.append("\(year) | ")
            }
            cell?.lblInfor.text = "\(dataMovie?.releaseDate?.split(separator: "-").first) | \(dataMovie?.mediaType)"
            if let vote = dataMovie?.voteAverage {
                cell?.lblRate.text = "\(vote)"
            }
            return cell!
        case 2:
            let cell = collectionDetail.dequeueReusableCell(withReuseIdentifier: DESC_CELL, for: indexPath) as? DescDetailCell
            cell?.lblOverview.text = dataMovie?.overview ?? ""
            return cell!
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthCell = collectionDetail.frame.width
        var heightCell = CGFloat(0)
        switch indexPath.row {
        case 0:
            heightCell = collectionDetail.frame.height/3
        case 1:
            heightCell = collectionDetail.frame.height/4
        case 2:
            heightCell = collectionDetail.frame.height/1.2
        default:
            break
        }
        return CGSize(width: widthCell, height: heightCell)
    }
    
}
