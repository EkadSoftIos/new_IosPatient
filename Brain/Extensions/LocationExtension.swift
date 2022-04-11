//
//  LocationExtension.swift
//  E4 Patient
//
//  Created by Nada on 3/8/22.
//

import UIKit
import MapKit

extension MKMapView {
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String, completionHandler: @escaping(String) ->()) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
      
        let lon: Double = Double("\(pdblLongitude)")!
      
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon

        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        var addressString : String = ""
        

        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                } else if placemarks != nil {

                    let pm = placemarks! as [CLPlacemark]
                      if pm.count > 0 {
                          let pm = placemarks![0]
                        
                          if pm.subLocality != nil {
                              addressString = addressString + pm.subLocality! + ", "
                          }
                        
                          if pm.thoroughfare != nil {
                              addressString = addressString + pm.thoroughfare! + ". "
                          }
                          print(addressString)
                    }
                }
                completionHandler(addressString)
        })
    }
}



