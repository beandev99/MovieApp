//
//  ViewController.swift
//  MovieApp
//
//  Created by Tuan Le on 05/06/2021.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        perform(#selector(openVC), with: self, afterDelay: 0)
    }
    
    @objc func openVC() {
        let vc = LoginVC()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}

