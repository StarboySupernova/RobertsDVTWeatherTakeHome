//
//  CustomImageView.swift
//  UIKit for iOS 15
//
//  Created by Simbarashe Dombodzvuku on 1/31/23.
//

import UIKit

@IBDesignable
class CustomImageView: UIImageView {
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.cornerCurve = .continuous
            layer.masksToBounds = true
        }
    }
}
