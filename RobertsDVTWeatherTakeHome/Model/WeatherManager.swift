//
//  WeatherManager.swift
//  RobertsDVTWeatherTakeHome
//
//  Created by Simbarashe Dombodzvuku on 2/2/23.
//

import Foundation

class WeatherManager{
    
    //MARK: - Variables and Properties
    let network = Network()
    var weatherData : WeatherData? = nil
    static let shared = WeatherManager()
    
    //MARK: - Methods
    func loadAllData(){
        guard let data = weatherData else {return}
        data.isLoaded = false
        let cities = data.cities
        let group = DispatchGroup()
        for city in cities{
            group.enter()
            let urlString = "\(K.apiBaseUrl)?appid=\(K.apiKey)&units=\(K.apiUnits)&lat=\(city.latitude)&lon=\(city.longitude)"
            network.performWeatherRequest(with: urlString) { weatherModel, success in
                if success{
                    data.updateCityWeather(city: city, weather: weatherModel!)
                }
                group.leave()
            }
        }
        group.notify(queue: .main) {
            data.isLoaded = true
            data.multicastDelegate.invokeForEachDelegate { delegate in
                delegate.didUpdateWeather(data)
            }
        }
    }
    
    func loadForecastData(for city:City){
        guard let data = weatherData else {return}
        let urlString = "\(K.apiForecastBaseUrl)?appid=\(K.apiKey)&units=\(K.apiUnits)&lat=\(city.latitude)&lon=\(city.longitude)"
        network.performForecastRequest(with: urlString) { forecastModel, success in
            if success{
                DispatchQueue.main.async {
                    data.updateForecastDate(city: city, forecastModel: forecastModel!)
                }
            }
        }
    }
    
    func loadCityWeatherData(city:City, completion: @escaping (WeatherModel?, Bool)->()){
        let urlString = "\(K.apiBaseUrl)?appid=\(K.apiKey)&units=\(K.apiUnits)&lat=\(city.latitude)&lon=\(city.longitude)"
        network.performWeatherRequest(with: urlString) { weatherModel, success in
            if success {
                completion(weatherModel,true)
            }else{
                completion(nil,false)
            }
        }
    }
    
}

