//
//  FavouritesView.swift
//  RobertsDVTWeatherTakeHome
//
//  Created by Simbarashe Dombodzvuku on 2/14/23.
//

import SwiftUI
import CoreLocation

#warning("should come second. Find means to make custom location here")
struct FavouritesView: View {
    @EnvironmentObject var weatherViewModel: WeatherViewModelImplementation
    @EnvironmentObject var locationViewModel: LocationViewModel
    var latitude: Double?
    var longitude: Double?
    
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
                if (latitude != nil) && (longitude != nil) {
                    LocationViewModel.customLocation = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
                    weatherViewModel.getForecastForSavedLocation()
                }
            }
        }
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
    }
}
