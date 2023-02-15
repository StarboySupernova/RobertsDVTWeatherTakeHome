//
//  ForecastResponse.swift
//  RobertsDVTWeatherTakeHome
//
//  Created by Simbarashe Dombodzvuku on 2/7/23.
//

import Foundation

// MARK: - Forecast
struct Forecast: Codable, Hashable {
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
struct City: Codable, Hashable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population, timezone, sunrise, sunset: Int
}

// MARK: - Coord
struct Coord: Codable, Hashable {
    let lat, lon: Double
}

// MARK: - Weather List
struct WeatherList: Codable, Identifiable, Hashable {
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
struct Clouds: Codable, Hashable {
    let all: Int
}

// MARK: - Main
struct Main: Codable, Hashable {
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

/*extension Main: Hashable {
    func hash(into hasher: inout Hasher) {
            hasher.combine(temp)
            hasher.combine(feelsLike)
            hasher.combine(tempMin)
            hasher.combine(tempMax)
            hasher.combine(pressure)
            hasher.combine(seaLevel)
            hasher.combine(grndLevel)
            hasher.combine(humidity)
            hasher.combine(tempKf)
        }

        static func ==(lhs: Main, rhs: Main) -> Bool {
            return lhs.temp == rhs.temp &&
                lhs.feelsLike == rhs.feelsLike &&
                lhs.tempMin == rhs.tempMin &&
                lhs.tempMax == rhs.tempMax &&
                lhs.pressure == rhs.pressure &&
                lhs.seaLevel == rhs.seaLevel &&
                lhs.grndLevel == rhs.grndLevel &&
                lhs.humidity == rhs.humidity &&
                lhs.tempKf == rhs.tempKf
        }
}*/

// MARK: - Rain
struct Rain: Codable, Hashable {
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

// MARK: - Sys
struct Sys: Codable, Hashable {
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
struct Wind: Codable, Hashable {
    let speed: Double
    let deg: Int
    let gust: Double
}

/*extension Wind: Hashable {
    func hash(into hasher: inout Hasher) {
            hasher.combine(speed)
            hasher.combine(deg)
            hasher.combine(gust)
        }

        static func ==(lhs: Wind, rhs: Wind) -> Bool {
            return lhs.speed == rhs.speed &&
                lhs.deg == rhs.deg &&
                lhs.gust == rhs.gust
        }
}*/

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

extension HourlyForecast: Identifiable {
    var id: String {
        UUID().uuidString
    }
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

