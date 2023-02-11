//
//  ExtensionOnArray.swift
//  RobertsDVTWeatherTakeHome
//
//  Created by Simbarashe Dombodzvuku on 2/2/23.
//

import Foundation

extension Array where Element: BinaryInteger {

    /// The average value of all the items in the array
    var average: Double {
        if self.isEmpty {
            return 0.0
        } else {
            let sum = self.reduce(0, +)
            return Double(sum) / Double(self.count)
        }
    }

}

extension Array where Element: BinaryFloatingPoint {

    /// The average value of all the items in the array
    var average: Double {
        if self.isEmpty {
            return 0.0
        } else {
            let sum = self.reduce(0, +)
            return Double(sum) / Double(self.count)
        }
    }
    
    var maximumValue: Double {
        if self.isEmpty {
            return 0.0
        } else {
            var currentMax = self[0]
            for value in self[1..<self.count] {
                if value > currentMax {
                    currentMax = value
                }
            }
            return Double(currentMax)
        }
    }

}
