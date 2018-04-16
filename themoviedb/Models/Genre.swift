//
//  Genre.swift
//  themoviedb
//
//  Created by William Alvelos on 21/01/18.
//  Copyright © 2018 WilliamAlvelos. All rights reserved.
//

import Foundation

struct Genres : Codable {
    let genres: [Genre]
}

struct Genre : Codable {
    let id: Int
    let name: String
    
    init(json: [String: Any]){
        id = json["id"] as? Int ?? 0
        name = json["name"] as? String ?? ""
    }
    
}
