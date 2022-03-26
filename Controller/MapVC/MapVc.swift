//
//  MapVC.swift
//  WomenAccessories
//
//  Created by Mohamed Lotfy on 1/3/19.
//  Copyright © 2019 Mohamed Lotfy. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol chooseLocation {
    func chooseLocation(deliverylocation:CLLocationCoordinate2D, name: String)
}

class MapVc: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate,UITextFieldDelegate {
    @IBOutlet var searchTxt: UITextField!
    @IBOutlet weak var mapview: MKMapView!
    @IBOutlet weak var agreeBtn: UIButton!
    lazy var locationHelper = LocationHelper()
    var delegate:chooseLocation?
    var previousLocation:CLLocation?
    var locationManager: CLLocationManager!
    var deliveryLocation:CLLocationCoordinate2D?
    var nameLocation: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Address".localized
        self.mapview.delegate = self
        self.searchTxt.delegate = self
        self.searchTxt.returnKeyType = .search
        getCurrentLocation()
    }
    override func viewWillAppear(_ animated: Bool) {
    }
    func getCurrentLocation(){
        locationHelper.requestLocationAuthorization()
        locationHelper.getCurrentUserLocation()
        locationHelper.locationUpdated = { [weak self] lat,long in
            guard let self = self else { return }
            self.setRegionToMap(lat : lat , long : long)
            self.mapview.showsUserLocation = true
            
        }
    }
    func centerMapOnLocation(_ location: CLLocation, mapView: MKMapView) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTxt.resignFirstResponder()  //if desired
        if searchTxt.text!.isEmpty {
        }else{
            getCoordinateFromAddress(address: searchTxt.text!)
        }
        return true
    }
    func getCoordinateFromAddress(address : String ){
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
            else {
                self.showMessage(title: "", sub: "Location Not Found".localized, type: .info, layout: .cardView)
                return
            }
            self.setRegionToMap(lat: location.coordinate.latitude,
                                long: location.coordinate.longitude)
        }
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let coordinate = CLLocationCoordinate2D(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        self.deliveryLocation = coordinate
        getAddressFromLatLon(pdblLatitude: self.deliveryLocation!.latitude, withLongitude: self.deliveryLocation!.longitude)
    }
    func setRegionToMap(lat : Double , long : Double){
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let region = MKCoordinateRegion(center: coordinate,
                                        span: MKCoordinateSpan(latitudeDelta: 0.2,
                                                               longitudeDelta: 0.2))
        self.deliveryLocation = coordinate
        getAddressFromLatLon(pdblLatitude: self.deliveryLocation!.latitude, withLongitude: self.deliveryLocation!.longitude)
        self.mapview.setRegion(region, animated: true)
    }
    func determineCurrentLocation()
    {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        self.deliveryLocation = center
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapview.setRegion(region, animated: true)
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
        myAnnotation.title = "Current location".localized
        mapview.addAnnotation(myAnnotation)
        locationManager.stopUpdatingLocation()
    }
    
    @IBAction func requestBtn(_ sender: Any) {
        if self.deliveryLocation == nil {
            showMessage(sub: "You must choose Your Location".localized)
        }else {
            
            self.delegate?.chooseLocation(deliverylocation: self.deliveryLocation!, name: nameLocation)
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    //MARK:- get Location
    func getAddressFromLatLon(pdblLatitude: Double, withLongitude pdblLongitude: Double) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = pdblLatitude
        let lon: Double = pdblLongitude
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        ceo.reverseGeocodeLocation(loc, completionHandler:
                                    {(placemarks, error) in
                                        if (error != nil)
                                        {
                                            print("fail: \(error!.localizedDescription)")
                                        }
                                        if placemarks?.count != 0 {
                                            
                                            let pm = placemarks! as [CLPlacemark]
                                            if pm.count > 0 {
                                                let pm = placemarks![0]
                                                
                                                var addressString : String = ""
                                                if pm.subLocality != nil {
                                                    addressString = addressString + pm.subLocality! + ", "
                                                }
                                                if pm.thoroughfare != nil {
                                                    addressString = addressString + pm.thoroughfare! + ", "
                                                }
                                                if pm.locality != nil {
                                                    addressString = addressString + pm.locality! + ", "
                                                }
                                                if pm.country != nil {
                                                    addressString = addressString + pm.country! + ", "
                                                }
                                                
                                                print(addressString)
                                                self.nameLocation = addressString
                                            }else{
                                            }
                                        }
                                    })
    }
}
