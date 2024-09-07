//
//  Forecast.swift
//  WeatherCastApp
//
//  Created by Sarah on 24/08/2024.
//

import Foundation

struct Forecast: Codable {
    let forecastday: [ForecastDay]
}


struct ForecastDay: Codable {
    let date: String
    let day: Day
    let hour: [Hour]
}


struct Day: Codable {
    let maxtemp_c: Double
    let mintemp_c: Double
    let condition: WeatherCondition
}


struct Hour: Codable {
    let time: String
    let temp_c: Double
    let condition: WeatherCondition
}
