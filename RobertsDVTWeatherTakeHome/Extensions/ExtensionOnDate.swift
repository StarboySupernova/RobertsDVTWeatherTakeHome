//
//  ExtensionOnDate.swift
//  RobertsDVTWeatherTakeHome
//
//  Created by Simbarashe Dombodzvuku on 2/2/23.
//

import Foundation

extension Date{
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.string(from: self).capitalized
        // or use capitalized(with: locale) if you want
    }
}

func dayName(_ unixValue: Int) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    let date = Date(timeIntervalSince1970: TimeInterval(unixValue))
    dateFormatter.timeZone = .current
    return dateFormatter.string(from: date)
}

func getWeekday(from date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    return dateFormatter.string(from: date)
}


#warning("temporary placement")

struct Constants {
    static let apiBaseUrl = "https://api.openweathermap.org/data/2.5/weather"
    static let apiKey = "1a2176f7883d06ded7ca7e8dc6e19f18"
    static let apiUnits = "metric"
    static let apiForecastBaseUrl = "https://api.openweathermap.org/data/2.5/forecast"
}

