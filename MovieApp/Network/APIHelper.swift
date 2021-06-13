//
//  APIHelper.swift
//  MovieApp
//
//  Created by Tuan Le on 08/06/2021.
//

import Foundation
import UIKit
import SDWebImage

protocol APIHelper {
    func getDataMovie(type: TypeCategory, page: Int?, completed: @escaping (_ isSuccess: Bool, _ dataMovie: MovieModel?, _ error: Error?)->Void)
    func getImage(pathImg: String, width: WidthImage, completed: @escaping (_ isSuccess: Bool, _ image: UIImage?)->Void)
    func getURLTrailerMovie(idMovie: Int, completed: @escaping (_ isSuccess: Bool, _ dataTrailer: TrailerModel?, _ error: Error?)->Void)
}

class APIHelperImp: APIHelper {
    
    func getURLTrailerMovie(idMovie: Int, completed: @escaping (Bool, TrailerModel?, Error?) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(idMovie)/videos?api_key=\(API_KEY)&language=en-US")
        print("🌲 id movie: \(url?.absoluteString)")
        runOnBackgroundThread {
            var request = URLRequest(url: url!)
            request.httpMethod = "GET"
            request.timeoutInterval = 120
            URLSession.shared.dataTask(with: request) { data, response, error in
                if error == nil {
                    if let data = data {
                        do {
                            var dataMovie = try JSONDecoder().decode(TrailerModel.self, from: data)
                            if !(dataMovie.results.isEmpty) {
                                let path = dataMovie.results[0].key
                                dataMovie.urlYoutube = "https://www.youtube.com/watch?v=\(path)"

                            }
                            completed(true, dataMovie, nil)
                            return
                        } catch let error {
                            completed(false, nil, error)
                            return
                        }
                    }
                }
                completed(false,nil,nil)
            }.resume()
        }
    }
    
    func getImage(pathImg: String, width: WidthImage, completed: @escaping (Bool, UIImage?) -> Void) {
        let url = URL(string: DEFAULT_URL_IMG+width.rawValue+"/\(pathImg)")
        UIImageView().sd_setImage(with: url) { img, error, cache, url in
            if error == nil {
                completed(true, img)
            }
            else {
                completed(false, nil)
            }
        }
    }
    
    func getDataMovie(type: TypeCategory, page: Int?, completed: @escaping (Bool, MovieModel?, Error?) -> Void) {
        let url:URL?
        var pageLoading = 1
        if page != nil {
            pageLoading = page!
        }
        switch type {
        case .trending:
            url = URL(string: DEFAULT_URL_TRENDING)
        case .toprated:
            url = URL(string: DEFAULT_URL_TOPRATED+"\(pageLoading)")
        case .popular:
            url = URL(string: DEFAULT_URL_POPULAR+"\(pageLoading)")
        case .upcoming:
            url = URL(string: DEFAULT_URL_UPCOMING+"\(pageLoading)")
        case .nowplaying:
            url = URL(string: DEFAULT_URL_NOWPLAYING+"\(pageLoading)")
        }
        runOnBackgroundThread {
            var request = URLRequest(url: url!)
            request.httpMethod = "GET"
            request.timeoutInterval = 120
            URLSession.shared.dataTask(with: request) { data, response, error in
                if error == nil {
                    if let data = data {
                        do {
                            let dataMovie = try JSONDecoder().decode(MovieModel.self, from: data)
                            completed(true, dataMovie, nil)
                            return
                        } catch let error {
                            completed(false, nil, error)
                            return
                        }
                    }
                }
                completed(false,nil,nil)
            }.resume()
        }
    }
    
}
