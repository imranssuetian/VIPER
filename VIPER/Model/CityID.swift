//
//  CityID.swift
//  VIPER
//
//  Created by macintosh on 04/08/2019.
//  Copyright © 2019 macintosh. All rights reserved.
//

import Foundation

struct ResponseData: Decodable {
    var Cities: [CityID]
}


struct CityID: Decodable {

    let id : Int
    let name : String
    let country : String
    let coord: Coord
}
