//
//  PagerViewModel.swift
//  WeatherApp
//
//  Created by MSENSIS on 22/7/22.
//

import Foundation

class PagerViewModel{
    let weatherApiRequest = WeatherApiRequest()
    
    
    func makeCall(completion: @escaping ([HourlyTemperatureModel])->Void){
        weatherApiRequest.makeHourlyTempCall { response in
            completion(response)
        }
    }
}
