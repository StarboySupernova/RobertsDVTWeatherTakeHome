//
//  ResultState.swift
//  RobertsDVTWeatherTakeHome
//
//  Created by Simbarashe Dombodzvuku on 2/7/23.
//

import Foundation

//these states will control what the user sees onscreen
//what we will do in the viewModel is dependent on the state that gets sent to the view

enum ResultState {
    case loading
    case forecastSuccess(content: Forecast)
    case failed(error: Error)
}

enum WeatherState {
    case success(content: CurrentWeather)
    case loading
    case failed(error: Error)
}
