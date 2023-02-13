//
//  ForecastResponse.swift
//  RobertsDVTWeatherTakeHome
//
//  Created by Simbarashe Dombodzvuku on 2/7/23.
//

import Foundation

// MARK: - Forecast
struct Forecast: Codable {
    let cod: String
    let message, cnt: Int
    let list: [WeatherList]
    let city: City
}

extension Forecast: Identifiable {
    var id: String {
        UUID().uuidString
    }
}

// MARK: - City
struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population, timezone, sunrise, sunset: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lat, lon: Double
}

// MARK: - Weather List
struct WeatherList: Codable, Identifiable {
    var id = UUID()
    let dt: Int
    let main: Main
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int
    let pop: Double
    let sys: Sys
    let dtTxt: String
    let rain: Rain?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, sys
        case dtTxt = "dt_txt"
        case rain
    }
}

extension WeatherList {
    var date: Date {
        return Date(timeIntervalSince1970: TimeInterval(dt))
    }
    
    var dateWoTime: Date? {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year,.month,.day], from: date)) ?? nil
    }
    
    
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - Rain
struct Rain: Codable {
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

// MARK: - Sys
struct Sys: Codable {
    let pod: String
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

extension Weather : Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(main)
        hasher.combine(weatherDescription)
        hasher.combine(icon)
    }
    
    static func == (lhs: Weather, rhs: Weather) -> Bool {
        return lhs.id == rhs.id && lhs.main == rhs.main && lhs.weatherDescription == rhs.weatherDescription && lhs.icon == rhs.icon
    }

}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}

struct CustomForecast {
    var date: Date
    var description: String
    var maxTemp: Double
    var minTemp: Double
    var temp: Double
}

extension CustomForecast: Identifiable {
    var id: UUID {
        return UUID()
    }
}

struct HourlyForecast {
    var temp: Double
    var description: String
    var unixTime: Double
}

extension HourlyForecast {
    var date: Date {
        return Date(timeIntervalSince1970: TimeInterval(unixTime))
    }
}

enum ForecastPeriod {
    case hourly
    case daily
}

