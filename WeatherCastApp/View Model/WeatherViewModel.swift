//
//  WeatherViewModel.swift
//  WeatherCastApp
//
//  Created by Sarah on 24/08/2024.
//

import Foundation
import SwiftUI


class WeatherViewModel: ObservableObject {
    
    @Published var locationName: String = " "
    @Published var currentTemperature: String = " "
    @Published var weatherCondition: String = " "
    @Published var maxTemp: String = " "
    @Published var minTemp: String = " "
    @Published var conditionIcon: String = " "
    
    @Published var forecastDays: [ForecastDay] = []
    
    @Published var visibility: String = " "
    @Published var humidity: String = " "
    @Published var feelsLike: String = " "
    @Published var pressure: String = " "
    
    
    private let weatherService: WeatherServiceProtocol
    
    
    init(weatherService: WeatherServiceProtocol = WeatherService()) {
        self.weatherService = weatherService
        fetchWeather()
    }
    
    
    func fetchWeather() {
        
        weatherService.fetchWeather { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherResponse):
                    self?.locationName = weatherResponse.location.name
                    self?.currentTemperature = "\(CShort(weatherResponse.current.temp_c))°"
                    self?.weatherCondition = "\(weatherResponse.current.condition.text)"
                    self?.maxTemp = "\(CShort(weatherResponse.forecast.forecastday[0].day.maxtemp_c))°"
                    self?.minTemp = "\(CShort(weatherResponse.forecast.forecastday[0].day.mintemp_c))°" 
                    self?.conditionIcon = weatherResponse.current.condition.icon
                    self?.forecastDays = weatherResponse.forecast.forecastday
                    self?.visibility = "\(weatherResponse.current.vis_km) km"
                    self?.humidity = "\(weatherResponse.current.humidity)%"
                    self?.feelsLike = "\(weatherResponse.current.feelslike_c)°"
                    self?.pressure = "\(weatherResponse.current.pressure_mb)"
                    
                case .failure(let error):
                    print("Error fetching weather data: \(error.localizedDescription)")
                }
            }
        }
    }
    
    
    
    func showDayName(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: dateString) else {
            return dateString
        }
        
        let calendar = Calendar.current
        if calendar.isDateInToday(date) {
            return "Today"
        } else {
            let weekdayFormatter = DateFormatter()
            weekdayFormatter.dateFormat = "EEEE"
            return String(weekdayFormatter.string(from: date).prefix(3))
        }
    }
    
    
    func formatHour(from dateTime: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        guard let date = dateFormatter.date(from: dateTime) else {
            return dateTime
        }
        
        let currentDate = Date()
        
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour], from: date)
        let currentComponents = calendar.dateComponents([.year, .month, .day, .hour], from: currentDate)
        
        if dateComponents == currentComponents {
            return "Now"
        }
        
        let hourFormatter = DateFormatter()
        hourFormatter.dateFormat = "h a"
        
        return hourFormatter.string(from: date)
    }
    

    func filterHoursToNowOrFuture(_ hours: [Hour]) -> [Hour] {
           let currentDate = Date()
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" 
           
           return hours.filter { hour in
               if let hourDate = dateFormatter.date(from: hour.time) {
                   return hourDate >= currentDate || Calendar.current.isDate(hourDate, equalTo: currentDate, toGranularity: .hour)
               }
               return false
           }
       }
    
}
