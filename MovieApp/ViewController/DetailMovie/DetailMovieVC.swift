//
//  DetailMovieVC.swift
//  MovieApp
//
//  Created by Tuan Le on 12/06/2021.
//

import UIKit
import AVKit

class DetailMovieVC: UIViewController {
    
    @IBOutlet weak var collectionDetail: UICollectionView!
    var dataMovie: Result?
    var delegate: BackDelegate?
    let HEADER_CELL = "HeaderDetailCell"
    let INFOR_CELL = "InforDetailCell"
    let DESC_CELL = "DescDetailCell"
    let TRAILER_CELL = "TrailerDetailCell"
    let RECOMMEND_CELL = "RecommendDetailCell"
    let ACTOR_CELL = "ActorDetailCell"
    let apiHelper = RepositoryServiceLocator.shared.apiHelper
    var dataTrailer: TrailerModel?
    var pageLoading: Int? = nil
    var dataRecommend: MovieModel?
    var dataLinkMovie: LinkMovie?
    var dataActor: ActorMovie?
    
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
        collectionDetail.register(UINib(nibName: TRAILER_CELL, bundle: nil), forCellWithReuseIdentifier: TRAILER_CELL)
        collectionDetail.register(UINib(nibName: RECOMMEND_CELL, bundle: nil), forCellWithReuseIdentifier: RECOMMEND_CELL)
        collectionDetail.register(UINib(nibName: ACTOR_CELL, bundle: nil), forCellWithReuseIdentifier: ACTOR_CELL)
        collectionDetail.showsVerticalScrollIndicator = false
    }
    
    func setupData() {
        apiHelper.getRecommendMovie(idMovie: (dataMovie?.id)!, pageLoading: &pageLoading) { isSuccess, data in
            if isSuccess {
                runOnMainThread {
                    self.dataRecommend = data
                    self.collectionDetail.reloadData()
                }
            }
            else {
                print("😸: error ")
            }
        }
        apiHelper.getURLTrailerMovie(idMovie: (dataMovie?.id)!) { isSuccess , data, error in
            if isSuccess {
                guard let data = data else {
                    return
                }
                runOnMainThread {
                    self.dataTrailer = data
                    self.collectionDetail.reloadData()
                }
            }
            else {
                print("🌲: error")
            }
        }
        
        apiHelper.getLinkMovie(idMovie: (dataMovie?.id)!) { isSuccess, data in
            if isSuccess {
                self.dataLinkMovie = data
                if let urlSub = self.dataLinkMovie?.data.linkSub {
                    self.apiHelper.downloadSub(url: urlSub) { isSuccess in
                        if isSuccess {
                            runOnMainThread {
                                self.collectionDetail.reloadData()
                            }
                        }
                    }
                }
                else {
                    runOnMainThread {
                        self.collectionDetail.reloadData()
                    }
                }
            }
            else {
                print("👻 ko get dc data")
            }
        }
        getDataActor()
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
extension DetailMovieVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
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
                if let dataLinkMovie = dataLinkMovie {
                    cell?.btnPlay.isHidden = false
                    cell?.urlMovie = dataLinkMovie.data.url
                    cell?.subURL = dataLinkMovie.data.linkSub
                }
                else {
                    cell?.btnPlay.isHidden = true
                }
            }
            return cell!
        case 1:
            let cell = collectionDetail.dequeueReusableCell(withReuseIdentifier: INFOR_CELL, for: indexPath) as? InforDetailCell
            cell?.lblName.text = dataMovie?.name ?? dataMovie?.originalName ?? dataMovie?.title ?? dataMovie?.originalTitle
            var txtInfor = ""
            if let year = dataMovie?.releaseDate?.split(separator: "-").first {
                txtInfor.append("\(year) | ")
            }
            let yearRelease = dataMovie?.releaseDate
            cell?.lblInfor.text = yearRelease
            if let vote = dataMovie?.voteAverage {
                cell?.lblRate.text = "\(vote)"
            }
            return cell!
        case 2:
            let cell = collectionDetail.dequeueReusableCell(withReuseIdentifier: DESC_CELL, for: indexPath) as? DescDetailCell
            cell?.lblOverview.text = dataMovie?.overview ?? ""
            return cell!
        case 3:
            let cell = collectionDetail.dequeueReusableCell(withReuseIdentifier: TRAILER_CELL, for: indexPath) as? TrailerDetailCell
            if let dataTrailer = dataTrailer {
                for i in dataTrailer.results {
                    cell?.setupPlayer(id: i.key)
                    break
                }
            }
            return cell!
        case 4:
            let cell = collectionDetail.dequeueReusableCell(withReuseIdentifier: ACTOR_CELL, for: indexPath) as? ActorDetailCell
            if let dataActor = dataActor {
                cell?.dataActor = dataActor
                cell?.collectionActor.reloadData()
            }
            return cell!
        case 5:
            let cell = collectionDetail.dequeueReusableCell(withReuseIdentifier: RECOMMEND_CELL, for: indexPath) as? RecommendDetailCell
            if let dataRecommend = dataRecommend {
                cell?.dataMovie = dataRecommend
                cell?.collectionRecomend.reloadData()
                cell?.delegate = self
            }
            return cell!
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthCell = collectionDetail.frame.width
        var heightCell = CGFloat(0)
        switch indexPath.section {
        case 0:
            heightCell = collectionDetail.frame.height/3
        case 1:
            heightCell = collectionDetail.frame.height/4
        case 2:
            if let dataMovie = dataMovie {
                if let overView = dataMovie.overview {
                    heightCell = heightForView(text: overView, font: .systemFont(ofSize: 16), width: collectionDetail.frame.width) + 50
                }
            }
        case 3:
            heightCell = collectionDetail.frame.height/2.8
        case 4:
            heightCell = collectionDetail.frame.height/2.8
        case 5:
            if let dataRecommend = dataRecommend {
                if dataRecommend.results.isEmpty {
                    heightCell = 0
                }
                else {
                    heightCell = collectionDetail.frame.height/2.5
                }
            }
            else {
                heightCell = 0
            }
        default:
            break
        }
        return CGSize(width: widthCell, height: heightCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section == 3 {
            return 0
        }
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 5 {
            return UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        }
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
    
}

extension DetailMovieVC: MovieRecomendDelegate {
    
    func selectMovie(result: Result?) {
        let vc = DetailMovieVC()
        vc.dataMovie = result
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
}
extension DetailMovieVC {
    func getDataActor() {
        apiHelper.getActorMovie(idMovie: (dataMovie?.id)!) { isSuccess, data  in
            runOnMainThread {
                self.dataActor = data
                let cell = self.collectionDetail.cellForItem(at: IndexPath(row: 0, section: 4)) as? ActorDetailCell
                cell?.dataActor = data
                cell?.collectionActor.reloadData()
            }
        }
    }
}
