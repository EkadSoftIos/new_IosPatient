//
//  AULocationPresenter.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/2/22.
//
//

import MOLH
import PKHUD
import Foundation
import CoreLocation
//import SKCountryPicker


enum AULocationType {
    case countries
    case citiesList
    case cities(ULCountry)
    case areas(ULCountry, City)
}


//MARK: Presenter -
protocol AULocationPresenterProtocol: AnyObject {
    var numberOfRows:Int { get }
    var type:AULocationType { get set }
    /**
     * Add here your methods for communication VIEW -> PROTOCOL
     */
    func viewDidLoad()
    func config(_ cell:AULocationCellProtocol, for indexPath:IndexPath)
    func didSelectRow(at indexPath:IndexPath )
    func autoLocation() 
}

class AULocationPresenter: NSObject {
    
    // MARK: - Public properties -
    var numberOfRows: Int{
        itemsList.count
    }
    
    var type: AULocationType{
        get{ auLocationType }
        set{ auLocationType = newValue }
    }

    // MARK: - Private properties -
    private var country:ULCountry!
    private var itemsList:[Any] = []
    private var auLocationType:AULocationType!
    private var locationManager:CLLocationManager?
    private weak var view: AULocationViewProtocol?
    private var msNetworkRepository:MSNetworkRepository?
    private var msGeocoderManager:GeocoderManagerProtocol?

    // MARK: - Init -
    init(view: AULocationViewProtocol,
         networkManager:MSNetworkRepository = MSAPIsManager(),
         geocoderManager:GeocoderManagerProtocol = GeocoderManager()) {
        self.view = view
        msNetworkRepository = networkManager
        msGeocoderManager = geocoderManager
    }
}

// MARK: - Extensions -
extension AULocationPresenter: AULocationPresenterProtocol {
    
    // MARK: - viewDidLoad -
    func viewDidLoad() {
        func addList(items:[Any]){
            itemsList.append(contentsOf: items)
            view?.reloadData()
        }
        switch type {
        case .countries:
            view?.navTitle = "Select Country".localized
            fetchData()
            break
        case .citiesList:
            view?.navTitle = "Select City".localized
            fetchData()
            break
        case .cities(let country):
            view?.navTitle = "Select City".localized
            addList(items: country.lookupCity)
            break
        case .areas( _ , let city):
            view?.navTitle = "Select Area".localized
            addList(items: city.lookupArea)
            break
        }
    }
    
    // MARK: - fetchData -
    func fetchData(){
        let url = NetworkURL(.availableCountries)
        msNetworkRepository?.fetch(ULocationReponse.self, from: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                if let error = response.errormessage, response.successtate != 200 {
                    self.view?.showMessageAlert(title: .error, message: error)
                    return
                }
                if case .countries = self.auLocationType {
                    self.itemsList.append(contentsOf: response.message)
                }else if case .citiesList = self.auLocationType,
                         let firstCountry = response.message.first {
                    self.country = firstCountry
                    self.itemsList.append(contentsOf: firstCountry.lookupCity)
                }
                self.view?.reloadData()
            case .failure(let error):
                self.view?.showMessageAlert(title: .error, message: error.localizedDescription)
            }
        }//end closure
    }
    
    
    // MARK: - config -
    func config(_ cell:AULocationCellProtocol, for indexPath:IndexPath){
        guard let display = AULocationDisplay(item: itemsList[indexPath.row])
        else { return  }
        cell.config(display: display)
    }
    
    
    // MARK: - didSelectRow -
    func didSelectRow(at indexPath:IndexPath ){
        switch type {
        case .countries:
            guard let selectedCountry = itemsList[indexPath.row] as? ULCountry else { return }
            view?.showListVC(type: .cities(selectedCountry))
            break
        case .citiesList:
            guard let selectedCity = itemsList[indexPath.row] as? City
            else { return }
            view?.showListVC(type: .areas(country, selectedCity))
            break
        case .cities(let country):
            let selectedCity = country.lookupCity[indexPath.row]
            view?.showListVC(type: .areas(country, selectedCity))
            break
        case .areas(let country, let city):
            let selectedArea = city.lookupArea[indexPath.row]
            // pop to OPListsVC
            view?.popToOPListVC(country: country, city: city, area: selectedArea)
            break
        }
    }
}


// MARK: - CLLocationManagerDelegate -
extension AULocationPresenter: CLLocationManagerDelegate{
    
    func setupLMIfNeeded(){
        if !CLLocationManager.locationServicesEnabled() {
            view?.showMessageAlert(title: .error, message: .enableLocationServices)
            return
        }
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestAlwaysAuthorization()
        locationManager?.requestWhenInUseAuthorization()
    }
    
    func autoLocation() {
        setupLMIfNeeded()
        locationManager?.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch(CLLocationManager.authorizationStatus()) {
        case .authorizedAlways, .authorizedWhenInUse, .notDetermined:
            locationManager?.startUpdatingLocation()
        case .restricted, .denied:
            // redirect the users to settings
            view?.showAppSetting()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.sorted(by: { $0.horizontalAccuracy < $1.horizontalAccuracy }).first
        else{ return }
        locationManager?.stopUpdatingLocation()
        updateUserLocation(location: location)
    }
    
    
    private func updateUserLocation(location:CLLocation){
        let lang = MOLHLanguage.currentAppleLanguage()
        HUD.show(.progress)
        msGeocoderManager?.getLocationInfo(for: location, lang: lang) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                if HUD.isVisible { HUD.flash(.success) }
                self.view?.popToOPListVC(location: response)
            case .failure(let error):
                if HUD.isVisible { HUD.flash(.error) }
                self.view?.showMessageAlert(title: .error, message: error.localizedDescription)
            }
        }// end closure
    }//end func
    
}
