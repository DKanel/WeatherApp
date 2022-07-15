//
//  SheetView.swift
//  WeatherApp
//
//  Created by MSENSIS on 12/7/22.
//

import SwiftUI
import RxSwift
import CoreLocation

struct SheetView: View {
    
    let athens = CLLocation(latitude: 37.983810, longitude: 23.727539)
    let berlin = CLLocation(latitude: 52.52, longitude: 13.41)
    let paris = CLLocation(latitude: 48.8567, longitude: 2.3510)
    let london = CLLocation(latitude: 51.5002, longitude: 0.1262)
    let weatherVM = WeatherViewModel()
    @State var previousCity: Cities.city = .Athens
    @Binding var currentCity: String
    @Binding var temperature: String
    @Binding var temperaturesMaxArray: Array<String>
    @Binding var temperaturesMinArray: Array<String>
    @Binding var imagesNameArray: Array<String>
    @Binding var colorForNextDayImages: Array<Color>
    @Binding var colorForNextDayImages2: Array<Color>
    @Binding var imageName: String
    @Binding var imageColor: Color?
    @Binding var imageColor2: Color?
    @Binding var offset: CGFloat
    @Binding var lastOffset: CGFloat
    
    var body: some View {
        ZStack{
            VStack{
                Text("Drag to choose the city you want to see!")
                HStack(spacing: 20){
                    //Athens Button
                    VStack{
                        Button(action: {
                            setCity(urlIndex: Cities.city.Athens, selectedCity: athens)
                            previousCity = Cities.city.Athens
                            withAnimation {
                                offset = 0
                                lastOffset = 0
                            }
                            
                        })
                        {
                            Image(systemName: "a.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.gray)
//                                .background(BlurView(style: .dark))
//                                .clipShape(Circle())
                        }
                        Text("Athens")
                    }
                    //Berlin
                    VStack{
                        Button(action: {
                            setCity(urlIndex: Cities.city.Berlin, selectedCity: berlin)
                            previousCity = Cities.city.Berlin
                            withAnimation {
                                offset = 0
                                lastOffset = 0
                            }
                        })
                        {
                            Image(systemName: "b.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.purple)
//                                .background(BlurView(style: .dark))
//                                .clipShape(Circle())
                        }
                        Text("Berlin")
                    }
                    //Paris Button
                    VStack{
                        Button(action: {
                            setCity(urlIndex: Cities.city.Paris, selectedCity: paris)
                            previousCity = Cities.city.Paris
                            withAnimation {
                                offset = 0
                                lastOffset = 0
                            }
                        })
                        {
                            if #available(iOS 15.0, *) {
                                Image(systemName: "p.circle.fill")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.teal)
                            } else {
                                // Fallback on earlier versions
                            }
//                                .background(BlurView(style: .dark))
//                                .clipShape(Circle())
                        }
                        Text("Paris")
                    }
                    //London Button
                    VStack{
                        Button(action: {
                            setCity(urlIndex: Cities.city.London, selectedCity: london)
                            previousCity = Cities.city.London
                            withAnimation {
                                offset = 0
                                lastOffset = 0
                            }
                        })
                        {
                            if #available(iOS 15.0, *) {
                                Image(systemName: "l.circle.fill")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.brown)
                            } else {
                                // Fallback on earlier versions
                            }
//                                .background(BlurView(style: .dark))
//                                .clipShape(Circle())
                        }
                        Text("London")
                    }
                }
            }
        }
    }
    
    func setCity(urlIndex: Cities.city, selectedCity: CLLocation){
        if previousCity != urlIndex{
            weatherVM.getAddress(location: selectedCity) { city in
                currentCity = city
            }
            
            weatherVM.getWeather(urlIndex: urlIndex) { weather in
                
                weatherVM.getCurrentTemperature(urlIndexForCurrentTemperature: urlIndex) { response in
                    temperature = String(response.currentWeather)
                }
                
                
                let rainny = weatherVM.getWeatherType()
                if rainny == true{
                    imageName = "cloud.rain.fill"
                    imageColor = .blue
                    imageColor2 = .gray
                }else{
                    imageName = "sun.max.fill"
                    imageColor = .yellow
                    imageColor2 = .yellow
                }
                
                let nextDaysTemperatureMax = weatherVM.getNextDaysMaxTemperature()
                var numberIndexForTemperaturesMax = 0
                for temperature in nextDaysTemperatureMax{
                    temperaturesMaxArray[numberIndexForTemperaturesMax] = String(temperature.temperature)
                    numberIndexForTemperaturesMax = numberIndexForTemperaturesMax + 1
                }
                
                let nextDaysTemperatureMin = weatherVM.getNextDaysMinTemperature()
                var numberIndexForTemperaturesMin = 0
                for temperature in nextDaysTemperatureMin{
                    temperaturesMinArray[numberIndexForTemperaturesMin] = String(temperature.temperature)
                    numberIndexForTemperaturesMin = numberIndexForTemperaturesMin + 1
                }
                
                let rainInNextDays = weatherVM.getNextDaysWeatherType()
                var numberIndexForRains = 0
                for rain in rainInNextDays{
                    if rain.rains > 0{
                        imagesNameArray[numberIndexForRains] = "cloud.rain.fill"
                        colorForNextDayImages[numberIndexForRains] = Color.gray
                        colorForNextDayImages2[numberIndexForRains] = Color.blue
                        numberIndexForRains = numberIndexForRains + 1
                    }else{
                        imagesNameArray[numberIndexForRains] = "sun.max.fill"
                        colorForNextDayImages[numberIndexForRains] = Color.yellow
                        colorForNextDayImages2[numberIndexForRains] = Color.yellow
                        numberIndexForRains = numberIndexForRains + 1
                    }
                }
            }
        }
    }
}
