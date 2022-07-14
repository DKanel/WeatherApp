//
//  SunsetModel.swift
//  WeatherApp
//
//  Created by MSENSIS on 14/7/22.
//

import Foundation
import SwiftyJSON

class SunsetModel{
    
    let sunset: String
    
    init(json:JSON){
        self.sunset = json[].stringValue
    }
}
