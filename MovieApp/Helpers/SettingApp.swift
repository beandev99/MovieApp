//
//  SettingApp.swift
//  MovieApp
//
//  Created by bean99 on 14/07/2021.
//

import Foundation

class SettingApp {
    static let shared = SettingApp()
    let defaults = UserDefaults.standard
    let IS_LOGIN = "IS_LOGIN"
    let USER_PASSWORD = "USER_PASSWORD"
    let USER_EMAIL = "USER_EMAIL"
    
    var isLogin: Bool {
        get {
            guard let isLogin = defaults.value(forKey: IS_LOGIN) else {return false}
            return isLogin as! Bool
        }
        set {
            defaults.setValue(newValue, forKey: IS_LOGIN)
        }
    }
    
    
}

