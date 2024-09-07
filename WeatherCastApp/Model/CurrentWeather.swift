//
//  CurrentWeather.swift
//  WeatherCastApp
//
//  Created by Sarah on 24/08/2024.
//

import Foundation

struct CurrentWeather: Codable {
    
    let temp_c: Double
    let condition: WeatherCondition
    let feelslike_c: Double
    let humidity: Int
    let pressure_mb: Int
    let vis_km: Double
    
}


struct WeatherCondition: Codable {
    let text: String
    let icon: String
}
