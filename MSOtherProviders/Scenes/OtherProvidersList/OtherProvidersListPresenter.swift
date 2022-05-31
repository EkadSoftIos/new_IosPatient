//
//  OtherProvidersListPresenter.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 5/30/22.
//
//

import Foundation


enum RequestType {
    case uploadImage(Image)
    case services([MedicalService])
    case eprescription(EPrescription)
}

//MARK: Presenter -
protocol OtherProvidersListPresenterProtocol: AnyObject {
    var title:String { get }
    var type:MSType { get set}
    var numberOfRows:Int { get }
    var canFetchMore:Bool { get }
    var request:RequestType? { get set }
    /**
     * Add here your methods for communication VIEW -> PROTOCOL
     */
    func viewDidLoad()
    func config(cell:OtherProviderCellProtocol, indexPath:IndexPath)
    func loadMore()
    func sortList(accordingTo sort:SortType)
}

class OtherProvidersListPresenter {
    
    // MARK: - Public properties -
    var type:MSType{
        get{ pageType }
        set{ pageType = newValue }
    }
    
    var request:RequestType?{
        get{ requestType }
        set{ requestType = newValue }
    }
    
    var numberOfRows: Int{
        opBranchesList.count
    }
    
    var canFetchMore:Bool{
        rowsNumberOfPage >= 10
    }
    
    var title:String {
        pageType == .labs ?  "Labs".localized:"Centers".localized
    }
    
    // MARK: - Private properties -
    private var rowsNumberOfPage = 0
    private var pageType:MSType!
    private var opRequest:OPRequest!
    private var requestType:RequestType?
    private var opBranchesList:[OtherProviderBranch] = []
    private var msNetworkRepository:MSNetworkRepository?
    private weak var view: OtherProvidersListViewProtocol?
    
    // MARK: - Init -
    init(view: OtherProvidersListViewProtocol,
         networkManager:MSNetworkRepository = MSAPIsManager()) {
        self.view = view
        self.msNetworkRepository = networkManager
    }
}

// MARK: - Extensions -
extension OtherProvidersListPresenter: OtherProvidersListPresenterProtocol {
    
    func viewDidLoad() {
        setOPRequest()
        fetchOPData()
    }
    
    func setOPRequest(){
        opRequest = OPRequest()
        opRequest.providerType = pageType
        opRequest.pageNum = 1
        setupRequestType()
    }
    
    // MARK: - fetchOPData -
    private func fetchOPData() {
        let url = NetworkURL(.otherProviders(opRequest))
        msNetworkRepository?.fetch(OPsReponse.self, from: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                if let error = response.errormessage, response.successtate != 200 {
                    self.view?.showMessageAlert(title: "Error".localized, message: error)
                    return
                }
                self.rowsNumberOfPage = response.message.count
                self.opBranchesList.append(contentsOf: response.message)
                self.view?.reloadData()
            case .failure(let error):
                self.view?.showMessageAlert(title: "Error".localized, message: error.localizedDescription)
            }
        }//end closure
    }
    
    // MARK: - loadMore -
    func loadMore(){
        opRequest.pageNum! += 1
        fetchOPData()
    }
    
    func sortList(accordingTo sort:SortType){
        opBranchesList.removeAll()
        opRequest.pageNum! = 1
        opRequest.sortType = sort
        fetchOPData()
    }
    
    // MARK: - config -
    func config(cell:OtherProviderCellProtocol, indexPath:IndexPath){
        let branch = opBranchesList[indexPath.row]
        let servicesNum = opRequest.serviceIdList?.count ?? 0
        cell.config(display: OtherProviderDisplay(branch: branch, servicesNum: servicesNum))
    }
    
}

extension OtherProvidersListPresenter{
    func setupRequestType() {
        switch requestType{
        case .services(let msList):
            opRequest.serviceIdList = msList.map({ $0.serviceID })
            guard let ms = msList.first else { return }
            var searchResultText = "\("Search Result for".localized) \(ms.serviceNameLocalized)"
            if msList.count > 1 {
                searchResultText.append(contentsOf: " + \(msList.count - 1) \(pageType == .labs ? "Tests".localized:"Rays".localized)")
            }
            view?.searchResultText = searchResultText
        case .eprescription(let ep):
            opRequest.serviceIdList = ep.services.map({ $0.serviceID })
            view?.setEP(display: EPrescriptionDisplay(ep, msType: pageType))
            guard let ms = ep.services.first else { return }
            var searchResultText = "\("Search Result for".localized) \(ms.serviceNameLocalized)"
            if ep.services.count > 1 {
                searchResultText.append(contentsOf: " + \(ep.services.count - 1) \(pageType == .labs ? "Tests".localized:"Rays".localized)")
            }
            view?.searchResultText = searchResultText
        case .uploadImage(let image):
            let searchResultText = "\("Search Result for".localized) \("uploaded image".localized)"
            
            view?.searchResultText = searchResultText
            break
        default:
            break
        }
    }
}
