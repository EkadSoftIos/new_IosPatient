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
    
    
    // MARK: - fetchBranchDetails -
    func fetchBranchDetails(){
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
                self.opBranchDetails = response.message
                self.view?.setBranchDetails(display: OPBranchDetailsDispaly(branch: response.message))
            case .failure(let error):
                self.view?.showMessageAlert(title: "Error".localized, message: error.localizedDescription)
            }
        }//end closure
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

// MARK: - OPProfilePresenter setupRequestType -
extension OPProfilePresenter {
    func setupRequestType() {
        guard let branchId = branch?.otherProviderBranchID else { return }
        branchRequest = OPBranchDetailsRequest(branchId: branchId)
        switch requestType{
        case .services(let msList):
            branchRequest?.serviceIdList = msList.map({ $0.serviceID })
        case .eprescription(let ep):
            branchRequest?.serviceIdList = ep.services.map({ $0.serviceID })
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
