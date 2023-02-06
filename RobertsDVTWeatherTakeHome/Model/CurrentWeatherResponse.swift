//
//  CurrentWeather.swift
//  RobertsDVTWeatherTakeHome
//
//  Created by Simbarashe Dombodzvuku on 2/7/23.
//

import Foundation

// MARK: - Current Weather
struct CurrentWeather: Codable {
    let coord: Coordinates
    let weather: [CurrentWeatherDetail]
    let base: String
    let main: CurrentMain
    let visibility: Int
    let wind: CurrentWind
    let clouds: CurrentClouds
    let dt: Int
    let sys: CurrentSys
    let timezone, id: Int
    let name: String
    let cod: Int
}

// MARK: - Current Clouds
struct CurrentClouds: Codable {
    let all: Int
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let lon, lat: Double
}

// MARK: - CurrentMain
struct CurrentMain: Codable {
    let temp, feelsLike, tempMin: Double
    let tempMax, pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - CurrentSys
struct CurrentSys: Codable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}

// MARK: - Current Weather Detail
struct CurrentWeatherDetail: Codable {
    let id: Int
    let main, weatherDescription, icon: String

    /*var weatherIconURL: URL {
       let urlString = "http://openweathermap.org/img/wn/\(icon)@2x.png"
       return URL(string: urlString)!
    }*/

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
 }

// MARK: - Current Wind
struct CurrentWind: Codable {
    let speed: Double
    let deg: Int
 }

