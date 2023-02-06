//
//  WeatherService.swift
//  RobertsDVTWeatherTakeHome
//
//  Created by Simbarashe Dombodzvuku on 2/7/23.
//

import Foundation
import Combine
import SwiftUI

//to promote dependency injection, we need to make this class as testable as possible
protocol WeatherService {
    func request(from endpoint: OpenWeatherMapAPI) -> AnyPublisher<CurrentWeather, APIError>
    
    func requestForecast(from endpoint: OpenWeatherMapAPI) -> AnyPublisher<Forecast, APIError>
}

struct WeatherServiceImplementation: WeatherService {
    func requestForecast(from endpoint: OpenWeatherMapAPI) -> AnyPublisher<Forecast, APIError> {
        
        return URLSession
            .shared
            .dataTaskPublisher(for: endpoint.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError { _ in
                APIError.errorCode(404)
            }
            .flatMap {data, response -> AnyPublisher<Forecast, APIError> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: APIError.unknown).eraseToAnyPublisher()
                }
                
                if (200...299).contains(response.statusCode) {
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.dateDecodingStrategy = .iso8601 //the format dates are usually in
                    
                    return Just(data) //Just selected here to ensure single emission
                        .decode(type: Forecast.self, decoder: jsonDecoder)
                        .mapError { _ in
                            APIError.decodingError
                        }
                        //.print()
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: APIError.errorCode(response.statusCode)).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
   
   func request(from endpoint: OpenWeatherMapAPI) -> AnyPublisher<CurrentWeather, APIError> {
        return URLSession
            .shared
            .dataTaskPublisher(for: endpoint.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError{ _ in APIError.errorCode(467)}
            .flatMap{data, response -> AnyPublisher<CurrentWeather, APIError> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: APIError.decodingError).eraseToAnyPublisher()
                }
                
                if (200...299).contains(response.statusCode) {
                    //API returns dates as Int. We need to convert that to Date to work with the dates properly here
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.dateDecodingStrategy = .iso8601 //the format dates are usually in
                    
                    return Just(data)
                        .decode(type: CurrentWeather.self, decoder: jsonDecoder)
                        .print()
                        .mapError { _ in APIError.decodingError}
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: APIError.errorCode(response.statusCode)).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
    
    
}
