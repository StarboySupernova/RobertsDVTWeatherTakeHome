//
//  ForecastView.swift
//  RobertsDVTWeatherTakeHome
//
//  Created by Simbarashe Dombodzvuku on 2/12/23.
//

import SwiftUI

struct ForecastView: View {
    @State private var selection = 0
    var bottomSheetTranslationProrated: CGFloat = 1
    var forecast: Forecast
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // MARK: Segmented Control
                SegmentedControl(selection: $selection)
                
                // MARK: Forecast Cards
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        if selection == 0 {
                            if let hourly = hourlyForecast(forecast: forecast) {
                                ForEach(hourly) { hour in
                                    ForecastCard(forecast: forecast, forecastPeriod: .hourly, hourly: hour)
                                }
                            } else {
                                ProgressView()
                            }
                        } else {
                            if let weatherList = forecastResultStrip(forecast: forecast) {
                                ForEach(weatherList) { daily in
                                    ForecastCard(forecast: forecast, forecastPeriod: .daily, daily: daily)
                                }
                            } else {
                                ProgressView()
                            }
                        }
                    }
                    .padding(.vertical, 20)
                }
                .padding(.horizontal, 20)
                
                // MARK: Forecast Widgets
                Image("Forecast Widgets")
                    .opacity(bottomSheetTranslationProrated)
            }
            
        }
        .backgroundBlur(radius: 25, opaque: true)
        .background(Color.bottomSheetBackground)
        .clipShape(RoundedRectangle(cornerRadius: 44))
        .innerShadow(shape: RoundedRectangle(cornerRadius: 44), color: Color.bottomSheetBorderMiddle, lineWidth: 1, offsetX: 0, offsetY: 1, blur: 0, blendMode: .overlay, opacity: 1 - bottomSheetTranslationProrated)
        .overlay {
            // MARK: Bottom Sheet Separator
            Divider()
                .blendMode(.overlay)
                .background(Color.bottomSheetBorderTop)
                .frame(maxHeight: .infinity, alignment: .top)
                .clipShape(RoundedRectangle(cornerRadius: 44))
        }
        .overlay {
            // MARK: Drag Indicator
            RoundedRectangle(cornerRadius: 10)
                .fill(.black.opacity(0.3))
                .frame(width: 48, height: 5)
                .frame(height: 20)
                .frame(maxHeight: .infinity, alignment: .top)
        }
    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        //ForecastView()
        EmptyView()
    }
}
