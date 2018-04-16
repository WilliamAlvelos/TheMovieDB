//
//  Video.swift
//  themoviedb
//
//  Created by William Alvelos on 23/01/18.
//  Copyright © 2018 WilliamAlvelos. All rights reserved.
//

import Foundation

struct Videos : Codable {
    var results: [Video]
    var id: Int?
}


struct Video : Codable {
    var size: Int?
    var type: String?
    var id: String?
    var key: String?
    var site: String?
    var iso6391: String?
    var iso31661: String?
    var name: String?
}
