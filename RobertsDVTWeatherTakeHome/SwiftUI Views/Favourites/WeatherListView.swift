//
//  WeatherListView.swift
//  RobertsDVTWeatherTakeHome
//
//  Created by Simbarashe Dombodzvuku on 2/12/23.
//

import SwiftUI

#warning("should come first")
 struct WeatherListView: View {
    @EnvironmentObject var weatherViewModel: WeatherViewModelImplementation
    @EnvironmentObject var locationViewModel: LocationViewModel
    @State private var searchText = ""
    @State private var showSheet: Bool = false
        
    var searchResults: [Forecast]? {
        let userDefaults = UserDefaults.standard
        let fetchedForecasts: Set<Forecast>
        do {
            try fetchedForecasts = userDefaults.getObject(forKey: "savedLocations", castTo: Set<Forecast>.self)
        } catch {
            showErrorAlertView("Error", "City not found", handler: {})
            return nil
        }
        
        if searchText.isEmpty {
            return Array(fetchedForecasts)
        } else {
            return fetchedForecasts.filter { $0.city.name.contains(searchText) }
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
                    if searchResults != nil {
                        ForEach(searchResults!) { forecast in
                            WeatherWidget(forecast: forecast)
                                .onTapGesture {
                                    showSheet = true
                                    LocationViewModel.locationProvider(latitude: forecast.city.coord.lat, longitude: forecast.city.coord.lon)
                                }
                                .contentShape(Rectangle())
                                .sheet(isPresented: $showSheet) {
                                    showSheet = false
                                } content: {
                                    FavouritesView(latitude: forecast.city.coord.lat, longitude: forecast.city.coord.lon)
                                }
                        }
                    } else {
                        ProgressView()
                    }
                }
            }
            .safeAreaInset(edge: .top) { //might want to remove this to allow content to go underneath the custom nav bar in future designs
                EmptyView()
                    .frame(height: 110)
            }
        }
        .overlay {
            // MARK: Navigation Bar
            NavigationBar(searchText: $searchText)
        }
        .navigationBarHidden(true)
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search favourites for a city")
    }
}

struct WeatherListView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherListView()
    }
}
 
