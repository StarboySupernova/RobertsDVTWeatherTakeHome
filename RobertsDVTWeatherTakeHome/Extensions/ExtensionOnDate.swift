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

#warning("temporary placement")

struct K {
    static let appGroupBundleId = "group.com.himanshumatharu.Minimalist-Weather"
    
    static let optionsSegue = "MainToOptions"
    static let detailSegue = "MainToDetails"
    static let searchSegue = "OptionsToSearch"
    static let searchDetailSegue = "SearchToDetail"
    
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "TempCell"
    static let forecastCellIdentifier = "ReusableForecastCell"
    static let forecastCellNibName = "ForecastCell"
    
    static let launchedBeforeKey = "LaunchedBefore"
    static let savedCitiesKey = "SavedCities"
    
    static let apiBaseUrl = "https://api.openweathermap.org/data/2.5/weather"
    static let apiKey = "1a2176f7883d06ded7ca7e8dc6e19f18"
    static let apiUnits = "metric"
    static let apiForecastBaseUrl = "https://api.openweathermap.org/data/2.5/forecast"
    
}

