//
//  ShowWeatherViewController.swift
//  RobertsDVTWeatherTakeHome
//
//  Created by Simbarashe Dombodzvuku on 2/4/23.
//

import UIKit
import SwiftUI

class ShowWeatherViewController: UIViewController {
    var weatherData : WeatherData?
    var city: City?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //let button = UIButton(frame: CGRect(x: 0, y: 0, width: 220, height: 50))
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let weatherVC = segue.destination as? WeatherViewHostingController/*, let weather = sender as? WeatherData*/ {
            let sender = sender as! ShowWeatherViewController
            weatherVC.dependency = WeatherManager.shared.loadForecastData(for: (city ?? weatherData?.cities.first)!)
            print("Preparation for weather vc successful")
        }
    }
    
    @IBAction func showWeather(_ sender: UIButton) {
        performSegue(withIdentifier: "presentWeather", sender: self)
        /*let weatherData: WeatherData = WeatherData()
        let weatherView = WeatherSuccessView(weatherData: weatherData)
        let vc = UIHostingController(rootView: weatherView)
        self.navigationController?.pushViewController(vc, animated: true)*/
    }
}
