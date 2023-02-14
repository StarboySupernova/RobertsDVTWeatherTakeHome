//
//  ForecastCard.swift
//  RobertsDVTWeatherTakeHome
//
//  Created by Simbarashe Dombodzvuku on 2/12/23.
//

import SwiftUI

struct ForecastCard: View {
    var forecast: Forecast
    var forecastPeriod: ForecastPeriod
    var hourly: HourlyForecast?
    var daily: CustomForecast?
    var isActive: Bool {
        //TODO: Refactor and make this more optimal
        if forecastPeriod == ForecastPeriod.hourly {
            if let hourlyForecast = hourlyForecast(forecast: forecast) {
                let isThisHour = Calendar.current.isDate(.now, equalTo: getDateFromUnixTimestamp(timestamp: hourlyForecast.first!.unixTime), toGranularity: .hour)
                return isThisHour
            }
        } else {
            if let weatherList = forecastResultStrip(forecast: forecast) {
                let isToday = Calendar.current.isDate(.now, equalTo: weatherList.first!.date, toGranularity: .day)
                return isToday
            }
        }
        // Return a default value in case none of the if or else conditions are met
        return false
    }
    
    var body: some View {
        ZStack {
            // MARK: Card
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.forecastCardBackground.opacity(isActive ? 1 : 0.2))
                .frame(width: 60, height: 146)
                .shadow(color: .black.opacity(0.25), radius: 10, x: 5, y: 4)
                .overlay {
                    // MARK: Card Border
                    RoundedRectangle(cornerRadius: 30)
                        .strokeBorder(.white.opacity(isActive ? 0.5 : 0.2))
                        .blendMode(.overlay)
                }
                .innerShadow(shape: RoundedRectangle(cornerRadius: 30), color: .white.opacity(0.25), lineWidth: 1, offsetX: 1, offsetY: 1, blur: 0, blendMode: .overlay)
            
            // MARK: Content
            VStack(spacing: 16) {
                // MARK: Forecast Date
                Text(self.hourly != nil ? hourly!.date : daily!.date, format: forecastPeriod == ForecastPeriod.hourly ? .dateTime.hour() : .dateTime.weekday())
                    .font(.subheadline.weight(.semibold))
                
                VStack(spacing: -4) {
                    // MARK: Forecast Small Icon
                    #warning("fix this. Likely by making hourly forecast and CustomForecast provide descriptions")
                    Image("\(forecast.list.first!.weather.first!.main) small")
                }
                .frame(height: 42)
                
                // MARK: Forecast Temperature
                Text("\(self.hourly != nil ? hourly!.temp : daily!.maxTemp)°")
                    .font(.title3)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 16)
            .frame(width: 60, height: 146)
        }

    }
}

/*
struct ForecastCard_Previews: PreviewProvider {
    static var previews: some View {
        ForecastCard(forecast: Forecast.hourly[0], forecastPeriod: .hourly)
    }
}
 */
