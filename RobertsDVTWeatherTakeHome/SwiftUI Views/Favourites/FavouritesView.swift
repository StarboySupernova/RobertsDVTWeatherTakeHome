//
//  FavouritesView.swift
//  RobertsDVTWeatherTakeHome
//
//  Created by Simbarashe Dombodzvuku on 2/14/23.
//

import SwiftUI

#warning("should come second. Find means to make custom location here")
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
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                weatherViewModel.getForecast() 
                LocationViewModel.customLocation = nil
            }
        }    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
    }
}
