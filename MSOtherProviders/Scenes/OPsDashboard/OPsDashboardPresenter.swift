//
//  OPsDashboardPresenter.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 5/28/22.
//
//

import Foundation
import SwiftMessages


struct SliderDisplayCell{
    let imgURL:URL?
    
    init(imgPath:String){
        imgURL = URL(string: "\(URLs.baseURLImage)\(imgPath)")
    }
}

//MARK: Presenter -
protocol OPsDashboardPresenterProtocol: AnyObject {
    var type:MSType { get set}
    var title:String { get }
    
    var searchPlaceholder:String { get }
    
    var numberOfAds:Int { get }
    var msLabelTitle:String { get }
    var numberOfEPrescriptions:Int { get }
    var msRequest:MSOPServicesRequest { get }
    /**
     * Add here your methods for communication VIEW -> PROTOCOL
     */
    func viewDidLoad()
    func configAdCell(cell:FSPagerViewCellProtocol, index:Int)
    func configEPrescriptionCell(cell:EPrescriptionCellProtocol, indexPath:IndexPath)
}

class OPsDashboardPresenter {
    
    typealias ViewProtocol = OPsDashboardViewProtocol
    typealias ProvidersReponse = MSOtherProvidersReponse
    
    
    // MARK: - Public properties -
    var title:String {
        pageType.opsDashboardTitle
    }
    
    var msLabelTitle:String {
        pageType.msOPsDashboardBtnTitle
    }
    
    var searchPlaceholder:String{
        pageType.msSearchPlaceholder
    }

    
    var type:MSType{
        get{ pageType }
        set{ pageType = newValue }
    }
    
    var numberOfAds: Int{
        adsList.count
    }
    
    var numberOfEPrescriptions: Int{
        ePrescriptionsList.count
    }
    
    var msRequest:MSOPServicesRequest {
        msOPServicesRequest ?? MSOPServicesRequest(type: pageType)
    }
    
    // MARK: - Private properties -
    private var pageType:MSType!
    private var adsList:[Ad] = []
    private var ePrescriptionsList:[EPrescription] = []
    private var msNetworkRepository:MSNetworkRepository?
    private var msOPServicesRequest:MSOPServicesRequest?
    private weak var view: OPsDashboardViewProtocol?
    
    // MARK: - Init -
    init(view: ViewProtocol,
         networkManager:MSNetworkRepository = MSAPIsManager()) {
        self.view = view
        self.msNetworkRepository = networkManager
    }

}

// MARK: - Extensions -
extension OPsDashboardPresenter: OPsDashboardPresenterProtocol {
    
    // MARK: - viewDidLoad -
    func viewDidLoad() {
        msOPServicesRequest = MSOPServicesRequest(type: pageType)
        fetchData()
    }
    
    // MARK: - fetchData -
    func fetchData() {
        guard let request = msOPServicesRequest else { return }
        let url = NetworkURL(.otherProviderDashboard(request))
        msNetworkRepository?.fetch(ProvidersReponse.self, from: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                if let error = response.errormessage, response.successtate != 200{
                    self.view?.showMessageAlert(title: .error, message: error)
                    return
                }
                self.adsList.append(contentsOf: response.msData.ads ?? [])
                self.ePrescriptionsList = response.msData.lastPrescriptions
                self.view?.reloadData()
            case .failure(let error):
                self.view?.showMessageAlert(title: .error, message: error.localizedDescription)
            }
        }//end closure
    }
    
    // MARK: - configAdCell -
    func configAdCell(cell:FSPagerViewCellProtocol, index:Int)  {
        let display = SliderDisplayCell(imgPath: adsList[index].image)
        cell.config(display: display)
    }
    
    
    // MARK: - configEPrescriptionCell -
    func configEPrescriptionCell(cell:EPrescriptionCellProtocol, indexPath:IndexPath)  {
        let ep = ePrescriptionsList[indexPath.row]
        cell.config(display: EPrescriptionDisplay( ep, msType: pageType), indexPath: indexPath, presenter: self)
    }
    
}

// MARK: - EPrescriptionCellPresenter -
extension OPsDashboardPresenter:EPrescriptionCellPresenter{
    
    func showOtherProvidersList(indexPath: IndexPath){
        let ep = ePrescriptionsList[indexPath.row]
        view?.showOtherProvidersList(request: .eprescription(ep))
    }
    
}
