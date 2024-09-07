//
//  HourlyForecastView.swift
//  WeatherCastApp
//
//  Created by Sarah on 24/08/2024.
//

import SwiftUI

struct HourlyForecastView: View {
    let hours: [Hour]
    @ObservedObject var viewModel = WeatherViewModel()
    
    var body: some View {
        
        ZStack {
            Image(BackgroundManager.backgroundImage())
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            let filteredHours = viewModel.filterHoursToNowOrFuture(hours)
            
            List(filteredHours, id: \.time) { hour in                    HStack(alignment: .center, spacing: 1.0) {
                Text(viewModel.formatHour(from: hour.time))
                    .font(.title2)
                Spacer()
                AsyncImage(url: URL(string: "https:\(hour.condition.icon)")) { image in
                    image
                        .resizable()
                        .frame(width: 50, height: 50)
                } placeholder: {
                    Image(.default).hidden()
                    ProgressView()
                }
                Spacer()
                Text("\(String(format: "%.f", hour.temp_c))°")
                    .font(.title2)
            }
                  .listRowBackground(Color.clear)
            .foregroundColor(BackgroundManager.fontColor())
            }
            .padding(.horizontal, 50.0)
            .listStyle(PlainListStyle())
            .listRowBackground(Color.clear)
            .foregroundColor(BackgroundManager.fontColor())
        }
    }
}


struct HourlyForecastView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleHours = [
            Hour(time: "10:00 AM", temp_c: 20.0, condition: WeatherCondition(text: "Sunny", icon: "//cdn.weatherapi.com/weather/64x64/day/113.png"))
        ]
        HourlyForecastView(hours: sampleHours)
    }
}


