//
//  WeatherByCity.swift
//  VIPER
//
//  Created by Imran Shah on 30/07/2019.
//  Copyright © 2019 Imran Shah. All rights reserved.
//

import Foundation

struct WeatherByCity: Decodable {
    let cod : Int
    let name : String
    let id : Int
    let timezone : Int
    let dt : Int
    let visibility : Int
    let base : String

    let coord : Coord
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let clouds: Clouds
    let sys: Sys

}

//struct City: Decodable {
//    let id : Int?
//    let name : String?
//    let country : String?
//    let timezone : Int?
//
//    let coord : Coord
//}
//
//struct Coord: Decodable {
//    let lat : Double?
//    let lon : Double?
//}
//
//struct List: Decodable {
//    let dt : Int?
//    let dt_txt : String?
//
//    let main: Main
//    let weather: [Weather]
//    let clouds: Clouds
//    let wind: Wind
//    let sys: Sys
//
//}
//
//struct Main: Decodable { //list
//    let temp: Double?
//    let temp_min: Double?
//    let temp_max: Double?
//    let pressure: Double?
//    let sea_level: Double?
//    let grnd_level: Double?
//    let humidity: Double?
//    let temp_kf: Double?
//
//}
//
//struct Weather: Decodable { //list
//    let id: Int?
//    let main: String?
//    let description: String?
//    let icon: String?
//}
//
//struct Clouds: Decodable { //list
//    let all: Int?
//}
//
//struct Wind: Decodable { //list
//    let speed: Double?
//    let deg: Double?
//
//}
//
//struct Sys: Decodable { //list
//    let pod: String?
//}
