//
//  WeatherViewHostingController.swift
//  RobertsDVTWeatherTakeHome
//
//  Created by Simbarashe Dombodzvuku on 2/2/23.
//

import UIKit
import SwiftUI


class WeatherViewHostingController: UIHostingController<WeatherSuccessView> {
    var dependency: WeatherData?
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: WeatherSuccessView(weatherData: dependency))
    }
}


