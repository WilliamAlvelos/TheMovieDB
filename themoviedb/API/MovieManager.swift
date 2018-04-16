//
//  MovieManager.swift
//  themoviedb
//
//  Created by William Alvelos on 21/01/18.
//  Copyright © 2018 WilliamAlvelos. All rights reserved.
//

import Foundation

enum MethodType {
    case Movies
    case Genre
    case Credits
    case Video
}

final class MovieManager {
    
    private static func getUrlWith(methodType: MethodType, id: Int? = nil, page: Int? = 1) -> String{
        switch methodType {
        case .Movies:
            return APIManager.themoviedb + "genre/\(id ?? 0)/movies?page=\(page!)"
        case .Genre:
            return APIManager.themoviedb + "genre/movie/list"
        case .Credits:
            return APIManager.themoviedb + "movie/\(id ?? 0)/credits"
        case .Video:
            return APIManager.themoviedb + "movie/\(id ?? 0)/videos"

        }
    }
    
    static func getGenres(completion: @escaping([Genre]?) -> Void, error:@escaping(NSError) -> Void){
        
        APIManager.getFrom(getUrlWith(methodType: .Genre)) { (result) in
            if let data = result as? Data {
                do {
                    let genres = try JSONDecoder().decode(Genres.self, from: data)
                    completion(genres.genres)
                } catch let jsonError {
                    error(NSError(domain: jsonError.localizedDescription, code: Errors.JSONReturnErro.rawValue, userInfo: nil))
                }
            }else{
                error(NSError(domain: "", code: Errors.Unknown.rawValue, userInfo: nil))
            }
        }
    }
    
    static func getMovies(genreId: Int, page: Int? = 1 , completion: @escaping(Movies) -> Void, error:@escaping(NSError) -> Void){
        
        APIManager.getFrom(getUrlWith(methodType: .Movies, id: genreId, page: page)) { (result) in
            if let data = result as? Data {
                do {
                    let movies = try JSONDecoder().decode(Movies.self, from: data)
                    completion(movies)
                } catch let jsonError {
                    error(NSError(domain: jsonError.localizedDescription, code: Errors.JSONReturnErro.rawValue, userInfo: nil))
                }
            }else{
                error(NSError(domain: "", code: Errors.Unknown.rawValue, userInfo: nil))
            }
        }
    }
    
    
    static func getCredits(movieId: Int, completion: @escaping(Credits) -> Void, error:@escaping(NSError) -> Void){
        
        APIManager.getFrom(getUrlWith(methodType: .Credits, id: movieId)) { (result) in
            if let data = result as? Data {
                do {
                    let credits = try JSONDecoder().decode(Credits.self, from: data)
                    completion(credits)
                } catch let jsonError {
                    error(NSError(domain: jsonError.localizedDescription, code: Errors.JSONReturnErro.rawValue, userInfo: nil))
                }
            }else{
                error(NSError(domain: "", code: Errors.Unknown.rawValue, userInfo: nil))
            }
        }
    }
    
    static func getVideo(movieId: Int, completion: @escaping(Videos) -> Void, error:@escaping(NSError) -> Void){
        
        APIManager.getFrom(getUrlWith(methodType: .Video, id: movieId)) { (result) in
            if let data = result as? Data {
                do {
                    print(data)
                    let videos = try JSONDecoder().decode(Videos.self, from: data)
                    completion(videos)
                } catch let jsonError {
                    error(NSError(domain: jsonError.localizedDescription, code: Errors.JSONReturnErro.rawValue, userInfo: nil))
                }
            }else{
                error(NSError(domain: "", code: Errors.Unknown.rawValue, userInfo: nil))
            }
        }
    }
    
}
