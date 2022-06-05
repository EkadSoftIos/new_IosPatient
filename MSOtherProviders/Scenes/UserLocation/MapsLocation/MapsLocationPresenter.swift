//
//  MapsLocationPresenter.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/4/22.
//
//

import Foundation
import CoreLocation


//MARK: Presenter -
protocol MapsLocationPresenterProtocol: AnyObject {
    var type:MSType { get set}
    var request:RequestType? { get set }
    var branch:OtherProviderBranch? { get }
    /**
     * Add here your methods for communication VIEW -> PROTOCOL
     */
    func viewDidLoad()
    func didSelectPin(for id:Int)
    func searchForOP(at coordinate:CLLocationCoordinate2D)
}

class MapsLocationPresenter: NSObject {
    
    // MARK: - Public properties -
    var type:MSType{
        get{ pageType }
        set{ pageType = newValue }
    }
    
    var request:RequestType?{
        get{ requestType }
        set{ requestType = newValue }
    }
    
    var branch: OtherProviderBranch?{
        selectedBranch
    }

        
    // MARK: - Private properties -
    private var timeoutTimer:Timer?
    private var pageType:MSType!
    private var opRequest:OPRequest!
    private var requestType:RequestType?
    private var selectedBranch:OtherProviderBranch?
    private var locationManager:CLLocationManager?
    private weak var view: MapsLocationViewProtocol?
    private var opBranchesList:[OtherProviderBranch] = []
    private var msNetworkRepository:MSNetworkRepository?
    
    // MARK: - Init -
    init(view: MapsLocationViewProtocol,
         networkManager:MSNetworkRepository = MSAPIsManager()) {
        self.view = view
        self.msNetworkRepository = networkManager
    }
}

// MARK: - Extensions -
extension MapsLocationPresenter: MapsLocationPresenterProtocol {
    
    func viewDidLoad() {
        setupLMIfNeeded()
        setupRequestType()
    }
    
    
    // MARK: - searchForOP -
    func didSelectPin(for id:Int){
        guard let branch = opBranchesList.first(where: { $0.otherProviderBranchID == id })
        else { return }
        selectedBranch = branch
        let display = OPMapDisplay(branch: branch, servicesNum: opRequest?.serviceIdList?.count ?? 0, msImage: self.pageType.msImageNamed )
        view?.configBranch(display: display)
    }
    
    // MARK: - searchForOP -
    func searchForOP(at coordinate:CLLocationCoordinate2D){
        timeoutTimer?.invalidate()
        opRequest?.latitude = coordinate.latitude
        opRequest?.longitude = coordinate.longitude
        timeoutTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] (timer) in
            guard let self = self else { return }
            self.fetchData()
        })
    }
    
    // MARK: - fetchData -
    private func fetchData() {
        guard let msOPRequest = opRequest else { return }
        let url = NetworkURL(.otherProviders(msOPRequest))
        msNetworkRepository?.fetch(OPsReponse.self, from: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                if let error = response.errormessage, response.successtate != 200 {
                    self.view?.showMessageAlert(title: "Error".localized, message: error)
                    return
                }
                if response.message.isEmpty {
                    self.view?.showMessageAlert(title: "", message: "No info found near your location".localized, isError: false)
                    return
                }
                self.opBranchesList = response.message
                let displays = self.opBranchesList.map({
                    OPMapDisplay(
                        branch: $0,
                        servicesNum: self.opRequest?.serviceIdList?.count ?? 0,
                        msImage: self.pageType.msImageNamed
                    )
                })
                self.view?.addMarkers(opDisplayList: displays)
            case .failure(let error):
                self.view?.showMessageAlert(title: "Error".localized, message: error.localizedDescription)
            }
        }//end closure
    }
    
}


// MARK: - CLLocationManagerDelegate -
extension MapsLocationPresenter: CLLocationManagerDelegate{
    
    func setupLMIfNeeded(){
        if !CLLocationManager.locationServicesEnabled() {
            let title = "Location Services".localized
            let message = "Please Enable Location Services in the Settings".localized
            view?.showMessageAlert(title: title, message: message )
            return
        }
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestAlwaysAuthorization()
        locationManager?.requestWhenInUseAuthorization()
    }
    
    func startUpdatingLocation() {
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
        searchForOP(at: location.coordinate)
        view?.zoomToUserLocation(coordinate: location.coordinate)
    }
}

extension MapsLocationPresenter{
    func setupRequestType() {
        switch requestType{
        case .services(let msList):
            opRequest = OPRequest(
                distance: 10,
                providerType: pageType,
                serviceIdList: msList.map({ $0.serviceID })
            )
        case .eprescription(let ep):
            opRequest = OPRequest(
                distance: 10,
                providerType: pageType,
                serviceIdList: ep.services.map({ $0.serviceID })
            )
        default:
            break
        }
    }
}


struct OPMapDisplay{
    
    let id:Int
    let providerName:String
    let avatar:URL?
    let branchName:String
    let servicesText:String
    let price:String
    let discount:String
    let priceBeforeDiscount:String
    let isUploadedEP:Bool
    let coordinate:CLLocationCoordinate2D
    let msImage:String
    
    init(branch:OtherProviderBranch, servicesNum:Int, msImage:String){
        self.msImage = msImage
        id = branch.otherProviderBranchID
        self.isUploadedEP = servicesNum == 0
        providerName = branch.otherProviderNameLocalized
        branchName = branch.branchNameLocalized
        avatar = URL(string: "\(URLs.baseURLImage)\(branch.otherProviderImage)")
        servicesText = String(format: "%d/%d %@", branch.avaliableCount, servicesNum,  "Services".localized)
        price = String(format: "%.02f\("EGP".localized)", branch.priceAfter)
        priceBeforeDiscount = String(format: "%.02f\("EGP".localized)", branch.priceBefore)
        discount = String(format: "%.01f%", branch.discountPercentage)
        coordinate = CLLocationCoordinate2D(
            latitude: branch.brancheLat.doubleValue,
            longitude: branch.brancheLong.doubleValue
        )
    }
}


//
//func getOPList() -> [OtherProviderBranch] {
//    [
//        OtherProviderBranch(
//            otherProviderBranchID: 1,
//            branchNameLocalized: "فرع قوص",
//            otherProviderNameLocalized: "مركز الأمل",
//            otherProviderImage:"Upload/reduced_2022040511455697967277776586_7110184399052441_1899890496132401063_n.jpg",
//            otherProviderID: 6,
//            avaliableCount: 3,
//            priceBefore: 700.0,
//            priceAfter: 580.0,
//            discountPercentage: 17.14,
//            distance: 3.5,
//            brancheLat: "25.8551308",
//            brancheLong: "32.8228603"
//        ),
//        OtherProviderBranch(
//            otherProviderBranchID: 2,
//            branchNameLocalized: "فرع حجازة",
//            otherProviderNameLocalized: "مركز الأمل",
//            otherProviderImage:"Upload/reduced_2022040511455697967277776586_7110184399052441_1899890496132401063_n.jpg",
//            otherProviderID: 6,
//            avaliableCount: 3,
//            priceBefore: 700.0,
//            priceAfter: 580.0,
//            discountPercentage: 17.14,
//            distance: 3.5,
//            brancheLat: "25.8559708",
//            brancheLong: "32.8325053"
//        ),
//        OtherProviderBranch(
//            otherProviderBranchID: 3,
//            branchNameLocalized: "فرع رفاعة",
//            otherProviderNameLocalized: "مركز الابتسام",
//            otherProviderImage:"Upload/reduced_2022040511455697967277776586_7110184399052441_1899890496132401063_n.jpg",
//            otherProviderID: 6,
//            avaliableCount: 1,
//            priceBefore: 500.0,
//            priceAfter: 400.0,
//            discountPercentage: 20.0,
//            distance: 1.5,
//            brancheLat: "25.8566368",
//            brancheLong: "32.8329993"
//        ),
//        OtherProviderBranch(
//            otherProviderBranchID: 4,
//            branchNameLocalized: "فرع السويقة",
//            otherProviderNameLocalized: "مركز الابتسام",
//            otherProviderImage:"Upload/reduced_2022040511455697967277776586_7110184399052441_1899890496132401063_n.jpg",
//            otherProviderID: 6,
//            avaliableCount: 1,
//            priceBefore: 500.0,
//            priceAfter: 400.0,
//            discountPercentage: 20.0,
//            distance: 1.5,
//            brancheLat: "25.8518048",
//            brancheLong: "32.8261003"
//        )
//    ]
//}
