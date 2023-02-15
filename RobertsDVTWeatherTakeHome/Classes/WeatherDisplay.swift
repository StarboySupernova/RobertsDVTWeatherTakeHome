//
//  WeatherDisplay.swift
//  RobertsDVTWeatherTakeHome
//
//  Created by Simbarashe Dombodzvuku on 2/1/23.
//

import UIKit

class WeatherDisplay {
    var title: String
    var subtitle: String
    var description: String
    var icon: UIImage
    var banner: UIImage
    var author: [String]?
    var gradient: [CGColor]?
    var background: UIImage?
    
    init(title: String!, subtitle: String!, description: String!, icon: UIImage!, banner: UIImage!, authors: [String]? = nil, colors: [CGColor]? = nil, background: UIImage? = nil) {
        self.title = title
        self.icon = icon
        self.author = authors
        self.banner = banner
        self.description = description
        self.subtitle = subtitle
        self.gradient = colors
        self.background = background
    }
}

let handbooks = [
    WeatherDisplay(title: "Johannesburg", subtitle: "South Africa", description: "Partly Cloudy, 25% chance of precipitation", icon: UIImage(named: "partlysunny"), banner: UIImage(named: "johannesburg"), authors: ["Wind Speed = 15 knots"], colors: [
        UIColor(red: 0.387, green: 0.041, blue: 0.55, alpha: 1.0).cgColor,
        UIColor(red: 0.251, green: 0.555, blue: 0.835, alpha: 1.0).cgColor
    ]),
    WeatherDisplay(title: "Frankfurt", subtitle: "Germany", description: "Clear, 0% chance of precipitation", icon: UIImage(named: "clear"), banner: UIImage(named: "frankfurt"), authors: ["Atmospheric Pressure - 1120mb"], colors: [
        UIColor(red: 0.51, green: 0.255, blue: 0.737, alpha: 1.0).cgColor,
        UIColor(red: 0.883, green: 0.283, blue: 0.523, alpha: 1.0).cgColor,
        UIColor(red: 0.984, green: 0.647, blue: 0.545, alpha: 1.0).cgColor
    ])
]

let headerWeather = [
    WeatherDisplay(title: "SwiftUI Concurrency", subtitle: "NEW VIDEO", description: "Build an iOS app for iOS 15 with custom layouts, animations and more!", icon: UIImage(named: "Logo SwiftUI")!, banner: UIImage(named: "Illustration 4")!, authors: ["Morty Mills"],background: UIImage(named: "rainyheader")),
    WeatherDisplay(title: "Flutter for Designers", subtitle: "20 sections - 3 hours", description: "Build a Flutter app for iOS and Android with custom layouts, animations and more!", icon: UIImage(named: "Logo Flutter")!, banner: UIImage(named: "Illustration 1")!, authors: ["Morty Mills"], background: UIImage(named: "snowyheader")),
    /*WeatherDisplay(title: "React Hooks Advanced", subtitle: "20 sections - 3 hours", description: "Build a React app with custom layouts, animations and more!", icon: UIImage(named: "Logo React")!, banner: UIImage(named: "Illustration 2")!, authors: ["Morty Mills"], background: UIImage(named: "rain"))*/
]
