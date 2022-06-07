//
//  AddMSPresenter.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/6/22.
//
//

import Foundation

//MARK: Presenter -
protocol AddMSPresenterProtocol: AnyObject {
    var type:MSType{ get set }
    var canFetchMore:Bool { get }
    var numberOfRows:Int { get }
    var request:MSOPServicesRequest{ get set }
    /**
     * Add here your methods for communication VIEW -> PROTOCOL
     */
    func viewDidLoad()
    func config(cell:ServiceCellProtocol, indexPath:IndexPath)
    func fetchSearchedData(text:String?, selectedIndex:Int?)
    func loadMore()
    func services(for selectedIndexPaths:[IndexPath]) -> [Service]
}

extension AddMSPresenterProtocol{
    
    func fetchSearchedData(text:String? = nil, selectedIndex:Int? = nil){
        fetchSearchedData(text: text, selectedIndex: selectedIndex)
    }
    
}

class AddMSPresenter {
    
    // MARK: - Public properties -
    
    var type:MSType{
        get{ pageType }
        set{ pageType = newValue }
    }
    
    var canFetchMore:Bool{
        rowsNumberOfPage >= 10
    }
    
    var numberOfRows: Int{
        medicalServicesList.count
    }
    
    var request:MSOPServicesRequest{
        get{ msOPServicesRequest }
        set{ msOPServicesRequest = newValue }
    }
    
    // MARK: - Private properties -
    private var pageType:MSType!
    private var rowsNumberOfPage = 0
    private var serviceTypeList:[ServiceType] = []
    private var medicalServicesList:[Service] = []
    private var msOPServicesRequest:MSOPServicesRequest!
    private var msNetworkRepository:MSNetworkRepository?
    private var dispatchGroup = DispatchGroup()
    private weak var view: AddMSViewProtocol?
    
    // MARK: - Init -
    init(view: AddMSViewProtocol,
         networkManager:MSNetworkRepository = MSAPIsManager()) {
        self.view = view
        self.msNetworkRepository = networkManager
    }
    
}

// MARK: - Extensions -
extension AddMSPresenter: AddMSPresenterProtocol {
    
    func viewDidLoad() {
        fetchMSData()
        fetchSTData()
        notify()
    }
    
    func notify() {
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            let optionArray = self.serviceTypeList.map({ $0.serviceTypeNameLocalized })
            self.view?.reloadDropDown(optionArray: optionArray)
            self.view?.reloadData()
        }
    }
    
    // MARK: - fetchData -
    private func fetchSTData() {
        let url = NetworkURL(.serviceTypeList(MSOPServicesRequest(opTypeFk: pageType)))
        dispatchGroup.enter()
        msNetworkRepository?.fetch(STListReponse.self, from: url) { [weak self] result in
            guard let self = self else { return }
            self.dispatchGroup.leave()
            switch result {
            case .success(let response):
                if let error = response.errormessage, response.successtate != 200{
                    self.view?.showMessageAlert(title: "Error".localized, message: error)
                    return
                }
                self.serviceTypeList.append(contentsOf: response.message)
            case .failure(let error):
                self.view?.showMessageAlert(title: "Error".localized, message: error.localizedDescription)
            }
        }//end closure
    }
    
    // MARK: - fetchData -
    private func fetchMSData() {
        guard let request = msOPServicesRequest else { return }
        let url = NetworkURL(.searchServiceListForPatient(request))
        dispatchGroup.enter()
        msNetworkRepository?.fetch(MSReponse.self, from: url) { [weak self] result in
            guard let self = self else { return }
            self.dispatchGroup.leave()
            switch result {
            case .success(let response):
                if let error = response.errormessage, response.successtate != 200{
                    self.view?.showMessageAlert(title: "Error".localized, message: error)
                    return
                }
                self.rowsNumberOfPage = response.message.count
                self.medicalServicesList.append(contentsOf: response.message)
            case .failure(let error):
                self.view?.showMessageAlert(title: "Error".localized, message: error.localizedDescription)
            }
        }//end closure
    }
    
    
    // MARK: - fetchSearchedData -
    func fetchSearchedData(text:String? = nil,  selectedIndex:Int? = nil) {
        if text == nil && selectedIndex == nil { return }
        if let searchText = text {
            msOPServicesRequest.searchText = searchText
        }
        if let selectedIndex = selectedIndex{
            msOPServicesRequest.serviceTypeFk = serviceTypeList[selectedIndex].serviceTypeID
        }
        msOPServicesRequest.pageNum! = 1
        medicalServicesList.removeAll()
        showUniversalLoadingView(true)
        fetchMSData()
        notify()
    }
    
    // MARK: - loadMore -
    func loadMore(){
        msOPServicesRequest.pageNum! += 1
        fetchMSData()
    }
    
    
    // MARK: - loadMore -
    func config(cell:ServiceCellProtocol, indexPath:IndexPath){
        let ms = medicalServicesList[indexPath.row]
        let display = ServiceCellDisplay(service: ms, isWithPrice: true)
        cell.config(display: display)
    }
    
    // MARK: - services for selectedIndexPaths -
    func services(for selectedIndexPaths:[IndexPath]) -> [Service] {
        selectedIndexPaths.compactMap({ self.medicalServicesList[$0.row] })
    }
}
