//
//  SheetViewModel.swift
//  WeatherApp
//
//  Created by MSENSIS on 22/7/22.
//

//import Foundation
//
//class SheetViewModel{
//
//    func setCity(urlIndex: Cities.city, selectedCity: CLLocation){
//        if previousCity != urlIndex{
//            weatherVM.getAddress(location: selectedCity) { city in
//                currentCity = city
//            }
//
//            weatherVM.getWeather(urlIndex: urlIndex) { weather in
//
//                weatherVM.getCurrentTemperature(urlIndexForCurrentTemperature: urlIndex) { response in
//                    temperature = String(response.currentWeather)
//                }
//
//
//                let rainny = weatherVM.getWeatherType()
//                if rainny == true{
//                    imageName = "cloud.rain.fill"
//                    imageColor = .blue
//                    imageColor2 = .gray
//                }else{
//                    imageName = "sun.max.fill"
//                    imageColor = .yellow
//                    imageColor2 = .yellow
//                }
//
//                let nextDaysTemperatureMax = weatherVM.getNextDaysMaxTemperature()
//                var numberIndexForTemperaturesMax = 0
//                for temperature in nextDaysTemperatureMax{
//                    temperaturesMaxArray[numberIndexForTemperaturesMax] = String(temperature.temperature)
//                    numberIndexForTemperaturesMax = numberIndexForTemperaturesMax + 1
//                }
//
//                let nextDaysTemperatureMin = weatherVM.getNextDaysMinTemperature()
//                var numberIndexForTemperaturesMin = 0
//                for temperature in nextDaysTemperatureMin{
//                    temperaturesMinArray[numberIndexForTemperaturesMin] = String(temperature.temperature)
//                    numberIndexForTemperaturesMin = numberIndexForTemperaturesMin + 1
//                }
//
//                let rainInNextDays = weatherVM.getNextDaysWeatherType()
//                var numberIndexForRains = 0
//                for rain in rainInNextDays{
//                    if rain.rains > 0{
//                        imagesNameArray[numberIndexForRains] = "cloud.rain.fill"
//                        colorForNextDayImages[numberIndexForRains] = Color.gray
//                        colorForNextDayImages2[numberIndexForRains] = Color.blue
//                        numberIndexForRains = numberIndexForRains + 1
//                    }else{
//                        imagesNameArray[numberIndexForRains] = "sun.max.fill"
//                        colorForNextDayImages[numberIndexForRains] = Color.yellow
//                        colorForNextDayImages2[numberIndexForRains] = Color.yellow
//                        numberIndexForRains = numberIndexForRains + 1
//                    }
//                }
//            }
//        }
//    }
//}
