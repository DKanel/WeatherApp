//
//  WeatherApiRequest.swift
//  WeatherApp
//
//  Created by MSENSIS on 8/7/22.
//

import Foundation
import Alamofire
import SwiftyJSON
import SwiftUI
import CoreLocation



class WeatherApiRequest{
    
    
    let urlAthens = "https://api.open-meteo.com/v1/forecast?latitude=37.9792&longitude=23.7166&daily=temperature_2m_max,temperature_2m_min,sunset,rain_sum&timezone=Europe%2FMoscow" // Athens
    let urlBerlin = "https://api.open-meteo.com/v1/forecast?latitude=52.5235&longitude=13.4115&daily=temperature_2m_max,temperature_2m_min,sunset,rain_sum&timezone=Europe%2FBerlin" // Berlin
    let urlParis = "https://api.open-meteo.com/v1/forecast?latitude=48.8567&longitude=2.3510&daily=temperature_2m_max,temperature_2m_min,sunset,rain_sum&timezone=Europe%2FBerlin" // Paris
    let urlLondon = "https://api.open-meteo.com/v1/forecast?latitude=51.5002&longitude=-0.1262&daily=temperature_2m_max,temperature_2m_min,sunset,rain_sum&timezone=Europe%2FLondon" // London
    var url = ""
    
    var dailyRain = [RainsModel]()
    var dailyMaxTemperature = [TemperaturesMaxModel]()
    var dailyMinTemperature = [TemperaturesMinModel]()
    var dailySunset = [SunsetModel]()
    
    func makeCall(urlIndex: Cities.city, completion: @escaping(WeatherModel)->Void){
        
        switch urlIndex{
        case.Athens:
            url = urlAthens
        case .Paris:
            url = urlParis
        case .Berlin:
            url = urlBerlin
        case .London:
            url = urlLondon
        }
        
        AF.request(url).responseJSON{ [self] response in
            switch response.result{
            case .success(let value):
                let jsonValue = JSON(value)
                let rainsModel = jsonValue["daily"]["rain_sum"].arrayValue
                let temperaturesMaxModel = jsonValue["daily"]["temperature_2m_max"].arrayValue
                let temperaturesMinModel = jsonValue["daily"]["temperature_2m_min"].arrayValue
                let sunsets = jsonValue["daily"]["sunset"].arrayValue
                let location = jsonValue
                
                for model in rainsModel{
                    let rain = RainsModel(json: model)
                    dailyRain.append(rain)
                }
                
                for model in temperaturesMaxModel {
                    let temperature = TemperaturesMaxModel(json: model)
                    dailyMaxTemperature.append(temperature)
                }
                
                for model in temperaturesMinModel {
                    let temperature = TemperaturesMinModel(json: model)
                    dailyMinTemperature.append(temperature)
                }
                
                for model in sunsets {
                    let sunset = SunsetModel(json: model)
                    dailySunset.append(sunset)
                }
                
                let dailyWeather = WeatherModel(temperaturesMax: dailyMaxTemperature, temperaturesMin: dailyMinTemperature,sunset: dailySunset, rains: dailyRain,json: location)
                completion(dailyWeather)
                
            case .failure(let error):
                print(error)
        }
    }
}
}
