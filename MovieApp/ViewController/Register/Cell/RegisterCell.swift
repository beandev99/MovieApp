//
//  RegisterCell.swift
//  MovieApp
//
//  Created by Tuan Le on 06/06/2021.
//

import UIKit

class RegisterCell: UICollectionViewCell {

    @IBOutlet weak var temp: NSLayoutConstraint!
    @IBOutlet weak var btnExpand: UIButton!
    @IBOutlet weak var tftInput: UITextField!
    @IBOutlet weak var viewInput: UIView!
    @IBOutlet weak var lblTitile: UILabel!
    @IBOutlet weak var btnImgDetail: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        viewInput.layer.borderWidth = 1
        viewInput.layer.borderColor = UIColor.init(hex: "3F4144").cgColor
        viewInput.layer.cornerRadius = 10
    }

}
