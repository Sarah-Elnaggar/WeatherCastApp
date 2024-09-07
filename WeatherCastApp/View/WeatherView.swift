//
//  WeatherView.swift
//  WeatherCastApp
//
//  Created by Sarah on 24/08/2024.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel = WeatherViewModel()
    
    var body: some View {
        NavigationView {
            
            ZStack {
                Image(BackgroundManager.backgroundImage())
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .center) {
                    
                    Spacer()
                    
                    VStack {
                        Text(viewModel.locationName)
                            .font(.title)
                            .dynamicTypeSize(.xxxLarge)
                            .fontWeight(.medium)
                        Text(viewModel.currentTemperature)
                            .font(.largeTitle)
                            .dynamicTypeSize(.accessibility5)
                            .fontWeight(.regular)
                        Text(viewModel.weatherCondition)
                            .font(.title2)
                        HStack {
                            Text("H: \(viewModel.maxTemp)")
                            Text("L: \(viewModel.minTemp)")
                        }
                        AsyncImage(url: URL(string: "https:\(viewModel.conditionIcon)")) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    .padding()
                    .foregroundColor(BackgroundManager.fontColor())
                    
                    Spacer()
                    
                    VStack(alignment:.leading) {
                        Text("3-DAY FORECAST")
                            .font(.headline)
                        
                        Divider().background(BackgroundManager.fontColor())
                 
                        ForEach(viewModel.forecastDays, id: \.date) { day in
                            NavigationLink(destination: HourlyForecastView(hours: day.hour)) {
                                HStack {
                                    Text(viewModel.showDayName(from: day.date))
                                        .lineLimit(nil)
                                    Spacer()
                                    AsyncImage(url: URL(string: "https:\(day.day.condition.icon)")) { image in
                                        image
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .padding(.trailing, 20.0)
                                    Text("\(String(format: "%.1f", day.day.mintemp_c))° - \(String(format: "%.1f", day.day.maxtemp_c))°")
                                }
                            }
                            Divider().background(BackgroundManager.fontColor())
                        }
                        
                    }
                    
                    .padding(.horizontal, 70.0)
                    .frame(width: 400, height: 200, alignment: .center)
                    .foregroundColor(BackgroundManager.fontColor())
                    
                    Spacer()
                    
                    HStack(alignment: .center) {
                        VStack(alignment: .center) {
                            VStack {
                                Text("VISIBILITY")
                                    .font(.caption)
                                Text(viewModel.visibility)
                                    .font(.largeTitle)
                            }
                            .padding()
                            
                            VStack {
                                Text("FEELS LIKE")
                                    .font(.caption)
                                Text(viewModel.feelsLike)
                                    .font(.largeTitle)
                            }
                            .padding()
                        }
                        .padding()

                        VStack(alignment: .center) {
                            VStack {
                                Text("HUMIDITY")
                                    .font(.caption)
                                Text(viewModel.humidity)
                                    .font(.largeTitle)
                            }
                            .padding()
                            
                            VStack {
                                Text("PRESSURE")
                                    .font(.caption)
                                Text(viewModel.pressure)
                                    .font(.largeTitle)
                            }
                            .padding()
                        }
                        .padding()
                    }
                    .padding()
                    .foregroundColor(BackgroundManager.fontColor())
                }
            }
        }
    }
}



#Preview {
    WeatherView()
}
