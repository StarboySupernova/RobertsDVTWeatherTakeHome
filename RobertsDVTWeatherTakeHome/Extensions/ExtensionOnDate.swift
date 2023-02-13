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

func extractHourFromUnixTimestamp(timestamp: Double) -> Int {
    let date = Date(timeIntervalSince1970: timestamp)
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: date)
    return hour
}

func getDateFromUnixTimestamp(timestamp: Double) -> Date {
    let timeInterval = TimeInterval(timestamp)
    return Date(timeIntervalSince1970: timeInterval)
}


