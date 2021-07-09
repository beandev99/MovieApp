//
//  SearchVC.swift
//  MovieApp
//
//  Created by Tuan Le on 08/06/2021.
//

import UIKit
import NVActivityIndicatorView

class SearchVC: UIViewController {

    @IBOutlet weak var tftSearch: UITextField!
    @IBOutlet weak var lblSearch: UILabel!
    @IBOutlet weak var collectionResultSearch: UICollectionView!
    let cell = "ResultsSearchCell"
    let apiHelper = RepositoryServiceLocator.shared.apiHelper
    var pageLoading: Int = 1
    var dataQuery: MovieModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    func configUI() {
        collectionResultSearch.delegate = self
        collectionResultSearch.dataSource = self
        collectionResultSearch.register(UINib(nibName: cell, bundle: nil), forCellWithReuseIdentifier: cell)
    }

    @IBAction func search(_ sender: Any) {
        guard let query = tftSearch.text else {return}
        dataQuery?.results.removeAll()
        apiHelper.search(query: query, page: pageLoading) { isSuccess, data in
            runOnMainThread {
                self.dataQuery = data
                self.collectionResultSearch.reloadData()
            }
        }
    }
    
}
extension SearchVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataQuery?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionResultSearch.dequeueReusableCell(withReuseIdentifier: cell, for: indexPath) as? ResultsSearchCell
        guard let dataQuery = dataQuery else {return cell!}
        guard let backdropPath = dataQuery.results[indexPath.row].posterPath else {return cell!}
        let urlImg = URL(string: DEFAULT_URL_IMG_500 + backdropPath)
        cell?.imgMovie.sd_setImage(with: urlImg, completed: { img, err, cache, url in
            cell?.imgMovie.image = img
            cell?.viewLoading.isHidden = true
        })
        cell?.imgMovie.layer.cornerRadius = 10
        cell?.lblName.text = dataQuery.results[indexPath.row].name ?? dataQuery.results[indexPath.row].title ?? dataQuery.results[indexPath.row].originalName ?? dataQuery.results[indexPath.row].originalTitle
        cell?.lblDesc.text = dataQuery.results[indexPath.row].overview
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthCell = collectionResultSearch.frame.width/2 - 5
        let heightCell = collectionResultSearch.frame.height/2
        return CGSize(width: widthCell, height: heightCell)
    }
}

