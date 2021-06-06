//
//  RegisterCellSignUp.swift
//  MovieApp
//
//  Created by Tuan Le on 06/06/2021.
//

import UIKit

class RegisterCellSignUp: UICollectionViewCell {

    @IBOutlet weak var btnFacebook: UIButton!
    @IBOutlet weak var btnGoogle: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    var delgate: SignUpDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnSignUp.layer.cornerRadius = 10
        btnGoogle.layer.cornerRadius = 8
        btnGoogle.layer.cornerRadius = 8
    }

    @IBAction func signUp(_ sender: Any) {
        delgate?.signUp()
    }
}
protocol SignUpDelegate {
    func signUp()
}
