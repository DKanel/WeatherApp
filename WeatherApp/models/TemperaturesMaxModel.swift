//
//  TemperaturesModel.swift
//  WeatherApp
//
//  Created by MSENSIS on 11/7/22.
//

import Foundation
import SwiftyJSON

class TemperaturesMaxModel{
   
    let temperature: Double
    
    init(json:JSON){
        self.temperature = json[].doubleValue
    }
}
