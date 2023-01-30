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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heroCardView.layer.cornerCurve = .continuous
        heroCardView.layer.cornerRadius = 30
        blurView.layer.cornerCurve = .continuous
        blurView.layer.cornerRadius = 30
        blurView.layer.masksToBounds = true // Without this line, we are not able to see the corner radius
        
        heroCardView.layer.shadowColor = UIColor(named: "Shadow")!.cgColor
        heroCardView.layer.shadowOpacity = 0.5
        heroCardView.layer.shadowOffset = CGSize(width: 0, height: 10)
        heroCardView.layer.shadowRadius = 20
    }
    
    
}

