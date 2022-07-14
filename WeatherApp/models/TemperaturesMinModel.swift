//
//  TemperaturesMinModel.swift
//  WeatherApp
//
//  Created by MSENSIS on 14/7/22.
//

import Foundation
import SwiftyJSON

class TemperaturesMinModel{
   
    let temperature: Double
    
    init(json:JSON){
        self.temperature = json[].doubleValue
    }
}
