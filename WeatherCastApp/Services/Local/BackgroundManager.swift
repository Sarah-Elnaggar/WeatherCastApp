//
//  BackgroundManager.swift
//  WeatherCastApp
//
//  Created by Sarah on 24/08/2024.
//

import Foundation
import SwiftUI

class BackgroundManager {
    
    static func backgroundImage() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        if hour >= 5 && hour < 18 {
            return "morning_background"
        } else {
            return "evening_background"
        }
    }
    
    static func fontColor() -> Color {
        let hour = Calendar.current.component(.hour, from: Date())
        if hour >= 5 && hour < 18 {
            return .black
        } else {
            return .white
        }
    }
}
