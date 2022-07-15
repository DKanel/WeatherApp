//
//  ViewModel.swift
//  WeatherApp
//
//  Created by MSENSIS on 5/7/22.
//

import Foundation
import CoreLocation
import SwiftUI
import RxSwift

class WeatherViewModel:NSObject, CLLocationManagerDelegate{
    
    var weatherResponse: WeatherModel?
    var currentTemperatureResponse: CurrentTemperatureModel?
    var currentLocation: CLLocation!
    let wetherApiRequest = WeatherApiRequest()
    let currentTemperatureApiRequest = CurrentTemperatureApiRequest()
    let dateFormatterForDays = DateFormatter()
    let dateFormatterForHours = DateFormatter()
    var dates: Array<String> = []
    
    
    
    
    // Location
    func getAddress(location: CLLocation,completion: @escaping (String)->Void){

        CLGeocoder().reverseGeocodeLocation(location) { (placeMark, error) in

            if error != nil{
                print("there was an error in reverseGeocode")
            }else{
                if let place = placeMark?[0]{
                    let city = place.locality
                    completion(city!)
                }
            }
        }
    }
    
    func getDate()->Array<String>{
        dateFormatterForDays.dateFormat = "dd/MM"
        
        let now = Calendar.current.dateComponents(in: .current, from: Date())
        
        
        for number in 0...6{
            let tomorrow = DateComponents(year: now.year, month: now.month, day: now.day! + number)
            let dateTomorrow = Calendar.current.date(from: tomorrow)!
            dates.append(dateFormatterForDays.string(from: dateTomorrow))
        }
        return dates
    }
    
    func getTime()->String{
        dateFormatterForHours.dateFormat = "HH:mm"
        let now = Calendar.current.dateComponents(in: .current, from: Date())
        let time = DateComponents(hour: now.hour, minute: now.minute)
        let timeCalendar = Calendar.current.date(from: time)
        let timeFormated = dateFormatterForHours.string(from: timeCalendar!)
        return timeFormated
    }
    
    func checkForSunset()->Bool{
        let time = getTime()
        let startBound1 = String.Index(utf16Offset: 11, in: weatherResponse!.sunsets[0].sunset)
        let sunsetTime = String((weatherResponse?.sunsets[0].sunset[startBound1..<(weatherResponse?.sunsets[0].sunset.endIndex)!])!)
        if time > sunsetTime{
            return true
        }
        return false
    }
    
    // Api Call
    func getWeather(urlIndex: Cities.city,completion: @escaping(WeatherModel)->Void){
        wetherApiRequest.makeCall(urlIndex: urlIndex) { weatherModel in
            self.weatherResponse = weatherModel
            completion(self.weatherResponse!)
        }
    }
    
    func getCurrentTemperature(urlIndexForCurrentTemperature: Cities.city,completion: @escaping(CurrentTemperatureModel)->Void){
        currentTemperatureApiRequest.makeCallForCurrentTemperature(urlIndexForCurrentTemperature: urlIndexForCurrentTemperature) { response in
            self.currentTemperatureResponse = response
            completion(self.currentTemperatureResponse!)
        }
    }
    
    func getWeatherType()->Bool{
        var willRain = false
        for weather in weatherResponse!.rain{
            if weather.rains > 0 {
                willRain = true
            }
        }
        return willRain
    }
    
    func getNextDaysMaxTemperature()->[TemperaturesMaxModel]{
        let temperaturesMax = weatherResponse?.temperatureMax
        return temperaturesMax!
    }
    
    func getNextDaysMinTemperature()->[TemperaturesMinModel]{
        let temperaturesMin = weatherResponse?.temperaturesMin
        return temperaturesMin!
    }
    
    func getNextDaysWeatherType()->[RainsModel]{
        let rain = weatherResponse?.rain
        return rain!
    }
    
//    func getTime()->String{
//         let time = Date()
//         let timeFormatter = DateFormatter()
//         timeFormatter.dateFormat = "HH"
//         let stringDate = timeFormatter.string(from: time)
//         return stringDate
//        }
    
    func setBlur(offset: CGFloat)->CGFloat{
        let progress = -offset / (UIScreen.main.bounds.height - 100)
        return progress * 20
    }
    
}
