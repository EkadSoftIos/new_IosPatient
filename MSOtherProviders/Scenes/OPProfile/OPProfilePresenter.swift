//
//  OPProfilePresenter.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/4/22.
//
//

import Foundation
import UIKit

//MARK: Presenter -
protocol OPProfilePresenterProtocol: AnyObject {
    var canAddMS:Bool{ get }
    var type:MSType{ get set }
    var numberOfImagesItems:Int { get }
    var request:RequestType?{ get set }
    var branch:OtherProviderBranch? { get set }
    var msOPServicesRequest:MSOPServicesRequest{ get }
    /**
     * Add here your methods for communication VIEW -> PROTOCOL
     */
    func viewDidLoad()
    func config(cell:ImageCellProtocol, indexPath:IndexPath)
    func add(images:[Image])
    func addNewServices(servicesList:[Service])
    func config(msView:MSViewProtocol)
}

class OPProfilePresenter {
    
    // MARK: - Public properties -
    var type:MSType{
        get{ pageType }
        set{ pageType = newValue }
    }
    
    var request:RequestType?{
        get{ requestType }
        set{ requestType = newValue }
    }
    
    var numberOfImagesItems:Int{
        imagesList.count
    }
    
    var branch: OtherProviderBranch? {
        get{ opBranch }
        set{ opBranch = newValue }
    }
    
    var canAddMS:Bool{
        switch requestType {
        case .eprescription(_): return false
        default: return true
        }
    }

    
    var msOPServicesRequest:MSOPServicesRequest{
        MSOPServicesRequest(
            type: pageType, opTypeFk: pageType,
            branchId: opBranch?.otherProviderBranchID,
            pageNum: 1
        )
    }
    
    // MARK: - Private properties -
    private var pageType:MSType!
    private var msList:[Service] = []
    private var imagesList:[Image] = []
    private var requestType:RequestType?
    private var branchRequest:OPBranchDetailsRequest?
    private var opBranch:OtherProviderBranch?
    private var opBranchDetails:OPBranchDetails?
    private weak var view: OPProfileViewProtocol?
    private var msNetworkRepository:MSNetworkRepository?

    
    // MARK: - Init -
    init(view: OPProfileViewProtocol,
         networkManager:MSNetworkRepository = MSAPIsManager()) {
        self.view = view
        self.msNetworkRepository = networkManager
    }
}

// MARK: - Extensions -
extension OPProfilePresenter: OPProfilePresenterProtocol {
    
    func viewDidLoad() {
        setupRequestType()
        fetchBranchDetails()
    }
    
    // MARK: - addNewServices -
    func addNewServices(servicesList:[Service]) {
        let servicesList = msList.mergeWithUniqueServices(servicesList)
        msList.removeAll()
        msList.append(contentsOf: servicesList)
        fetchBranchDetails()
    }
    
    
    // MARK: - fetchBranchDetails -
    func fetchBranchDetails(){
        branchRequest?.serviceIdList = msList.map({ $0.serviceID })
        guard let request = branchRequest else { return }
        showUniversalLoadingView(true)
        let url = NetworkURL(.opBranchDetails(request))
        msNetworkRepository?.fetch(OPBranchDetailsReponse.self, from: url) { [weak self] result in
            guard let self = self else { return }
            showUniversalLoadingView(false)
            switch result {
            case .success(let response):
                if let error = response.errormessage, response.successtate != 200 {
                    self.view?.showMessageAlert(title: "Error".localized, message: error)
                    return
                }
                self.opBranchDetails = response.branchDetails
                self.view?.setBranchDetails(display: OPBranchDetailsDispaly(branch: response.branchDetails))
                self.view?.addMSSummary()
            case .failure(let error):
                self.view?.showMessageAlert(title: "Error".localized, message: error.localizedDescription)
            }
        }//end closure
    }
    
    // MARK: - config MSViewProtocol -
    func config(msView:MSViewProtocol){
        let servicesList = opBranchDetails?
            .servicePriceList?.compactMap({ ServiceViewDisplay($0) }) ?? []
        
        var totalPrice = 0.0
        var totalPriceBefore = 0.0
        opBranchDetails?.servicePriceList?.forEach({
            totalPriceBefore += $0.price
            totalPrice += $0.priceAfterDiscount
        })
        
        let display = MSViewDisplay(
            title: pageType.msSummary,
            totalPrice: totalPrice.stringValue,
            totalPriceBefore: totalPriceBefore.stringValue,
            isHiddenTotal: servicesList.isEmpty,
            msList: servicesList
        )
        msView.configView(display: display, presenter: self)
    }
}

// MARK: - ImageCellPresenter -
extension OPProfilePresenter:MSViewPresenter{
    
    func deleteMS(at: Int){
        print("OPProfilePresenter did deleted MS")
    }
    
}

// MARK: - ImageCellPresenter -
extension OPProfilePresenter:ImageCellPresenter{
    
    func add(images: [Image]){
        imagesList.append(contentsOf: images)
        view?.reloadImages()
    }
    
    func config(cell:ImageCellProtocol, indexPath:IndexPath){
        let image = imagesList[indexPath.row]
        cell.config(image: image, indexPath: indexPath, presenter: self)
    }
    
    func deleteImage(at indexPath: IndexPath) {
        imagesList.remove(at: indexPath.row)
        view?.reloadImages()
    }
    
}

// MARK: - OPProfilePresenter -
extension OPProfilePresenter {
    
    // MARK: - setupRequestType -
    func setupRequestType() {
        guard let branchId = branch?.otherProviderBranchID else { return }
        branchRequest = OPBranchDetailsRequest(branchId: branchId)
        switch requestType{
        case .services(let msList):
            self.msList.append(contentsOf: msList)
        case .eprescription(let ep):
            msList.append(contentsOf: ep.services)
        case .uploadImage(let images):
            imagesList.append(contentsOf: images)
            view?.reloadImages()
        default:
            break
        }
    }
}

extension OPBranchDetails{
    
    var msPreRequest:NSAttributedString?{
        guard let serviceList = servicePriceList else { return nil }
        let attributedString = NSMutableAttributedString()
        for ms in serviceList {
            attributedString.append(NSAttributedString(
                string: "- \(ms.serviceNameLocalized)\n",
                attributes: [
                    .font: UIFont.font(style: .bold, size: 14),
                    .foregroundColor : UIColor.selectedPCColor ?? UIColor.blue
                ])
            )
            if ms.conditionsList.isEmpty {
                attributedString.append(NSAttributedString(
                    string: "   - \("no Pre-Request".localized)\n",
                    attributes: [
                        .font: UIFont.font(style: .regular, size: 14),
                        .foregroundColor : UIColor.darkGray
                    ]
                ))
                continue
            }
            ms.conditionsList.forEach({
                attributedString.append(NSAttributedString(
                    string: "   - \($0)\n",
                    attributes: [
                        .font: UIFont.font(style: .regular, size: 14),
                        .foregroundColor : UIColor.darkGray
                    ]
                ))
            })
        }
        return attributedString
    }
}


struct OPBranchDetailsDispaly {
    
    let avatar:URL?
    let providerName:String
    let branchName:String
    let branchAddress:String
    let msPreRequest:NSAttributedString?
    
    
    init(branch:OPBranchDetails) {
        providerName = branch.otherProviderNameLocalized
        branchName = branch.branchNameLocalized
        branchAddress = branch.branchFullAddress
        msPreRequest = branch.msPreRequest
        avatar = URL(string: "\(URLs.baseURLImage)\(branch.otherProviderImage)")
    }
}

extension Array{
    
    var uniqueService: [Service] {
        guard let list = self as? [Service] else { return [] }
        var uniqueValues: [Service] = []
        for service in list {
            if uniqueValues.contains(where: { $0.serviceID == service.serviceID }){
                continue
            }
            uniqueValues.append(service)
        }
        return uniqueValues
    }
    
    func mergeWithUniqueServices(_ list2:[Service]) -> [Service] {
        guard let list1 = self as? [Service] else { return [] }
        let servicesList = list1 + list2
        let msList = servicesList.uniqueService
        return msList
    }
}
