//
//  RepositoryServiceLocator.swift
//  MovieApp
//
//  Created by Tuan Le on 08/06/2021.
//

import Foundation

class RepositoryServiceLocator {
    static let shared = RepositoryServiceLocator()
    private init(){
    }
    
    let apiHelper: APIHelper = APIHelperImp()
}
