//
//  Request.swift
//  RobertsDVTWeatherTakeHome
//
//  Created by Simbarashe Dombodzvuku on 2/2/23.
//

import Foundation

/*
 This code defines several structs that conform to the Decodable protocol, which allows them to be used to initialize instances of their respective structs from JSON data. The structs are used to parse the JSON data returned from the API request made by the performWeatherRequest and performForecastRequest methods, to retrieve the weather and forecast information. The properties of these structs match the structure of the JSON data returned by the API, so that the data can be easily mapped to the structs' properties.
 */

/*struct ForecastRequest: Decodable {
    let list: [ForecastRequestSub]
}

struct ForecastRequestSub: Decodable {
    let dt: Double
    let main: Main
    let weather: [Weather]
}

struct WeatherRequest: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable{
    let temp: Double
    let temp_min: Double
    let temp_max: Double
}

struct Weather:Decodable{
    let description: String
}*/
