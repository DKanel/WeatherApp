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
    @Published var locationCity = ""
    
    var locationManager: CLLocationManager?
    
    func checkIfLocationIsEnabled(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            locationManager?.startUpdatingLocation()
        }else{
            print("go turn it on")
        }
    }
    
    func checkAuthorization(){
        guard let locationManager = locationManager else {
            return
        }
        
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
    
    func updateLocation(){
        self.locationManager!.requestLocation()
         }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        self.location = locations.first!
        weatherVM.getAddress(location: self.location) { city in
            self.locationCity = city
        }
        print("MY LOCATION",location)
        
            }

    
}
