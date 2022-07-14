//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by MSENSIS on 8/7/22.
//

import Foundation
import SwiftyJSON
import SwiftUI

class WeatherModel{
   
    let temperatureMax: [TemperaturesMaxModel]
    let temperaturesMin: [TemperaturesMinModel]
    let sunsets: [SunsetModel]
    let rain: [RainsModel]
    let latitude: String
    let longtitude: String
    
    init(temperaturesMax: [TemperaturesMaxModel], temperaturesMin: [TemperaturesMinModel],sunset: [SunsetModel], rains: [RainsModel], json:JSON){
        self.temperatureMax = temperaturesMax
        self.temperaturesMin = temperaturesMin
        self.sunsets = sunset
        self.rain = rains
        self.latitude = json["latitude"].stringValue
        self.longtitude = json["longitude"].stringValue
    }
}


