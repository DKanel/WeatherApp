//
//  LocationManager.swift
//  WeatherApp
//
//  Created by MSENSIS on 13/7/22.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let weatherVM = WeatherViewModel()
    
    @Published var location = CLLocation()
    @Published var cityLocation = "nope"
    
    var locationManager = CLLocationManager()
    
        func checkIfLocationIsEnabled(){
        if CLLocationManager.locationServicesEnabled(){
            
        }else{
            print("go turn it on")
        }
    }
    
    func checkAuthorization(){
        
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
        case .authorizedAlways:
            print("authorizedAlways")
        case .authorizedWhenInUse:
            print("authorized when in use")
        @unknown default:
            print("default")
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAuthorization()
    }
    
    func getLocation(completion: @escaping (CLLocation)->Void){
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        self.locationManager.requestWhenInUseAuthorization()
        print("MY LOCATION")
        while locationManager.location == nil{
        }
        completion(locationManager.location!)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        self.location = locations.first!
    }
}
