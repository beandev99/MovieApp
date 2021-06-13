//
//  CategoryMovieVC.swift
//  MovieApp
//
//  Created by Tuan Le on 09/06/2021.
//

import UIKit

class CategoryMovieVC: UIViewController {
    
    @IBOutlet weak var lblNameCategory: UILabel!
    @IBOutlet weak var collectionViewCategory: UICollectionView!
    let CATEGORY_CELL = "CategoryMovieCell"
    var nameCategory: TypeCategory?
    var dataMovie: MovieModel?
    var delegate: BackDelegate?
    let apiHelper = RepositoryServiceLocator.shared.apiHelper
    var indexPage = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func back(_ sender: Any) {
        delegate?.back()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupData()
    }
    
    func setupUI() {
        collectionViewCategory.delegate = self
        collectionViewCategory.dataSource = self
        collectionViewCategory.register(UINib(nibName: CATEGORY_CELL, bundle: nil), forCellWithReuseIdentifier: CATEGORY_CELL)
        collectionViewCategory.showsVerticalScrollIndicator = true
    }
    
    func setupData() {
        lblNameCategory.text = nameCategory?.rawValue
        collectionViewCategory.reloadData()
        collectionViewCategory.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredVertically, animated: false)
        loadMoreData()
    }
    
}
extension CategoryMovieVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataMovie?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionViewCategory.dequeueReusableCell(withReuseIdentifier: CATEGORY_CELL, for: indexPath) as? CategoryMovieCell {
            cell.lblName.text = dataMovie?.results[indexPath.row].title
            cell.lblDesc.text = dataMovie?.results[indexPath.row].overview
            if let backdropPath = dataMovie?.results[indexPath.row].backdropPath {
                let url = URL(string: DEFAULT_URL_IMG_500+backdropPath)
                cell.imgMovie.sd_setImage(with: url, completed: nil)
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthCell = collectionViewCategory.frame.width/2 - 10
        let heightCell = collectionViewCategory.frame.height/2.8
        return CGSize(width: widthCell, height: heightCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = collectionViewCategory.frame.size.height
        let contentYoffset = collectionViewCategory.contentOffset.y
        let distanceFromBottom = collectionViewCategory.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            if nameCategory == .trending {
                return
            }
            collectionViewCategory.reloadData()
        }

    }
    
    func loadMoreData() {
        guard let totalPages = dataMovie?.totalPages else {return}
        for i in indexPage..<totalPages {
            apiHelper.getDataMovie(type: nameCategory!, page: i) { [self] isSuccess, data, error in
                if isSuccess {
                    dataMovie?.results+=data?.results ?? []
                    dataMovie?.page = data!.page
                    indexPage += 1
                }
            }
        }
    }
    
}

protocol BackDelegate {
    func back()
}
