//
//  FavouritesView.swift
//  RobertsDVTWeatherTakeHome
//
//  Created by Simbarashe Dombodzvuku on 2/14/23.
//

import SwiftUI

struct FavouritesView: View {
    @StateObject var weatherViewModel: WeatherViewModelImplementation = WeatherViewModelImplementation(service: WeatherServiceImplementation())
    @StateObject var locationViewModel: LocationViewModel = LocationViewModel()
    
    var body: some View {
        Group {
            switch locationViewModel.authorizationStatus {
                case .notDetermined :
                    AnyView(RequestLocationView())
                        .environmentObject(locationViewModel)
                case .restricted :
                ErrorView(error: APIError.unknown) {
                        locationViewModel.requestPermission()
                    }
                case .denied :
                ErrorView(error: APIError.unknown) {}
                case .authorizedAlways, .authorizedWhenInUse :
                    Group {
                        switch weatherViewModel.state {
                            case .forecastSuccess(content: let forecast):
                                FavouritesForecastView(forecast: forecast)
                                    .environmentObject(weatherViewModel)
                            case .loading :
                                VStack {
                                    ProgressView()
                                }
                            case.failed(error: let error) :
                                ErrorView(error: error) {
                                    weatherViewModel.getForecast()
                                }
                        }
                    }
                default :
                    ErrorView(error: APIError.unknown){}
            }
        }
        //putting this on weather success //can't do that because it never appears because this function is never called
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                weatherViewModel.getForecast() //should possibly use DispatchQueue here
                LocationViewModel.customLocation = nil
            }
        }    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
    }
}
