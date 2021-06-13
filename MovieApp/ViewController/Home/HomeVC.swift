//
//  HomeVC.swift
//  MovieApp
//
//  Created by Tuan Le on 08/06/2021.
//

import UIKit

class HomeVC: UIViewController {
    @IBOutlet weak var collectionHome: UICollectionView!
    let titleHeader: [String] = ["Recommend", "Trending", "Popular", "Upcomming", "Now playing"]
    let TRENDING_CELL = "TrendingCell"
    let TOPRATED_CELL = "TopRatedCell"
    let POPULAR_CELL = "PopularCell"
    let UPCOMMING_CELL = "UpcommingCell"
    let NOWPLAYING_CELL = "NowPlayingCell"
    let apiHelper = RepositoryServiceLocator.shared.apiHelper
    var delegate: CategoryDelegate?
    
    var dataMovieTrending: MovieModel?
    var dataMovieTopRated: MovieModel?
    var dataMoviePopular: MovieModel?
    var dataMovieUpComming: MovieModel?
    var dataMovieNowPlaying: MovieModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupUI()
    }
    
    func setupUI() {
        collectionHome.delegate = self
        collectionHome.dataSource = self
        collectionHome.showsVerticalScrollIndicator = false
        collectionHome.register(UINib(nibName: TOPRATED_CELL, bundle: nil), forCellWithReuseIdentifier: TOPRATED_CELL)
        collectionHome.register(UINib(nibName: TRENDING_CELL, bundle: nil), forCellWithReuseIdentifier: TRENDING_CELL)
        collectionHome.register(UINib(nibName: POPULAR_CELL, bundle: nil), forCellWithReuseIdentifier: POPULAR_CELL)
        collectionHome.register(UINib(nibName: UPCOMMING_CELL, bundle: nil), forCellWithReuseIdentifier: UPCOMMING_CELL)
        collectionHome.register(UINib(nibName: NOWPLAYING_CELL, bundle: nil), forCellWithReuseIdentifier: NOWPLAYING_CELL)
    }
    
    func setupData() {
        getDataTrending()
        getDataTopRated()
        getDataPopular()
        getDataUpcomming()
        getDataNowPlaying()
    }
    
}
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            if let cell = collectionHome.dequeueReusableCell(withReuseIdentifier: TRENDING_CELL, for: indexPath) as? TrendingCell {
                cell.delegate = self
                cell.index = indexPath.row
                if let dataMovie = dataMovieTrending {
                    cell.dataTrending = dataMovie
                    cell.collectionTrending.reloadData()
                }
                return cell
            }
        case 1:
            if let cell = collectionHome.dequeueReusableCell(withReuseIdentifier: TOPRATED_CELL, for: indexPath) as? TopRatedCell {
                cell.delegate = self
                cell.index = indexPath.row
                if let dataMovieTopRated = dataMovieTopRated {
                    cell.dataTopRated = dataMovieTopRated
                    cell.collectionTopRated.reloadData()
                }
                return cell
            }
        case 2:
            if let cell = collectionHome.dequeueReusableCell(withReuseIdentifier: POPULAR_CELL, for: indexPath) as? PopularCell {
                cell.delegate = self
                cell.index = indexPath.row
                if let dataPopolar = dataMoviePopular {
                    cell.dataPopular = dataPopolar
                    cell.collectionPopular.reloadData()
                }
                return cell
            }
        case 3:
            if let cell = collectionHome.dequeueReusableCell(withReuseIdentifier: UPCOMMING_CELL, for: indexPath) as? UpcommingCell {
                cell.index = indexPath.row
                cell.delegate = self
                if let dataMovieUpComming = dataMovieUpComming {
                    cell.dataUpComming = dataMovieUpComming
                    cell.collectionUpcomming.reloadData()
                }
                return cell
            }
        case 4:
            if let cell = collectionHome.dequeueReusableCell(withReuseIdentifier: NOWPLAYING_CELL, for: indexPath) as? NowPlayingCell {
                cell.delegate = self
                cell.index = indexPath.row
                if let dataMovieNowPlaying = dataMovieNowPlaying {
                    cell.dataNowPlaying = dataMovieUpComming
                    cell.collectionNowPlaying.reloadData()
                }
                return cell
            }
        default:
            break
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthCell = collectionHome.frame.width
        var heightCell: CGFloat = 0
        switch indexPath.row {
        case 0:
            heightCell = collectionHome.frame.height/2
        case 1:
            heightCell = collectionHome.frame.height/3
        case 2:
            heightCell = collectionHome.frame.height/2.5
        case 3:
            heightCell = collectionHome.frame.height/2.5
        case 4:
            heightCell = collectionHome.frame.height/2.4
        default:
            break
        }
        return CGSize(width: widthCell, height: heightCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
    }
    
}

extension HomeVC {
    func getDataTopRated() {
        apiHelper.getDataMovie(type: .toprated, page: nil) { isSuccess, dataMovie, error in
            if isSuccess {
                guard let dataMovie = dataMovie else {return}
                runOnMainThread { [self] in
                    dataMovieTopRated = dataMovie
                    collectionHome.reloadData()
                }
            }
            else {
                print("🎄 error: \(error)")
            }
        }
    }
    
    func getDataTrending() {
        apiHelper.getDataMovie(type: .trending, page: nil) { isSuccess, dataMovie, error in
            if isSuccess {
                guard let dataMovie = dataMovie else {return}
                runOnMainThread { [self] in
                    dataMovieTrending = dataMovie
                    collectionHome.reloadData()
                }
            }
        }
    }
    
    func getDataPopular() {
        apiHelper.getDataMovie(type: .popular, page: nil) { isSuccess, dataMovie, error in
            if isSuccess {
                guard let dataMovie = dataMovie else {return}
                runOnMainThread { [self] in
                    dataMoviePopular = dataMovie
                    collectionHome.reloadData()
                }
            }
        }
    }
    
    func getDataUpcomming() {
        apiHelper.getDataMovie(type: .upcoming, page: nil) { isSuccess, dataMovie, error in
            if isSuccess {
                guard let dataMovie = dataMovie else {return}
                runOnMainThread { [self] in
                    dataMovieUpComming = dataMovie
                    collectionHome.reloadData()
                }
            }
        }
    }
    
    func getDataNowPlaying() {
        apiHelper.getDataMovie(type: .nowplaying, page: nil) { isSuccess, dataMovie, error in
            if isSuccess {
                guard let dataMovie = dataMovie else {return}
                runOnMainThread { [self] in
                    dataMovieNowPlaying = dataMovie
                    collectionHome.reloadData()
                }
            }
        }
    }
}
extension HomeVC: MoreDelegate {
    
    func indexSelect(movie: Result) {
        delegate?.movieDetail(movie: movie)
    }
    
    func more(index: Int) {
        switch index {
        case 0:
            delegate?.category(category: .trending, data: dataMovieTrending)
        case 1:
            delegate?.category(category: .toprated, data: dataMovieTopRated)
        case 2:
            delegate?.category(category: .popular, data: dataMoviePopular)
        case 3:
            delegate?.category(category: .upcoming, data: dataMovieUpComming)
        case 4:
            delegate?.category(category: .nowplaying, data: dataMovieNowPlaying)
        default:
            print("😝: nothing")
        }
    }

}

protocol CategoryDelegate {
    func category(category: TypeCategory, data: MovieModel?)
    func movieDetail(movie: Result)
}
