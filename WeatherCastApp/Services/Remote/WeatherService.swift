//
//  WeatherService.swift
//  WeatherCastApp
//
//  Created by Sarah on 24/08/2024.
//

import Foundation

protocol WeatherServiceProtocol {
    func fetchWeather(completionHandler: @escaping (Result<WeatherResponse, Error>) -> Void)
}


class WeatherService: WeatherServiceProtocol {
    
    func fetchWeather(completionHandler: @escaping(Result<WeatherResponse, Error>) -> Void) {
        let url = "https://api.weatherapi.com/v1/forecast.json?key=f16082b9be1c4408954131519242208&q=cairo&days=3&aqi=yes&alerts=no"
        
        guard let url = URL(string: url) else {
            completionHandler(.failure(URLError(.badURL)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(URLError(.badServerResponse)))
                return
            }
        
            do {
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completionHandler(.success(weatherResponse))
            } catch {
                completionHandler(.failure(error))
            }
        }
        
        task.resume()
        
    }
}
