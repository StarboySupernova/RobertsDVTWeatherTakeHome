//
//  WeatherDisplayViewController.swift
//  RobertsDVTWeatherTakeHome
//
//  Created by Simbarashe Dombodzvuku on 1/30/23.
//

import UIKit
import Combine

class WeatherDisplayViewController: UIViewController {
    
    @IBOutlet var heroCardView: UIView!
    @IBOutlet var blurView: UIVisualEffectView!
    @IBOutlet var sampleWeatherCollectionView: UICollectionView!
    @IBOutlet var weatherDisplayTableView: UITableView!
    @IBOutlet var tableViewHeight: NSLayoutConstraint!
    
    private var tokens: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //reading its data and delegate methods from the current class
        sampleWeatherCollectionView.delegate = self
        sampleWeatherCollectionView.dataSource = self
        
        //cell shadows should not be cut off by the bounds of the collection view
        sampleWeatherCollectionView.layer.masksToBounds = false
        
        weatherDisplayTableView.delegate = self
        weatherDisplayTableView.dataSource = self
        weatherDisplayTableView.layer.masksToBounds = false
     
        //dynamic cell height
        weatherDisplayTableView.publisher(for: \.contentSize)
            .sink { newContentSize in
                self.tableViewHeight.constant = newContentSize.height
            }
            .store(in: &tokens)
    }
}

extension WeatherDisplayViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return handbooks.count //cells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LeadCell", for: indexPath) as! WeatherHeaderCollectionViewCell
        
        let handbook = handbooks[indexPath.item]
        
        cell.titleLabel.text = handbook.courseTitle
        cell.subtitleLabel.text = handbook.courseSubtitle
        cell.descriptionLabel.text = handbook.courseDescription
        cell.gradient.colors = handbook.courseGradient
        cell.logo.image = handbook.courseIcon
        cell.banner.image = handbook.courseBanner
        
        return cell
    }
    
}

extension WeatherDisplayViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return courses.count //using handbooks here works but courses will not
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherDisplayTableCell", for: indexPath) as! WeatherDisplayTableViewCell
        let sampleWeather = courses[indexPath.section]
        
        cell.titleLabel.text = sampleWeather.courseTitle //not showing
        //cell.subtitleLabel.text = course.courseSubtitle
        cell.descriptionLabel.text = sampleWeather.courseDescription //not showing
        cell.weatherBackground.image = sampleWeather.courseBackground
        cell.weatherBanner.image = sampleWeather.courseBanner //not showing
        cell.icon.image = sampleWeather.courseIcon //not showing
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        
        return 20 //height
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0 //footer
    }
}

