//
//  CurrentWeatherModel.swift
//  WeatherApp
//
//  Created by MSENSIS on 14/7/22.
//

import Foundation
import SwiftyJSON

class CurrentTemperatureModel{
    
    let currentWeather: String
    
    init(json:JSON){
        self.currentWeather = json["temp"].stringValue
    }
}
