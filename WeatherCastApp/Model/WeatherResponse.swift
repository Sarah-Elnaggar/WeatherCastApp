//
//  WeatherResponse.swift
//  WeatherCastApp
//
//  Created by Sarah on 24/08/2024.
//

import Foundation

struct WeatherResponse: Codable {
    
    let location: Location
    let current: CurrentWeather
    let forecast: Forecast
    
}
