//
//  General Helpers.swift
//  RobertsDVTWeatherTakeHome
//
//  Created by Simbarashe Dombodzvuku on 2/7/23.
//

import Foundation
import SwiftUI

//MARK: Fourth Approach - forecastResultStrip
func forecastResultStrip(forecast: Forecast) -> [CustomForecast]? {
    var final: [CustomForecast] = []
    let forecastsByDate = Dictionary(grouping: forecast.list, by: {$0.dateWoTime})
    for (date, forecastResult) in forecastsByDate{
        let avgTemp = forecastResult.map { each in each.main.temp }.average
        let avgTempLow = forecastResult.map { each in return each.main.tempMin }.average
        let avgTempHigh = forecastResult.map { each in return each.main.tempMax }.maximumValue
        let desc = forecastResult.map { each in return each.weather.last!.main }.mostFrequent()
        final.append(CustomForecast(date: date!, description: desc!, maxTemp: avgTempHigh, minTemp: avgTempLow, temp: avgTemp))
    }
    final = final.sorted(by: {$0.date.compare($1.date) == .orderedAscending})
    
    return final
}

/*func forecastResultStrip(forecast: Forecast) -> [WeatherList]? {
    
    //MARK: first approach
    var times : [Int] = []
    
    var firstDay : [Int] = []
    var secondDay : [Int] = []
    var thirdDay : [Int] = []
    var fourthDay : [Int] = []
    var fifthDay : [Int] = []

    let currentWeatherTime = forecast.list.first {
        Date(timeIntervalSince1970: TimeInterval($0.dt)) > Date.now
    }
    
    guard currentWeatherTime != nil else {
        return nil
    }
    
    for i in stride(from: TimeInterval(currentWeatherTime!.dt), through: Date(timeIntervalSince1970: TimeInterval(currentWeatherTime!.dt + 432_000)).timeIntervalSince1970, by: 86_400) {
        times.append(Int(i))
    }
    
    //print("this is times now",times)
        
    let res = forecast.list.filter({ weatherList in
        times.contains(weatherList.dt)
    })
    
    //MARK: Third approach
    var final: [CustomForecast] = []
    let forecastsByDate = Dictionary(grouping: forecast.list, by: {$0.dateWoTime})
    for (date, forecastResult) in forecastsByDate{
        let avgTempLow = forecastResult.map { each in return each.main.tempMax }.average
        let avgTempHigh = forecastResult.map { each in return each.main.tempMin }.average
        //let description = forecastResult.map {each in return each.weather }.mostFrequent() // description to be used in customForecastView
        //final.append(Forecast(date: date!, temp: avgTemp, tempLow: avgTempLow, tempHigh: avgTempHigh, description: description!))
        let desc = forecastResult.map { each in return each.weather[0].main }.mostFrequent()
        final.append(CustomForecast(date: date!, description: desc!, maxTemp: avgTempHigh, minTemp: avgTempLow))
    }
    //final.append(contentsOf: forecast.list)
    //final = final.sorted(by: {$0.date.compare($1.date) == .orderedAscending})
    
    #warning("make an extension in WeatherList for computed object 'date' that returns a date object for dt Int value")
    #warning("extract dateWoTime from each 'date'")
    #warning("now I can group each item in forecast.list, of type WeatherList, with $0.dateWoTime")
    #warning("then use average for that")
        
    /*let _ = print("this is result now", res.map({
        $0.dtTxt
    }))*/
    
    //return res
    
    //MARK: second approach
    for firstDayValue in stride(from: TimeInterval(currentWeatherTime!.dt), through: Date(timeIntervalSince1970: TimeInterval(currentWeatherTime!.dt + 86_400)).timeIntervalSince1970, by: 10_800) {
        firstDay.append(Int(firstDayValue))
    }
    
    for secondDayValue in stride(from: Date(timeIntervalSince1970: TimeInterval(currentWeatherTime!.dt + 86_400)).timeIntervalSince1970, through: Date(timeIntervalSince1970: TimeInterval(currentWeatherTime!.dt + 86_400 * 2)).timeIntervalSince1970, by: 10_800) {
        secondDay.append(Int(secondDayValue))
    }
    
    for thirdDayValue in stride(from: Date(timeIntervalSince1970: TimeInterval(currentWeatherTime!.dt + 86_400 * 2)).timeIntervalSince1970, through: Date(timeIntervalSince1970: TimeInterval(currentWeatherTime!.dt + 86_400 * 3)).timeIntervalSince1970, by: 10_800) {
        thirdDay.append(Int(thirdDayValue))
    }
    
    for fourthDayValue in stride(from: Date(timeIntervalSince1970: TimeInterval(currentWeatherTime!.dt + 86_400 * 3)).timeIntervalSince1970, through: Date(timeIntervalSince1970: TimeInterval(currentWeatherTime!.dt + 86_400 * 4)).timeIntervalSince1970, by: 10_800) {
        fourthDay.append(Int(fourthDayValue))
    }
    
    for fifthDayValue in stride(from: Date(timeIntervalSince1970: TimeInterval(currentWeatherTime!.dt + 86_400 * 4)).timeIntervalSince1970, to: Date(timeIntervalSince1970: TimeInterval(currentWeatherTime!.dt + 432_000)).timeIntervalSince1970, by: 10_800) {
        fifthDay.append(Int(fifthDayValue))
    }
    
    let firstDayMax = firstDay.max()
    let secondDayMax = secondDay.max()
    let thirdDayMax = thirdDay.max()
    let fourthDayMax = fourthDay.max()
    let fifthDayMax = fifthDay.max()
    
    guard firstDayMax != nil, secondDayMax != nil, thirdDayMax != nil, fourthDayMax != nil, fifthDayMax != nil else {
        showErrorAlertView("Error", "Unable to initialize max values", handler: {})
        return nil
    }
    
    let maxArray = [firstDayMax!, secondDayMax!, thirdDayMax!, fourthDayMax!, fifthDayMax!]
    
    let result = forecast.list.filter { weatherList in
        maxArray.contains(weatherList.dt)
    }
    
    return result
}*/

//MARK: Third Approach - forecastResultStrip
/*
 func forecastResultStrip(forecast: Forecast) -> [WeatherList]? {
    // Get the current date
    let now = Date.now
    
    // Find the first weather time in the forecast list where the date is greater than the current date
    let currentWeatherTime = forecast.list.first {
        Date(timeIntervalSince1970: TimeInterval($0.dt)) > now
    }
    
    // If there is no weather time that meets the condition, return nil
    guard let weatherTime = currentWeatherTime else {
        return nil
    }
    
    // Calculate the dt values for each day
    let days = [weatherTime.dt, weatherTime.dt + 86_400, weatherTime.dt + 86_400 * 2, weatherTime.dt + 86_400 * 3, weatherTime.dt + 86_400 * 4]
    let endTime = weatherTime.dt + 432_000
    
    // Calculate the maximum dt value for each day
    let maxValues = (0...4).map { dayIndex -> Int in
        let startTime = days[dayIndex]
        let end = (dayIndex == 4) ? endTime : days[dayIndex + 1]
        return (0...Int((end - startTime) / 10_800)).reduce(startTime) { (maxValue: Int, nextValue: Int) -> Int in
            return max(maxValue, nextValue * 10_800 + startTime)
        }
    }
    
    // If the number of max values is not 5, show an error alert and return nil
    guard maxValues.count == 5 else {
        showErrorAlertView("Error", "Unable to initialize max values", handler: {})
        return nil
    }
    
    // Filter the forecast list to only include weatherList items with a dt value that is in the maxValues array
    let result = forecast.list.filter { weatherList in
        maxValues.contains(weatherList.dt)
    }
    
    // Return the filtered result
    return result
}
*/

//TODO: Refactor this code to take advantage of the prefix and suffix methods on array instead of looping through forecast.list and building the arrays separately
func forecastMinMax(forecast: Forecast) -> (min: Double, max: Double)? {
    // Initialize arrays to store minimum and maximum temperatures
    var maxArray: [Double] = []
    var minArray: [Double] = []

    let index = forecast.list.firstIndex {
        Date(timeIntervalSince1970: TimeInterval($0.dt)) > Date.now
    }

    let finalIndex = forecast.list.firstIndex {
        Date(timeIntervalSince1970: TimeInterval($0.dt)) > Calendar.current.date(byAdding: DateComponents(hour: 24), to: Date.now) ?? Date.now
    }

    // Returning nil
    guard index != nil, finalIndex != nil else {
        return nil
    }

    // Append maximum temperatures from the forecast list to the maxArray
    for max in forecast.list[index!...finalIndex!] {
        maxArray.append(max.main.tempMax)
    }

    // Append minimum temperatures from the forecast list to the minArray
    for min in forecast.list[index!...finalIndex!] {
        minArray.append(min.main.tempMin)
    }

    let max = maxArray.max()

    let min = minArray.min()

    // Returning nil
    guard max != nil, min != nil else {
        return nil
    }

    // Return the calculated minimum and maximum temperatures as a tuple
    return (min!, max!)
}

func hourlyForecast(forecast: Forecast) -> [HourlyForecast]? {
    var final: [HourlyForecast] = []
    let forecasts = forecast.list.prefix(5) //no need for index & range here, we just take the first 5 every time this is called
    for listItem in forecasts {
        let temp = listItem.main.temp
        let description = listItem.weather.last!.main
        let unixTime = listItem.dt
        final.append(HourlyForecast(temp: temp, description: description, unixTime: Double(unixTime)))
    }
    final = final.sorted(by: {$0.unixTime > $1.unixTime})
    return final
}

func showErrorAlertView (_ alertTitle: String, _ alertMessage: String, handler: @escaping () -> Void) {
    let alertView = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
    let ok = UIAlertAction(title: "Continue", style: .cancel) { _ in handler() }
    
    alertView.addAction(ok)
    
    //Presenting
    let scenes = UIApplication.shared.connectedScenes
    let windowScene = scenes.first as? UIWindowScene
    let window = windowScene?.windows.first
    let rootVC = window?.rootViewController
    rootVC?.present(alertView, animated: true)
}

func showSuccessAlertView (_ alertTitle: String, _ alertMessage: String, handler: @escaping () -> Void) {
    let alertView = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
    let ok = UIAlertAction(title: "OK", style: .default) { _ in handler() }
    
    alertView.addAction(ok)
    
    //Presenting
    let scenes = UIApplication.shared.connectedScenes
    let windowScene = scenes.first as? UIWindowScene
    let window = windowScene?.windows.first
    let rootVC = window?.rootViewController
    rootVC?.present(alertView, animated: true)
}

struct Arc: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.minX - 1, y: rect.minY))
        path.addQuadCurve(to: CGPoint(x: rect.maxX + 1, y: rect.minY), control: CGPoint(x: rect.midX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX + 1, y: rect.maxY + 1))
        path.addLine(to: CGPoint(x: rect.minX - 1, y: rect.maxY + 1))
        path.closeSubpath()

        return path
    }
}

//code generated from https://quassum.github.io/SVG-to-SwiftUI/, by copying our Figma design as SVG and converting it to SwiftUI
struct Trapezoid: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0, y: 0.37965*height))
        path.addCurve(to: CGPoint(x: 0.03312*width, y: 0.02995*height), control1: CGPoint(x: 0, y: 0.18083*height), control2: CGPoint(x: 0, y: 0.08142*height))
        path.addCurve(to: CGPoint(x: 0.21492*width, y: 0.04559*height), control1: CGPoint(x: 0.06623*width, y: -0.02153*height), control2: CGPoint(x: 0.1158*width, y: 0.00085*height))
        path.addLine(to: CGPoint(x: 0.9003*width, y: 0.35499*height))
        path.addCurve(to: CGPoint(x: 0.98602*width, y: 0.42173*height), control1: CGPoint(x: 0.94813*width, y: 0.37658*height), control2: CGPoint(x: 0.97204*width, y: 0.38738*height))
        path.addCurve(to: CGPoint(x: width, y: 0.59997*height), control1: CGPoint(x: width, y: 0.45609*height), control2: CGPoint(x: width, y: 0.50405*height))
        path.addLine(to: CGPoint(x: width, y: 0.74857*height))
        path.addCurve(to: CGPoint(x: 0.98116*width, y: 0.96318*height), control1: CGPoint(x: width, y: 0.8671*height), control2: CGPoint(x: width, y: 0.92636*height))
        path.addCurve(to: CGPoint(x: 0.87135*width, y: height), control1: CGPoint(x: 0.96232*width, y: height), control2: CGPoint(x: 0.93199*width, y: height))
        path.addLine(to: CGPoint(x: 0.12865*width, y: height))
        path.addCurve(to: CGPoint(x: 0.01884*width, y: 0.96318*height), control1: CGPoint(x: 0.06801*width, y: height), control2: CGPoint(x: 0.03768*width, y: height))
        path.addCurve(to: CGPoint(x: 0, y: 0.74857*height), control1: CGPoint(x: 0, y: 0.92636*height), control2: CGPoint(x: 0, y: 0.8671*height))
        path.addLine(to: CGPoint(x: 0, y: 0.37965*height))
        path.closeSubpath()
        return path
    }
}

