//
//  MedicalServicesPresenter.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 5/24/22.
//
//

import Foundation

typealias URLs = NetworkURL.URLs

enum MSType: Int {
    case labs = 1
    case radiologyCenter
}

struct SliderDisplayCell{
    let imgURL:URL?
    
    init(imgPath:String){
        imgURL = URL(string: "\(URLs.baseURLImage)\(imgPath)")
    }
}

//MARK: Presenter -
protocol MedicalServicesPresenterProtocol: AnyObject {
    var type:MSType { get set}
    var title:String { get }
    
    var numberOfAds:Int { get }
    var numberOfEPrescriptions:Int { get }
    /**
     * Add here your methods for communication VIEW -> PROTOCOL
     */
    func viewDidLoad()
    
    func configAdCell(cell:FSPagerViewCellProtocol, index:Int)
    func configEPrescriptionCell(cell:EPrescriptionCellProtocol, indexPath:IndexPath)
}

class MedicalServicesPresenter {
    
    // MARK: - Public properties -
    var title:String {
        type == .labs ? "Lab":"X-Rays"
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
    
    // MARK: - Private properties -
    private var pageType:MSType!
    private var adsList:[Ad] = []
    private var ePrescriptionsList:[LastPrescription] = []
    private weak var view: MedicalServicesViewProtocol?
    private var networkManager:MSAPIsManagerProtocol?
    
    // MARK: - Init -
    init(view: MedicalServicesViewProtocol,
         networkManager:MSAPIsManagerProtocol = MSAPIsManager()) {
        self.view = view
        self.networkManager = networkManager
    }
}

// MARK: - Extensions -
extension MedicalServicesPresenter: MedicalServicesPresenterProtocol {
    
    // MARK: - viewDidLoad -
    func viewDidLoad() {
       fetchData()
    }
    
    // MARK: - fetchData -
    func fetchData() {
        let url = NetworkURL(.providerDashboard(type))
        networkManager?.fetch(MSReponse.self, from: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                if let error = response.errormessage, response.successtate != 200{
                    self.view?.showMessageAlert(title: "Error", message: error)
                    return
                }
                self.view?.reloadData()
                self.adsList = response.message.ads
                self.ePrescriptionsList = response.message.lastPrescriptions
            case .failure(let error):
                self.view?.showMessageAlert(title: "Error", message: error.localizedDescription)
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
        cell.config(display: EPrescriptionDisplatCell(ePrescriptionsList[indexPath.row]))
    }
}


































//func fetchData() {
//    let url = NetworkURL(.providerDashboard(type))
//    networkManager?.fetch(url: url) { [weak self] result in
//        guard let self = self else { return }
//        switch result {
//        case .success(let response):
//            if let error = response.errormessage, response.successtate != 200{
//                self.view?.showMessageAlert(title: "Error", message: error)
//                return
//            }
//            self.adsList = response.message.ads
//        case .failure(let error):
//            self.view?.showMessageAlert(title: "Error", message: error.localizedDescription)
//        }
//    }
//}
//}
