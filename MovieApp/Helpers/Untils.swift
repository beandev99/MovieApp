//
//  Untils.swift
//  MovieApp
//
//  Created by Tuan Le on 08/06/2021.
//

import Foundation

func runOnMainThread(action: @escaping ()->Void){
    DispatchQueue.main.async {
        action()
    }
}

func runOnBackgroundThread(action: @escaping () -> Void) {
    DispatchQueue.global(qos: .background).async{
        action()
    }
}
