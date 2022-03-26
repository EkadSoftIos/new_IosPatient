//
//  CityFilterVC.swift
//  E4 Patient
//
//  Created by mohab on 03/05/2021.
//

import UIKit
import MapKit
import CoreLocation

protocol FilterWithLocation: AnyObject {
    func filterWithLocation(lat: String?, lng: String?, areaId: Int?, cityId: Int?)
}

class CityFilterVC: UIViewController, BaseViewProtocol {
    
    var lat: String?
    var lng: String?
    var cityId: Int?
    var areaId: Int?
    
    var type = "city"
    
    var cityData: [LookupCity]?
    var areaData: [LookupArea]?
    
    weak var locationDelegate: FilterWithLocation?
    
    var vw = UIView(frame: UIScreen.main.bounds)
    var indicator = UIActivityIndicatorView(style: .whiteLarge)
    let locationManager = CLLocationManager()
    @IBOutlet var cityTableVIew: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showActivityIndicator(view: vw, indicator: indicator)
        getAllCity()
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        setupTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Select City".localized
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColor.Blue]
    }
    func setupTableView(){
        cityTableVIew.register(MoreCell.nib, forCellReuseIdentifier: "moreCell")
        cityTableVIew.delegate = self
        cityTableVIew.dataSource = self
        cityTableVIew.separatorStyle = .none
    }
    @IBAction func yourLocationBtn(_ sender: Any) {
        self.locationDelegate?.filterWithLocation(lat: lat, lng: lng, areaId: nil, cityId: nil)
        navigationController?.popViewController(animated: true)
    }
    func getAllCity() {
        NetworkClient.performRequest(_type: GetFullCitiesModel.self, router: APIRouter.getAllCountries) {[weak self] (result) in
            guard let self = self else {return}
            self.hideActivityIndicator(view: self.vw, indicator: self.indicator)
            switch result {
            case.success(let data):
                self.cityData = data.message?[0].lookupCity
                self.cityTableVIew.reloadData()
            case.failure(let err):
                self.showAlert(message: err.localizedDescription)
            }
        }
    }
}
extension CityFilterVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        let lat = String(locValue.latitude)
        let lng = String(locValue.longitude)

        self.lat = lat
        self.lng = lng
    }
  
}
