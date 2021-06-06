//
//  RegisterModel.swift
//  MovieApp
//
//  Created by Tuan Le on 06/06/2021.
//

import Foundation

class RegisterModel {
    var nameInput: String = ""
    var imgName: String = ""
    var txtHint: String = ""

    init(nameInput: String, imgName: String, txtHint: String) {
        self.nameInput = nameInput
        self.imgName = imgName
        self.txtHint = txtHint
    }
}
