//
//  WeatherSuccessView.swift
//  RobertsDVTWeatherTakeHome
//
//  Created by Simbarashe Dombodzvuku on 2/3/23.
//

import SwiftUI

struct WeatherSuccessView: View {
    let weatherData: WeatherData?
    var city: City = City(id: 4,name: "London", latitude: 51.496936024546535, longitude: -0.12289001864225133) // should be == to  some default here
    
    var body: some View {
        if let currentWeather = weatherData?.getCityWeather(city: city), let forecast = weatherData?.getCityForecast(city: city) {
            ZStack {
                VStack {
                    switch currentWeather.description {
                    case let name where name == "Clear" :
                        Image("sea_sunny")
                            .resizable()
                        //.aspectRatio(contentMode: .fill)
                            .frame(maxWidth: getRect().width, maxHeight: getRect().height * 0.4)
                            .edgesIgnoringSafeArea([.top, .horizontal])
                    case let name where name == "Rain" :
                        Image("sea_rainy")
                            .resizable()
                        //.aspectRatio(3 / 2, contentMode: .fill)
                            .frame(maxWidth: getRect().width, maxHeight: getRect().height * 0.4)
                            .edgesIgnoringSafeArea([.top, .horizontal])
                    default:
                        Image("sea_cloudy")
                            .resizable()
                        //.aspectRatio(3 / 2, contentMode: .fill)
                            .frame(maxWidth: getRect().width, maxHeight: getRect().height * 0.4)
                            .edgesIgnoringSafeArea([.top, .horizontal])
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: getRect().width, maxHeight: getRect().height)
                .overlay(alignment: .topTrailing) {
                    Button {
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
                        //let minMax = forecastMinMax(forecast: forecast)
                        HStack {
                            //unexpected behaviour for min and max temperatures for the day. will look into purchasing license for 16 day forecast API
                            //minMax and weatherList.first.main produce the same values
                            iconView(currentWeather.description, label: String.localizedStringWithFormat("%.0f° \n min", currentWeather.tempLow))
                            
                            Spacer()
                            
                            iconView(currentWeather.description, label: String.localizedStringWithFormat("%.0f° \n current", currentWeather.tempNow))
                            
                            Spacer()
                            
                            iconView(currentWeather.description, label: String.localizedStringWithFormat("%.0f° \n max", currentWeather.tempHigh))
                        }
                        .padding(.horizontal)
                        
                        LabelledDivider(label: "", horizontalPadding: -10, color: .white)
                            .glow(color: .white, radius: 1)
                            .frame(maxWidth : getRect().width)
                        
                        ForEach(forecast) { list in
                            HStack(spacing: 0) {
                                CustomRow {
                                    Text(dayExtractor(list.date))
                                        .font(.caption)
                                        .padding(.leading)
                                        .frame(maxWidth: 150, alignment: .leading)
                                } center: {
                                    iconView(list.description)
                                        .padding(.horizontal)
                                } right: {
                                    Text(String.localizedStringWithFormat("%.0f°", list.tempHigh))
                                        .padding(.trailing)
                                }
                            }
                            .frame(maxWidth: getRect().width)
                        }
                    }
                    .frame(maxWidth: getRect().width, maxHeight: getRect().height * 0.55, alignment: .top)
                    //background here
                    .background (
                        backgroundChooser(currentWeather.description)
                    )
                }
                .frame(maxWidth: getRect().width, maxHeight: getRect().height)
            }
            .frame(maxWidth: getRect().width, maxHeight: getRect().height)
            .background (
                backgroundChooser(currentWeather.description)
            )
        } else {
            VStack {
                ErrorView(error: APIError.decodingError){/*weatherViewModel.getForecast()*/}
                //PlaceholderImageView()
            }
            
        }
        
    }
    
    @ViewBuilder func iconView(_ weatherMainStringValue: String, label: String = "") -> some View {
        if weatherMainStringValue.contains("clear") {
            customLabel(label, "clear")
        }
        
        if weatherMainStringValue.contains("rain") {
            customLabel(label, "rain")
        }
        
        if weatherMainStringValue.contains("cloud") {
            customLabel(label, "partlysunny")
        }
    }
    
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

struct WeatherSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherSuccessView(weatherData: WeatherManager.shared.weatherData)
    }
}
