//
//  LabelStyle.swift
//  RobertsDVTWeatherTakeHome
//
//  Created by Simbarashe Dombodzvuku on 2/2/23.
//

import Foundation
import SwiftUI

struct CaptionLabelStyle : LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            configuration.icon
                .scaleEffect(0.8, anchor: .center)
                .frame(width: 20, height: 20, alignment: .center)
            configuration.title
        }
        .font(.subheadline)
    }
}
