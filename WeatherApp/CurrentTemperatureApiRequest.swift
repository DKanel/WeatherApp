//
//  CurrentTemperatureApiRequest.swift
//  WeatherApp
//
//  Created by MSENSIS on 14/7/22.
//

import Foundation
import Alamofire
import SwiftyJSON



class CurrentTemperatureApiRequest{
    
    let currentTemperatureURLAthens = "https://api.openweathermap.org/data/2.5/weather?lat=37.9792&lon=23.7166&appid=272b1dd66f28d3c1ec4a78be16e6860b&units=metric"
    let currentTemperatureURLBerlin = "https://api.openweathermap.org/data/2.5/weather?lat=52.5235&lon=13.4115&appid=272b1dd66f28d3c1ec4a78be16e6860b&units=metric"
    let currentTemperatureURLParis = "https://api.openweathermap.org/data/2.5/weather?lat=48.8567&lon=2.3510&appid=272b1dd66f28d3c1ec4a78be16e6860b&units=metric"
    let currentTemperatureURLLondon = "https://api.openweathermap.org/data/2.5/weather?lat=51.5002&lon=-0.1262&appid=272b1dd66f28d3c1ec4a78be16e6860b&units=metric"
    
    var url = ""
    
    func makeCallForCurrentTemperature(urlIndexForCurrentTemperature: Cities.city,completion: @escaping(CurrentTemperatureModel)->Void){
                
        switch urlIndexForCurrentTemperature{
        case.Athens:
            url = currentTemperatureURLAthens
        case .Paris:
            url = currentTemperatureURLParis
        case .Berlin:
            url = currentTemperatureURLBerlin
        case .London:
            url = currentTemperatureURLLondon
        }
        
    AF.request(url).responseJSON{ response in
        switch response.result{
        case .success(let value):
            let jsonValue = JSON(value)
            let currentWeatherModel = jsonValue["main"]
           
            
            let currentTemperature = CurrentTemperatureModel(json: currentWeatherModel)
            completion(currentTemperature)
            
        case .failure(let error):
            print(error)
        }
    }
}
}
