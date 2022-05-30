//
//  EPrescriptionListPresenter.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 5/30/22.
//
//

import Foundation

//MARK: Presenter -
protocol EPrescriptionListPresenterProtocol: AnyObject {
    var type:MSType{ get set }
    var numberOfEPrescriptions:Int { get }
    /**
     * Add here your methods for communication VIEW -> PROTOCOL
     */
    func viewDidLoad()
    func loadMore()
    func configEPrescriptionCell(cell:EPrescriptionCellProtocol, indexPath:IndexPath)
}

class EPrescriptionListPresenter {
    
    // MARK: - Public properties -
    
    var type:MSType{
        get{ pageType }
        set{ pageType = newValue }
    }
    
    var numberOfEPrescriptions: Int{
        ePrescriptionsList.count
    }
    
    var msRequest:MSOPServicesRequest {
        msOPServicesRequest ?? MSOPServicesRequest(type: pageType)
    }
    
    // MARK: - Private properties -
    private var pageType:MSType!
    private var epRequest:EPrescriptionRequest!
    private var msOPServicesRequest:MSOPServicesRequest!
    private var ePrescriptionsList:[EPrescription] = []
    private var msNetworkRepository:MSNetworkRepository?
    private weak var view: EPrescriptionListViewProtocol?
    
    // MARK: - Init -
    init(view: EPrescriptionListViewProtocol,
         networkManager:MSNetworkRepository = MSAPIsManager()) {
        self.view = view
        self.msNetworkRepository = networkManager
    }
}

// MARK: - Extensions -
extension EPrescriptionListPresenter: EPrescriptionListPresenterProtocol {
    
    func viewDidLoad() {
        epRequest = EPrescriptionRequest(type: pageType, patientId: 1, pageNum: 1)
        msOPServicesRequest = MSOPServicesRequest(type: pageType)
        fetchData()
    }
    
    // MARK: - fetchData -
    func fetchData() {
        let url = NetworkURL(.ePrescriptions(epRequest))
        msNetworkRepository?.fetch(EPsReponse.self, from: url, handler: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                if let error = response.errormessage, response.successtate != 200{
                    self.view?.showMessageAlert(title: "Error", message: error)
                    return
                }
                self.ePrescriptionsList.append(contentsOf: response.message)
                self.view?.reloadData()
            case .failure(let error):
                self.view?.showMessageAlert(title: "Error".localized, message: error.localizedDescription)
            }
        })
    }
    
    // MARK: - loadMore -
    func loadMore(){
        epRequest.pageNum! += 1
        fetchData()
    }
    
    
    // MARK: - configEPrescriptionCell -
    func configEPrescriptionCell(cell:EPrescriptionCellProtocol, indexPath:IndexPath)  {
        cell.config(display: EPrescriptionDisplatCell(ePrescriptionsList[indexPath.row], msType: pageType))
    }
}
