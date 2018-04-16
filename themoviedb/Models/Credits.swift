//
//  Credits.swift
//  FastShop
//
//  Created by William Alvelos on 22/01/18.
//  Copyright © 2018 WilliamAlvelos. All rights reserved.
//

import Foundation

struct Credits : Codable {
    var id: Int = 0
    var cast: [Cast]
    var crew: [Crew]
    
    init(){
        id = 0
        cast = []
        crew = []
    }
    
}

struct Cast : Codable{
    var name: String?
    var gender: Int?
    var id: Int?
    var character: String?
    var cast_id: Int?
    var order: Int?
    var credit_id: String?
    var profile_path: String?
}

struct Crew: Codable {
    var name: String?
    var gender: Int?
    var id: Int?
    var job: String?
    var department: String?
    var credit_id: String?
    var profile_path: String?
}



