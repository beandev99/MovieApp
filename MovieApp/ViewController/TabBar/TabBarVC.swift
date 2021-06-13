//
//  TabBarVC.swift
//  MovieApp
//
//  Created by Tuan Le on 08/06/2021.
//

import UIKit

class TabBarVC: UIViewController {
    
    var listVC: [UIViewController] = []
    var numberChildInVC:Int = 0
    @IBOutlet weak var childView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        loadViewTab(child: listVC[0])
    }
    
    func setupVC() {
        let homeVC = HomeVC()
        let searchVC = SearchVC()
        let folderVC = FolderVC()
        let settingVC = SettingVC()
        let categoryVC = CategoryMovieVC()
        homeVC.delegate = self
        categoryVC.delegate = self
        let detailVC = DetailMovieVC()
        detailVC.delegate = self
        listVC = [homeVC, searchVC, folderVC, settingVC, categoryVC, detailVC]
    }
    
    func loadViewTab(child:UIViewController){
        listVC[numberChildInVC].willMove(toParent: nil)
        listVC[numberChildInVC].view.removeFromSuperview()
        listVC[numberChildInVC].removeFromParent()
        child.view.frame = childView.frame
        childView.addSubview(child.view)
        self.addChild(child)
        child.didMove(toParent: self)
    }
    
    @IBAction func openHome(_ sender: Any) {
        if numberChildInVC != 0 {
            loadViewTab(child: listVC[0])
        }
        numberChildInVC = 0
    }
    
    @IBAction func openSearch(_ sender: Any) {
        if numberChildInVC != 1 {
            loadViewTab(child: listVC[1])
        }
        numberChildInVC = 1
    }
    
    @IBAction func openFolder(_ sender: Any) {
        if numberChildInVC != 2 {
            loadViewTab(child: listVC[2])
        }
        numberChildInVC = 2
    }
    
    @IBAction func openSetting(_ sender: Any) {
        if numberChildInVC != 3 {
            loadViewTab(child: listVC[3])
        }
        numberChildInVC = 3
    }
}
extension TabBarVC: CategoryDelegate {
    func movieDetail(movie: Result) {
        if numberChildInVC != 5 {
            let vc = (listVC[5] as? DetailMovieVC)
            vc?.dataMovie = movie
            loadViewTab(child: listVC[5])
        }
        numberChildInVC = 5
    }
    
    func category(category: TypeCategory, data: MovieModel?) {
        if numberChildInVC != 4 {
            let vc = (listVC[4] as? CategoryMovieVC)
            if vc?.nameCategory != category {
                vc?.nameCategory = category
                vc?.dataMovie = data
                vc?.indexPage = 2
            }
            loadViewTab(child: listVC[4])
        }
        numberChildInVC = 4
    }
    
}
extension TabBarVC: BackDelegate {
    func back() {
        if numberChildInVC != 0 {
            loadViewTab(child: listVC[0])
        }
        numberChildInVC = 0
    }
}

