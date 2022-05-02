//
//  MapVc.swift
//  E4 Patient
//
//  Created by mohab on 19/01/2021.
//

import UIKit
import MapKit
class MapVcc: UIViewController ,MKMapViewDelegate,CLLocationManagerDelegate,UITextFieldDelegate {
    @IBOutlet var searchTxt: TextField!
    @IBOutlet var mapView: MKMapView!
    
    
    lazy var locationHelper = LocationHelper()
    var userLocation:CLLocationCoordinate2D?
    var locationManager: CLLocationManager!
    var locationName: String = ""
    var delegate:chooseLocation?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Add Address".localized
    }
    override func viewWillAppear(_ animated: Bool) {
        self.view.endEditing(true)
    }
    func getCurrentLocation(){
        
        locationHelper.requestLocationAuthorization()
        locationHelper.getCurrentUserLocation()
        locationHelper.locationUpdated = { [weak self] lat,long in
            guard let self = self else { return }
            self.setRegionToMap(lat : lat , long : long)
             self.mapView.showsUserLocation = true
            
        }
    }
    func centerMapOnLocation(_ location: CLLocation, mapView: MKMapView) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius * 0.5, longitudinalMeters: regionRadius * 0.5)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        //textField code

        searchTxt.resignFirstResponder()  //if desired
        //performAction()
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
                  // handle no location found
                  return
              }
            self.setRegionToMap(lat: location.coordinate.latitude,
            long: location.coordinate.longitude)
            
           
          }
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {

         let coordinate = CLLocationCoordinate2D(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        self.userLocation = coordinate
        getAddressFromLatLon(pdblLatitude: self.userLocation!.latitude, withLongitude: self.userLocation!.longitude)
    }

    func setRegionToMap(lat : Double , long : Double){

        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
               let region = MKCoordinateRegion(center: coordinate,
                                               span: MKCoordinateSpan(latitudeDelta: 0.2,
                                                                      longitudeDelta: 0.2))
         self.userLocation = coordinate
        getAddressFromLatLon(pdblLatitude: self.userLocation!.latitude, withLongitude: self.userLocation!.longitude)
        self.mapView.setRegion(region, animated: true)
    }

    func setNavBarBorder() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }

    @IBAction func cancleClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
 
    @objc func handleTap(gestureReconizer: UILongPressGestureRecognizer) {
        
       /* let location = gestureReconizer.location(in: mapview)
        let coordinate = mapview.convert(location,toCoordinateFrom: mapview)
        print("new location = \(coordinate)")
        
        
        // Add annotation:
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        for item in mapview.annotations {
            mapview.removeAnnotation(item)
        }
        annotation.title = "Your location".localized
        mapview.addAnnotation(annotation)
        self.deliveryLocation = coordinate*/
        
    }
    
    func determineCurrentLocation()
    {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            //locationManager.startUpdatingHeading()
            locationManager.startUpdatingLocation()
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        //manager.stopUpdatingLocation()
        
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        self.userLocation = center
        print("LOCATIONS: \(userLocation)")
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mapView.setRegion(region, animated: true)
        
        // Drop a pin at user's Current Location
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
        myAnnotation.title = "Current location".localized
        mapView.addAnnotation(myAnnotation)
        locationManager.stopUpdatingLocation()
    }
    
    
   
    
 
    /*
     
     */
    //MARK:- get Location
    func getAddressFromLatLon(pdblLatitude: Double, withLongitude pdblLongitude: Double) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = pdblLatitude
        //21.228124
        let lon: Double = pdblLongitude
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon

        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)


        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
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
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }

                    print(addressString)
                    self.searchTxt.text = addressString
                    self.locationName = addressString
                }else{
                    self.locationName = ""
                    }
                    
              }
        })

    }
    
    @IBAction func save_CLick(_ sender: Any) {
        
      //  self.delegate?.chooseLocation(deliverylocation: self.userLocation!, name: self.locationName)
            self.dismiss(animated: true, completion: nil)
    }
    


}
protocol chooseLocationMap {
    func chooseLocation(deliverylocation:CLLocationCoordinate2D, name: String)
}

