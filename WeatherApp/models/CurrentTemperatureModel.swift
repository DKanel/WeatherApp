//
//  CurrentWeatherModel.swift
//  WeatherApp
//
//  Created by MSENSIS on 14/7/22.
//

import Foundation
import SwiftyJSON

class CurrentTemperatureModel{
    
    let currentWeather: Int
    
    init(json:JSON){
        self.currentWeather = json["temp"].intValue
    }
}
