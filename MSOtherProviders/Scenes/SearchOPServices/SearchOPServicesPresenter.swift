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
    var searchPlaceholder:String{ get }
    var findServicesBtnTitle:String { get }
    
    var msRequest:MSOPServicesRequest { get set }
    /**
     * Add here your methods for communication VIEW -> PROTOCOL
     */
    func viewDidLoad()
    func fetchSearchedData(_ searchText:String?)
}

extension SearchOPServicesPresenterProtocol{
    
    func fetchSearchedData(_ searchText:String? = nil){
        fetchSearchedData(searchText)
    }
}

class SearchOPServicesPresenter {
    
    // MARK: - Public properties -
    var msRequest:MSOPServicesRequest {
        get{ msOPServicesRequest }
        set{ msOPServicesRequest = newValue }
    }
    
    var title:String {
        msOPServicesRequest.type == .labs ? "Labs Search".localized:"Rays Search".localized
    }
    
    var searchPlaceholder:String{
        msOPServicesRequest.type == .labs ? "Search by test name".localized:"Search by rays name".localized
    }

    
    var findServicesBtnTitle:String {
        msOPServicesRequest.type == .labs ? "Find Labs".localized:"Find Centers".localized
    }
    
    // MARK: - Private properties -
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
        fetchSearchedData()
    }
    
    // MARK: - fetchData -
    func fetchSearchedData(_ searchText:String? = nil) {
        if let text = searchText { msOPServicesRequest.searchText = text }
        guard let request = msOPServicesRequest else { return }
        let url = NetworkURL(.searchServiceListForPatient(request))
    }
}
