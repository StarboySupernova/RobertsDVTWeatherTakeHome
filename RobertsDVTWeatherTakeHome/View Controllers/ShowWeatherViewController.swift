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
    #warning("use intialize5r from yt vid")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //let button = UIButton(frame: CGRect(x: 0, y: 0, width: 220, height: 50))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let weatherVC = segue.destination as? WeatherViewHostingController/*, let weather = sender as? WeatherData*/ {
            let sender = sender as! WeatherData
            weatherVC.dependency = sender
            print("Preparation for weather vc successful")
        }
    }
    
    @IBAction func showWeather(_ sender: UIButton) {
        #warning("try self as sender here")
        performSegue(withIdentifier: "presentWeather", sender: weatherData)
        /*let weatherData: WeatherData = WeatherData()
        let weatherView = WeatherSuccessView(weatherData: weatherData)
        let vc = UIHostingController(rootView: weatherView)
        self.navigationController?.pushViewController(vc, animated: true)*/
    }
}
