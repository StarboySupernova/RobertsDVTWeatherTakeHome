//
//  WeatherSuccessView.swift
//  RobertsDVTWeatherTakeHome
//
//  Created by Simbarashe Dombodzvuku on 2/3/23.
//

import SwiftUI

struct WeatherSuccessView: View {
    @EnvironmentObject var weatherViewModel: WeatherViewModelImplementation
    //@EnvironmentObject var favouritesViewModel: FavouritesViewModel
    @State private var showingSheet: Bool = false
    var forecast: Forecast
        
    var body: some View {
        if let weatherList = forecastResultStrip(forecast: forecast) {
            ZStack {
                VStack {
                    switch weatherList.first?.weather.first?.main {
                        case let name where name == "Clear" :
                            Image("sea_sunny")
                                .resizable()
                                .frame(maxWidth: getRect().width, maxHeight: getRect().height * 0.4)
                                .edgesIgnoringSafeArea([.top, .horizontal])
                        case let name where name == "Rain" :
                            Image("sea_rainy")
                                .resizable()
                                .frame(maxWidth: getRect().width, maxHeight: getRect().height * 0.4)
                                .edgesIgnoringSafeArea([.top, .horizontal])
                        default:
                            Image("sea_cloudy")
                                .resizable()
                                .frame(maxWidth: getRect().width, maxHeight: getRect().height * 0.4)
                                .edgesIgnoringSafeArea([.top, .horizontal])
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: getRect().width, maxHeight: getRect().height)
                .overlay(alignment: .topTrailing) {
                    Button {
                        let forecast = weatherViewModel.forecastValue()
                        let city = forecast.city
                        let userDefaults = UserDefaults.standard
                        do {
                            try userDefaults.setObject(city, forKey: city.name)
                            print(city.name)
                        } catch {
                            showErrorAlertView("Error", "Unable to save to internal memory", handler: {})
                        }
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .padding(5)
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.ultraThinMaterial)
                            }
                    }
                    .padding()

                }
                
                VStack {
                    Spacer ()
                    
                    VStack {
                        let minMax = forecastMinMax(forecast: forecast)
                        HStack {
                            //unexpected behaviour for min and max temperatures for the day. will look into purchasing license for 16 day forecast API
                            //minMax and weatherList.first.main produce the same values
                            iconView(weatherList.first!.weather.first!.main, label: String.localizedStringWithFormat("%.0f° \n min", minMax?.min ?? weatherList.first!.main.tempMin))
                            
                            Spacer()
                            
                            iconView(weatherList.first!.weather.first!.main, label: String.localizedStringWithFormat("%.0f° \n current", weatherList.first!.main.temp))
                            
                            Spacer()
                            
                            iconView(weatherList.first!.weather.first!.main, label: String.localizedStringWithFormat("%.0f° \n max", minMax?.max ?? weatherList.first!.main.tempMax))
                        }
                        .padding(.horizontal)
                        
                        LabelledDivider(label: "", horizontalPadding: -10, color: .white)
                            .glow(color: .white, radius: 1)
                            .frame(maxWidth : getRect().width)
                        
                        ForEach(weatherList) { listItem in
                            HStack(spacing: 0) {
                                CustomRow {
                                    Text(dayName(listItem.dt))
                                        .font(.caption)
                                        .padding(.leading)
                                        .frame(maxWidth: 150, alignment: .leading)
                                } center: {
                                    iconView(listItem.weather[0].main)
                                        .padding(.horizontal)
                                } right: {
                                    Text(String.localizedStringWithFormat("%.0f°", listItem.main.tempMax))
                                        .padding(.trailing)
                                }
                            }
                            .frame(maxWidth: getRect().width)
                        }
                    }
                    .frame(maxWidth: getRect().width, maxHeight: getRect().height * 0.55, alignment: .top)
                    //background here
                    .background {
                        switch weatherList.first?.weather.first?.main {
                            case let name where name == "Clear" :
                                Color.blue
                            case let name where name == "Rain" :
                                Color("rainy")
                            default:
                                Color("cloudy")
                        }
                    }
                }
                .frame(maxWidth: getRect().width, maxHeight: getRect().height)
            }
            .frame(maxWidth: getRect().width, maxHeight: getRect().height)
            .background {
                switch weatherList.first?.weather.first?.main {
                    case let name where name == "Clear" :
                        Color.blue
                    case let name where name == "Rain" :
                        Color("rainy")
                    default:
                        Color("cloudy")
                }
            }
        } else {
            VStack {
                ErrorView(error: APIError.unknown){weatherViewModel.getForecast()}
                //PlaceholderImageView()
            }
        }
        
    }

    @ViewBuilder func iconView(_ weatherMainStringValue: String, label: String = "") -> some View {
        switch weatherMainStringValue {
            case let maindesc where maindesc == "Clear" :
                Label{
                    Text(label)
                        .font(.body)
                        .fontWeight(.ultraLight)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .glow(color: .white, radius: 1)
                        .shadow(color: .black, radius: 1, x: 1, y: 1)
                } icon: {
                    Image("clear")
                        .resizable()
                        .scaledToFit()
                }
                .labelStyle(CaptionLabelStyle())
                
            case let maindesc where maindesc == "Rain":
                Label{
                    Text(label)
                        .font(.body)
                        .fontWeight(.ultraLight)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                } icon: {
                    Image("rain")
                        .resizable()
                        .scaledToFit()
                }
                .labelStyle(CaptionLabelStyle())
                
            default:
                Label{
                    Text(label)
                        .font(.body)
                        .fontWeight(.ultraLight)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                } icon: {
                    Image("partlysunny")
                        .resizable()
                        .scaledToFit()
                }
                .labelStyle(CaptionLabelStyle())
        }
    }

    //no longer used
    @ViewBuilder func backgroundChooser(_ string : String) -> some View {
        if string.contains("clear") {
            Color.blue
        }
        
        if string.contains("rain") {
            Color("rainy")
        }
        
        if string.contains("cloud") {
            Color("cloudy")
        }
        /*switch string {
        case let name where name == "Clear" :
            Color.blue
        case let name where name == "Rain" :
            Color("rainy")
        default:
            Color("cloudy")
        }*/
    }
    
    //no longer used
    @ViewBuilder func customLabel(_ label: String, _ image: String) -> some View {
        Label{
            Text(label)
                .font(.body)
                .fontWeight(.ultraLight)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
        } icon: {
            Image(image)
                .resizable()
                .scaledToFit()
        }
        .labelStyle(CaptionLabelStyle())
    }

}

/*struct WeatherSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        //WeatherSuccessView(weatherData: WeatherManager.shared.weatherData)
        EmptyView()
    }
}*/
