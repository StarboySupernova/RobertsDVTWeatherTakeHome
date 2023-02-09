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



/*
func dayExtractor(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    let dayInWeek = dateFormatter.string(from: date)
    return dayInWeek
}

*/
