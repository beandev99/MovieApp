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
    func getRecommendMovie(idMovie: Int, pageLoading: inout Int?, completed: @escaping (_ isSuccess: Bool, _ dataMovie: MovieModel?)->Void)
    func getLinkMovie(idMovie: Int, completed: @escaping (_ isSuccess: Bool, _ data: LinkMovie?)->Void)
    func getActorMovie(idMovie: Int, completed: @escaping (_ isSuccess: Bool, _ data: ActorMovie?)->Void)
}

class APIHelperImp: APIHelper {
    func getActorMovie(idMovie: Int, completed: @escaping (Bool, ActorMovie?) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(idMovie)/credits?api_key=\(API_KEY)&language=en-US")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 120
        URLSession.shared.dataTask(with: request) { data, response, err in
            if err == nil {
                if let data = data {
                    do {
                        let dataActor = try JSONDecoder().decode(ActorMovie.self, from: data)
                        completed(true, dataActor)
                    } catch {
                        completed(false,nil)
                    }
                }
            }
            else {
                completed(false,nil)
            }
        }.resume()
    }
    
    func getLinkMovie(idMovie: Int, completed: @escaping (Bool, LinkMovie?) -> Void) {
        let url = URL(string: DEFAULT_URL_LINK_MOVIE+"\(idMovie)")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 120
        URLSession.shared.dataTask(with: request) { data , response, err in
            if err == nil {
                if let data = data {
                    do {
                        let dataLink = try JSONDecoder().decode(LinkMovie.self, from: data)
                        completed(true,dataLink)
                    } catch {
                        completed(false,nil)
                    }
                }
                else {
                    completed(false,nil)
                }
            }
            else {
                completed(false,nil)
            }
        }.resume()
    }

    func getRecommendMovie(idMovie: Int, pageLoading: inout Int?, completed: @escaping (Bool, MovieModel?) -> Void) {
        if pageLoading == nil {
            pageLoading = 1
        }
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(idMovie)/recommendations?api_key=\(API_KEY)&language=en-US&page=\(pageLoading!)")
        runOnBackgroundThread {
            var request = URLRequest(url: url!)
            request.httpMethod = "GET"
            request.timeoutInterval = 120
            URLSession.shared.dataTask(with: request) { data, respone, error in
                if error == nil {
                    if let data = data {
                        do {
                            let dataRecomend = try JSONDecoder().decode(MovieModel.self, from: data)
                            completed(true, dataRecomend)
                        } catch {
                            completed(false, nil)
                        }
                    }
                    else {
                        completed(false, nil)
                    }
                }
                else {
                    completed(false,nil)
                }
            }.resume()
        }
    }
    
    func getURLTrailerMovie(idMovie: Int, completed: @escaping (Bool, TrailerModel?, Error?) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(idMovie)/videos?api_key=\(API_KEY)&language=en-US")
        runOnBackgroundThread {
            var request = URLRequest(url: url!)
            request.httpMethod = "GET"
            request.timeoutInterval = 120
            URLSession.shared.dataTask(with: request) { data, response, error in
                if error == nil {
                    if let data = data {
                        do {
                            let dataMovie = try JSONDecoder().decode(TrailerModel.self, from: data)
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
