//
//  GourlyTemperatureModel.swift
//  WeatherApp
//
//  Created by MSENSIS on 22/7/22.
//

import Foundation
import SwiftyJSON

class HourlyTemperatureModel{
    let hTemperature: Double
    
    init(json: JSON){
        self.hTemperature = json[].doubleValue
    }
}
