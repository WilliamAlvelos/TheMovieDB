//
//  Movie.swift
//  themoviedb
//
//  Created by William Alvelos on 21/01/18.
//  Copyright © 2018 WilliamAlvelos. All rights reserved.
//

import Foundation

struct Movies : Codable {
    var total_results: Int = 0
    var total_pages: Int = 0
    var results: [Movie]?
    var page: Int?
    var id: Int = 0
}

struct Movie : Codable {
    var id: Int = 0
    var genre_ids: [Int]?
    var video: Bool = false
    var overview: String?
    var title: String = ""
    var release_date: String = ""
    var original_language: String?
    var popularity: Float = 0.0
    var poster_path: String?
    var original_title: String?
    var vote_count: Int?
    var adult: Bool = false
    var backdrop_path: String?
    var vote_average: Float = 0.0

    init(){
        id = 0
        overview = ""
    }
}
