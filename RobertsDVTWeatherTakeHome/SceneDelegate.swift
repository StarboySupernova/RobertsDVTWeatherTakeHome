//
//  SceneDelegate.swift
//  RobertsDVTWeatherTakeHome
//
//  Created by Simbarashe Dombodzvuku on 1/30/23.
//

import UIKit
import SwiftUI
import CoreLocation

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    /*let DEFAULT_CITIES : [City] = [
        City(id: 0, name: "My Location", latitude: 0, longitude: 0),
//        City(id: 1,name: "Frankfurt", latitude: 50.11630522359943, longitude: 8.683179487766711),
//        City(id: 2,name: "Paris", latitude: 48.85345575326961, longitude: 2.3500839018335804),
//        City(id: 3,name: "Budapest", latitude: 47.51777591723693, longitude: 19.046526389932264),
//    City(id: 4,name: "London", latitude: 51.496936024546535, longitude: -0.12289001864225133)
    ]*/

    var window: UIWindow?
    //let locationManager = CLLocationManager()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        //setupCityDefaults() //MARK: dummy array
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    //MARK: - Custom Methods
   /* private func setupCityDefaults(){
        let defaults = UserDefaults(suiteName: K.appGroupBundleId)!
        
        let launchedBefore = defaults.bool(forKey: K.launchedBeforeKey)
        if !launchedBefore{
            do{
                let encoder = JSONEncoder()
                let cities = try encoder.encode(DEFAULT_CITIES)
                defaults.set(true, forKey: K.launchedBeforeKey)
                defaults.set(cities,forKey: K.savedCitiesKey)
            }catch{
                print("Unable to encode dummy cities array")
            }
        }
    }*/
}

//MARK: - CLLocationManagerDelegate Conformance

/*extension SceneDelegate: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { placemarks, error in
                if error == nil{
                    //let firstLocation = placemarks?[0]
                    //let cityName = firstLocation?.locality ?? "My Location"
                    //WeatherManager.shared.weatherData?.updateMyLocation(city: cityName, latitude: latitude, longitude: longitude)
                    //WeatherManager.shared.loadAllData()
                    print("Scene delegate success")
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}*/

