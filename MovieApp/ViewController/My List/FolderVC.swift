//
//  FolderVC.swift
//  MovieApp
//
//  Created by Tuan Le on 08/06/2021.
//

import UIKit
import PagingKit

struct DataVC {
    var menuTitle: String
    var vc: UIViewController
}

class FolderVC: UIViewController {
    var dataVC: [DataVC] = []
    var menuViewController: PagingMenuViewController?
    var contentViewController: PagingContentViewController?
    let focusView = UnderlineFocusView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configVC()
        configUI()

    }
    
    func configUI() {
        menuViewController?.register(nib: UINib(nibName: "MenuCell", bundle: nil), forCellWithReuseIdentifier: "MenuCell")
//        menuViewController?.registerFocusView(view: focusView)
        menuViewController?.reloadData()
        contentViewController?.reloadData()

    }
    
    func configVC() {
        let myListVC = MyListVC()
        dataVC.append(DataVC(menuTitle: "My List", vc: myListVC))
        let downloadedVC = DownloadedVC()
        dataVC.append(DataVC(menuTitle: "Downloaded", vc: downloadedVC))
    }
}
extension FolderVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PagingMenuViewController {
            menuViewController = vc
            menuViewController?.dataSource = self
        }
        else if let vc = segue.destination as? PagingContentViewController {
            contentViewController = vc
            contentViewController?.dataSource = self
        }
    }
}
extension FolderVC: PagingMenuViewControllerDataSource {
    func numberOfItemsForMenuViewController(viewController: PagingMenuViewController) -> Int {
        return dataVC.count
    }
    
    func menuViewController(viewController: PagingMenuViewController, cellForItemAt index: Int) -> PagingMenuViewCell {
        let cell = viewController.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: index) as! MenuCell
//        cell.titleMenu.text = dataVC[index].menuTitle
        cell.lblTitle.text = dataVC[index].menuTitle
        return cell
    }
    
    func menuViewController(viewController: PagingMenuViewController, widthForItemAt index: Int) -> CGFloat {
        return 100
    }
}
extension FolderVC: PagingContentViewControllerDataSource {
    func numberOfItemsForContentViewController(viewController: PagingContentViewController) -> Int {
        return dataVC.count
    }
    
    func contentViewController(viewController: PagingContentViewController, viewControllerAt index: Int) -> UIViewController {
        return dataVC[index].vc
    }
    
    
}
