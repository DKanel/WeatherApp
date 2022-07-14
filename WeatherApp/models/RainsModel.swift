//
//  RainsModel.swift
//  WeatherApp
//
//  Created by MSENSIS on 11/7/22.
//

import Foundation
import SwiftyJSON

class RainsModel{
    let rains: Double
    
    init(json:JSON){
        self.rains = json[].doubleValue
    }
}
