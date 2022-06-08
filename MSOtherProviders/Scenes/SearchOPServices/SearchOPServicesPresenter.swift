//
//  SearchOPServicesPresenter.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 5/29/22.
//
//

import Foundation

//MARK: Presenter -
protocol SearchOPServicesPresenterProtocol: AnyObject {
    var title:String { get }
    var numberOfRows:Int { get }
    var canFetchMore:Bool { get }
    var searchPlaceholder:String{ get }
    var findServicesBtnTitle:String { get }
    var msRequest:MSOPServicesRequest { get set }
    /**
     * Add here your methods for communication VIEW -> PROTOCOL
     */
    func viewDidLoad()
    func config(cell:ServiceCellProtocol, indexPath:IndexPath)
    func fetchSearchedData(text:String)
    func loadMore()
    func services(for selectedIndexPaths:[IndexPath]) -> [Service]
}

class SearchOPServicesPresenter {
    
    // MARK: - Public properties -
    var canFetchMore:Bool{
        rowsNumberOfPage >= 10
    }
    
    var msRequest:MSOPServicesRequest {
        get{ msOPServicesRequest }
        set{ msOPServicesRequest = newValue }
    }
    
    var title:String {
        msOPServicesRequest.type!.searchOPMSTitle
    }
    
    var searchPlaceholder:String{
        msOPServicesRequest.type!.msSearchPlaceholder
    }

    
    var findServicesBtnTitle:String {
        msOPServicesRequest.type!.findServicesBtnTitle
    }
    
    var numberOfRows: Int{
        medicalServicesList.count
    }
    
    // MARK: - Private properties -
    private var rowsNumberOfPage = 0
    private var medicalServicesList:[Service] = []
    private var msOPServicesRequest:MSOPServicesRequest!
    private var msNetworkRepository:MSNetworkRepository?
    private weak var view: SearchOPServicesViewProtocol?
    
    // MARK: - Init -
    init(view: SearchOPServicesViewProtocol,
         networkManager:MSNetworkRepository = MSAPIsManager()) {
        self.view = view
        self.msNetworkRepository = networkManager
    }
    
}

// MARK: - Extensions -
extension SearchOPServicesPresenter: SearchOPServicesPresenterProtocol {
    
    func viewDidLoad() {
        msOPServicesRequest.pageNum = 1
        msOPServicesRequest.opTypeFk = msOPServicesRequest.type
        msOPServicesRequest.type = nil
        if let search = msOPServicesRequest.searchText {
            view?.setSearchText(search)
        }
        fetchMSData()
    }
    
    func services(for selectedIndexPaths:[IndexPath]) -> [Service] {
        selectedIndexPaths.compactMap({ self.medicalServicesList[$0.row] })
    }
    
    // MARK: - fetchData -
    private func fetchMSData() {
        guard let request = msOPServicesRequest else { return }
        let url = NetworkURL(.searchServiceListForPatient(request))
        msNetworkRepository?.fetch(MSReponse.self, from: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                if let error = response.errormessage, response.successtate != 200{
                    self.view?.showMessageAlert(title: .error, message: error)
                    return
                }
                self.rowsNumberOfPage = response.servicesList.count
                self.medicalServicesList.append(contentsOf: response.servicesList)
                self.view?.reloadData()
            case .failure(let error):
                self.view?.showMessageAlert(title: .error, message: error.localizedDescription)
            }
        }//end closure
    }
    
    
    // MARK: - fetchSearchedData -
    func fetchSearchedData(text:String){
        msOPServicesRequest.searchText = text
        msOPServicesRequest.pageNum! = 1
        medicalServicesList.removeAll()
        fetchMSData()
    }
    
    // MARK: - loadMore -
    func loadMore(){
        msOPServicesRequest.pageNum! += 1
        fetchMSData()
    }
    
    
    // MARK: - loadMore -
    func config(cell:ServiceCellProtocol, indexPath:IndexPath){
        let ms = medicalServicesList[indexPath.row]
        let display = ServiceCellDisplay(service: ms, isWithPrice: false)
        cell.config(display: display)
    }
    
}
