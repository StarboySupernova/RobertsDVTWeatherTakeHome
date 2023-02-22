//
//  WeatherEndpoint.swift
//  RobertsDVTWeatherTakeHome
//
//  Created by Simbarashe Dombodzvuku on 2/6/23.
//

import Foundation
import CoreLocation

struct Constants {
    static let apiBaseUrl = "https://api.openweathermap.org/data/2.5/weather"
    static let apiKey = "1a2176f7883d06ded7ca7e8dc6e19f18"
    static let apiUnits = "metric"
    static let apiForecastBaseUrl = "https://api.openweathermap.org/data/2.5/forecast"
}

//protocol used here to promote reusability, e.g. when using another API, when can use the same pattern here
protocol APIBuilder {
    var urlRequest: URLRequest {get}
    var baseURL: URL {get}
    var key: String {get} //API key to retrieve the resource
}

enum OpenWeatherMapAPI {
    case getCurrentWeather
    case getForecast(lat: CLLocationDegrees, lon: CLLocationDegrees)
    case savedForecast(lat: CLLocationDegrees, lon: CLLocationDegrees)
    //if we have multiple endpoints for our API, we add them here
}

extension OpenWeatherMapAPI: APIBuilder {
        
    //we can now define a urlRequest, baseURL and a key for each of our cases in OpenWeatherMapAPI
    var urlRequest: URLRequest {
        return URLRequest(url: self.baseURL)
    }
    
    var baseURL: URL {
        switch self {
            case .getCurrentWeather:
                return URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=-25.750445&lon=28.237550&exclude=minutely,hourly,alerts&units=metric&APPID=\(self.key)")! //should find a way to inject location here
        case .getForecast(let latitude, let longitude):
            return URL(string: "\(Constants.apiForecastBaseUrl)?lat=\(latitude)&lon=\(longitude)&exclude=minutely,hourly,alerts&units=\(Constants.apiUnits)&appid=\(self.key)")!
        case .savedForecast(let latitude, let longitude):
            return URL(string: "\(Constants.apiForecastBaseUrl)?lat=\(latitude)&lon=\(longitude)&units=\(Constants.apiUnits)&appid=\(self.key)")!
        }
    }
    
    var key: String {
        //return "2b34877d3eca0717964533e84e158244"
        //return "0da0171684aa8f88191ae26e3dfb571d"
        return "1a2176f7883d06ded7ca7e8dc6e19f18"
    }
    
}
