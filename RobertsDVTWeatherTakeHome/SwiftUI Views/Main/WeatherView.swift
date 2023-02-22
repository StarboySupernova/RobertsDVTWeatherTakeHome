//
//  WeatherView.swift
//  RobertsDVTWeatherTakeHome
//
//  Created by Simbarashe Dombodzvuku on 2/7/23.
//

import SwiftUI
import CoreLocation

struct WeatherView: View {
    @EnvironmentObject var weatherViewModel: WeatherViewModelImplementation
    @EnvironmentObject var locationViewModel: LocationViewModel
    
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
                                WeatherSuccessView(forecast: forecast)
                                    .environmentObject(weatherViewModel)
                                    .environmentObject(locationViewModel)
                            case .loading :
                                VStack {
                                    ProgressView()
                                    Text("Loading weather data \(coordinate?.latitude ?? 0), \(coordinate?.longitude ?? 0)")
                                }
                                .task {
                                    weatherViewModel.getForecast(lat: coordinate!.latitude, lon: coordinate!.longitude)
                                }
                            case.failed(error: let error) :
                                ErrorView(error: error) {
                                    //weatherViewModel.getForecast()
                                }
                        }
                    }
                default :
                    ErrorView(error: APIError.unknown){}
            }
        }
        //putting this on weather success //can't do that because it never appears because this function is never called
        .task {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                LocationViewModel.locationProvider(latitude: locationViewModel.lastSeenLocation?.coordinate.latitude, longitude: locationViewModel.lastSeenLocation?.coordinate.longitude)
            }
        }
    }
    
    var coordinate: CLLocationCoordinate2D? {
        locationViewModel.lastSeenLocation?.coordinate
    }
}

struct RequestLocationView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    //@State private var progress: CGFloat = 0
    
    //@State private var showingAnimation: Bool = true
    
    let backgroundGradient: Gradient = Gradient(colors: [.black.opacity(0.1), .gray.opacity(0.1)])
    let backgroundGradient2: Gradient = Gradient(colors: [.mint.opacity(0.1), .orange.opacity(0.1)])
    
    var body: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .background(.ultraThinMaterial)
                .foregroundColor(Color.primary.opacity(0.35))
                .foregroundStyle(.ultraThinMaterial)
                //.modifier(FlatGlassView())
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Image(systemName: "location.circle")
                    .resizable()
                    .frame(width: 100, height: 100, alignment: .center)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    .padding()
                Button(action: {
                    locationViewModel.requestPermission()
                }, label: {
                    Label("Allow tracking", systemImage: "location")
                })
                .padding(10)
                .foregroundColor(.white)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                Text("We need your permission to access weather in your location.")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .font(.caption)
                    .padding()
            }
            //.modifier(FlatGlassView())
            /*.onTapGesture {
                showingAnimation = false
            }*/
        }
    }
}


struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
