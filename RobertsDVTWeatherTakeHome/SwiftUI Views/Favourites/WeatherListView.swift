//
//  WeatherListView.swift
//  RobertsDVTWeatherTakeHome
//
//  Created by Simbarashe Dombodzvuku on 2/12/23.
//

import SwiftUI

/*
 struct WeatherListView: View {
    @State private var searchText = ""
        
    var searchResults: [Forecast]? {
        let userDefaults = UserDefaults.standard
        let fetchedForecast: Forecast?
        do {
            try fetchedForecast = userDefaults.getObject(forKey: searchText, castTo: Forecast.self)
        } catch {
            showErrorAlertView("Error", "City not found", handler: {})
        }
        if searchText.isEmpty {
            return nil
        } else {
            return Forecast.cities.filter { $0.location.contains(searchText) }
        }
    }
    
    var body: some View {
        ZStack {
            // MARK: Background
            Color.background
                .ignoresSafeArea()
            
            // MARK: Weather Widgets
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    ForEach(searchResults) { forecast in
                        WeatherWidget(forecast: forecast)
                    }
                }
            }
            .safeAreaInset(edge: .top) { //might want to remove this to allow content to go underneath the custom nav bar in future designs
                EmptyView()
                    .frame(height: 110)
            }
        }
        .navigationBarHidden(true)
        //.searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search for a city or airport")
    }
}

struct WeatherListView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherListView()
    }
}
 */
