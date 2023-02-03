//
//  ExtensionOnCollection.swift
//  RobertsDVTWeatherTakeHome
//
//  Created by Simbarashe Dombodzvuku on 2/2/23.
//

import Foundation

extension Collection {

    /**
     Returns the most frequent element in the collection.
     */
    func mostFrequent() -> Self.Element?
    where Self.Element: Hashable {
        let counts = self.reduce(into: [:]) {
            return $0[$1, default: 0] += 1
        }

        return counts.max(by: { $0.1 < $1.1 })?.key
    }
}

#warning("TEMPORARY PLACEMENT")
func dayName(_ unixValue: Int) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    let date = Date(timeIntervalSince1970: TimeInterval(unixValue))
    dateFormatter.timeZone = .current
    return dateFormatter.string(from: date)
}

func dayExtractor(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    let dayInWeek = dateFormatter.string(from: date)
    return dayInWeek
}

