//
//  WeatherWidget.swift
//  RobertsDVTWeatherTakeHome
//
//  Created by Simbarashe Dombodzvuku on 2/12/23.
//

import SwiftUI

struct WeatherWidget: View {
    var forecast: Forecast
    
    var body: some View {
        if let weatherList = hourlyForecast(forecast: forecast) {
            ZStack(alignment: .bottom) {
                // MARK: Trapezoid
                Trapezoid()
                    .fill(Color.weatherWidgetBackground)
                    .frame(width: 342, height: 174)
                
                // MARK: Content
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 8) {
                        // MARK: Forecast Temperature
                        Text("\(weatherList.first!.temp)°")
                            .font(.system(size: 64))
                        
                        VStack(alignment: .leading, spacing: 2) {
                            // MARK: Forecast Temperature Range
                            Text("H:\(weatherList.first!.temp)°  L:\(weatherList.first!.temp)°")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                            
                            // MARK: Forecast Location
                            #warning("Location here")
                            Text(weatherList.first!.description)
                                .font(.body)
                                .lineLimit(1)
                        }
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 0) {
                        // MARK: Forecast Large Icon
                        widgetIconView(weatherList.first!.description, label: "String")
                            .padding(.trailing, 4)
                        
                        // MARK: Weather
                        Text(forecast.list.first!.weather.first!.main)
                            .font(.footnote)
                            .padding(.trailing, 24)
                    }
                }
                .foregroundColor(.white)
                .padding(.bottom, 20)
                .padding(.leading, 20)
            }
            .frame(width: 342, height: 184, alignment: .bottom)
        }
    }
    
    @ViewBuilder func widgetIconView(_ weatherMainStringValue: String, label: String = "") -> some View {
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
                    Image("Tornado large")
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
                    Image("Moon cloud mid rain large")
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
                    Image("Moon cloud fast wind large")
                        .resizable()
                        .scaledToFit()
                }
                .labelStyle(CaptionLabelStyle())
        }
    }

}

struct WeatherWidget_Previews: PreviewProvider {
    static var previews: some View {
        //WeatherWidget(forecast: Forecast)
        EmptyView()
            .preferredColorScheme(.dark)
    }
}
