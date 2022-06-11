//
//  GeocoderManager.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/4/22.
//

import Foundation
import CoreLocation

protocol GeocoderManagerProtocol {
    func getLocationInfo(for location: CLLocation, lang:String, handler: @escaping (Result<Location, NetworkError>) -> Void)
}

class GeocoderManager:GeocoderManagerProtocol {
    
    func getLocationInfo(for location: CLLocation, lang:String, handler: @escaping (Result<Location, NetworkError>) -> Void ){
        
        CLGeocoder().reverseGeocodeLocation(location, preferredLocale: Locale(identifier: lang) ) { (placeMarks:[CLPlacemark]?, error) in
            if let error = error{
                handler(.failure(.custom(error.localizedDescription)))
                return
            }
            
            if let placemark = placeMarks?.first,
                let city = placemark.locality ?? placemark.subAdministrativeArea ?? placemark.administrativeArea,
                let country = placemark.country {
                
                let location = Location(longitude: location.coordinate.longitude, latitude: location.coordinate.latitude, city: city, country: country)
                handler(.success(location))
            }else{
                handler(.failure(.invalidResponse))
            }
        }//end closure
    }// end func
    
}



struct Location : Codable {
    let longitude: Double
    let latitude: Double
    let city: String
    let country: String
}
