//
//  ViewController.swift
//  RobertsDVTWeatherTakeHome
//
//  Created by Simbarashe Dombodzvuku on 1/30/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var heroCardView: UIView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet var sampleWeatherCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //reading its data and delegate methods from the current class
        sampleWeatherCollectionView.delegate = self
        sampleWeatherCollectionView.dataSource = self
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2 //cells
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LeadCell", for: indexPath) as! WeatherHeaderCollectionViewCell

        cell.titleLabel.text = "SwiftUI Handbook"
        cell.subtitleLabel.text = "20 SECTIONS - 3 HOURS"
        cell.descriptionLabel.text = "Learn about all the basics of SwiftUI"
        cell.gradient.colors = [UIColor.red.cgColor, UIColor.systemPink.cgColor]
        cell.logo.image = UIImage(named: "Logo React")
        cell.banner.image = UIImage(named: "Illustration 2")

        return cell    }

}

