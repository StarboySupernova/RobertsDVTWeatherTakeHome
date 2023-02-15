//
//  ShowFavouritesViewController.swift
//  RobertsDVTWeatherTakeHome
//
//  Created by Simbarashe Dombodzvuku on 2/15/23.
//

import UIKit
import SwiftUI

class ShowFavouritesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let weatherListView = WeatherListView().navigationBarHidden(true)
        let weatherListVC = UIHostingController(rootView: weatherListView)
        self.navigationController?.pushViewController(weatherListVC, animated: true)
    }
    
}
