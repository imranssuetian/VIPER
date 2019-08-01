//
//  WeatherByID.swift
//  JSON Parsing
//
//  Created by Imran Shah on 24/07/2019.
//  Copyright © 2019 Imran Shah. All rights reserved.
//

import Foundation

struct WeatherByID: Decodable {
    let cod : String
    let message : Double
    let cnt : Int
    let list: [List]
    let city: City
}

struct City: Decodable {
    let id : Int?
    let name : String?
    let country : String?
    let timezone : Int?
    
    let coord : Coord
}

struct Coord: Decodable {
    let lat : Double?
    let lon : Double?
}

struct List: Decodable {
    let dt : Int?
    let dt_txt : String?
    
    let main: Main
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let sys: Sys
    
}

struct Main: Decodable { //list
    let temp: Double?
    let temp_min: Double?
    let temp_max: Double?
    let pressure: Double?
    let sea_level: Double?
    let grnd_level: Double?
    let humidity: Double?
    let temp_kf: Double?
    
}

struct Weather: Decodable { //list
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
}

struct Clouds: Decodable { //list
    let all: Double?
}

struct Wind: Decodable { //list
    let speed: Double?
    let deg: Double?
    
}

struct Sys: Decodable { //list
    let pod: String?
    let type: Int?
    let id: Int?
    let message: Double?
    let country: String?
    let sunrise: Double?
    let sunset: Double?
    
}

//struct Rain: Decodable {
//    let 3h: Double?
//}
