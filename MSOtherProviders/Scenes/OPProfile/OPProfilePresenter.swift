//
//  OPProfilePresenter.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/4/22.
//
//

import Foundation
import PKHUD

//MARK: Presenter -
protocol OPProfilePresenterProtocol: AnyObject {
    var canAddMS:Bool{ get }
    var type:MSType{ get set }
    var numberOfImagesItems:Int { get }
    var numberOfSummaryItems:Int { get }
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
    func config(msView:BookingMSViewProtocol, index:Int)
    func bookingServices()
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
    
    var numberOfSummaryItems:Int{
        msSummaryDisplay.count
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
    //
    private var pageType:MSType!
    private var msList:[Service] = []
    private var msSummaryDisplay:[BookingMSViewDisplay] = []
    private var availableMSList:[ServicePriceList] = []
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
        HUD.show(.progress)
        let url = NetworkURL(.opBranchDetails(request))
        msNetworkRepository?.fetch(OPBranchDetailsReponse.self, from: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                if let error = response.errormessage, response.successtate != 200 {
                    if HUD.isVisible { HUD.flash(.error) }
                    self.view?.showMessageAlert(title: .error, message: error)
                    return
                }
                if HUD.isVisible { HUD.flash(.success) }
                self.opBranchDetails = response.branchDetails
                self.availableMSList.removeAll()
                self.availableMSList.append(contentsOf: response.branchDetails.servicePriceList ?? [])
                self.view?.setBranchDetails(display: OPBranchDetailsDispaly(branch: response.branchDetails))
                self.addMSSummary()
            case .failure(let error):
                if HUD.isVisible { HUD.flash(.error) }
                self.view?.showMessageAlert(title: .error, message: error.localizedDescription)
            }
        }//end closure
    }
    
    
    
    // MARK: - add Summary  -
    private func addMSSummary(){
        msSummaryDisplay.removeAll()
        if let msSummary = getPageMSListSummary() {
            msSummaryDisplay.append(msSummary)
        }
        if let msSummary = getOtherMSListSummary() {
            msSummaryDisplay.append(msSummary)
        }
        self.view?.reloadMSSummary()
    }
    
    // MARK: - getPageMSListSummary -
    private func getPageMSListSummary() -> BookingMSViewDisplay? {
        let pageMSList = msList.filter({
            if let opTypeFk = $0.otherProviderTypeFk {
                return opTypeFk == pageType
            }
             return true
        })
        let pageAvailableMSList = availableMSList.filter({ $0.otherProviderTypeFk == pageType })
        
        if pageMSList.isEmpty, pageAvailableMSList.isEmpty  { return nil }

        
        var servicesList = pageAvailableMSList.compactMap({
            BookingServiceViewDisplay($0)
        })
        
        let unavailableMSList = pageMSList
            .unrepeatedService(pageAvailableMSList)
            .compactMap({
                BookingServiceViewDisplay($0)
            })
        servicesList.append(contentsOf: unavailableMSList)
        // calculate totl price
        var totalPrice = 0.0
        var totalPriceBefore = 0.0
        pageAvailableMSList.forEach({
            totalPriceBefore += $0.price
            totalPrice += $0.priceAfterDiscount
        })
        return BookingMSViewDisplay(
            title: pageType.msSummary,
            totalPrice: totalPrice.stringValue,
            totalPriceBefore: totalPriceBefore.stringValue,
            isHiddenTotal: (servicesList.isEmpty || totalPrice <= 0.0),
            msList: servicesList
        )
    }
    
    
    // MARK: - getOtherMSListSummary -
    private func getOtherMSListSummary() -> BookingMSViewDisplay? {
        let otherType = pageType.othersType
        let otherMSList = msList
            .filter({ $0.otherProviderTypeFk == otherType })
        // other ms page type
        let otherAvailablMSList = availableMSList.filter({ $0.otherProviderTypeFk == otherType })
        
        if otherMSList.isEmpty, otherAvailablMSList.isEmpty  { return nil }
        
        var servicesList = otherAvailablMSList.compactMap({
            BookingServiceViewDisplay($0, isHiddenDeleteBtn: true)
        })
        
        let unavailableMSList = otherMSList
            .unrepeatedService(otherAvailablMSList)
            .compactMap({
                BookingServiceViewDisplay($0)
            })
        servicesList.append(contentsOf: unavailableMSList)
        // calculate totl price
        var totalPrice = 0.0
        var totalPriceBefore = 0.0
        otherAvailablMSList.forEach({
            totalPriceBefore += $0.price
            totalPrice += $0.priceAfterDiscount
        })
        return BookingMSViewDisplay(
            title: otherType.msSummary,
            totalPrice: totalPrice.stringValue,
            totalPriceBefore: totalPriceBefore.stringValue,
            isHiddenTotal: (servicesList.isEmpty || totalPrice <= 0.0),
            msList: servicesList
        )
    }
    
    
    // MARK: - config MSViewProtocol -
    func config(msView:BookingMSViewProtocol, index:Int){
        let display = msSummaryDisplay[index]
        msView.configView(display: display, presenter: self)
    }
}

// MARK: - ImageCellPresenter -
extension OPProfilePresenter:BookingMSViewPresenter{
    
    func deleteMS(with id: Int){
        if let msIndex = msList.firstIndex(where: { $0.serviceID == id }),
           let availableMSIndex = availableMSList.firstIndex(where: { $0.serviceFk == id }) {
            msList.remove(at: msIndex)
            availableMSList.remove(at: availableMSIndex)
            addMSSummary()
            let serviceBookingDetailsList = availableMSList.filter({ $0.otherProviderTypeFk == pageType }).map({
                MSOrderRequest(
                    serviceId: $0.serviceFk,
                    price: $0.price,
                    priceAfterDiscount: $0.priceAfterDiscount,
                    commessionValue: $0.commessionNetValue
                )
            })
            if serviceBookingDetailsList.isEmpty {
                self.view?.showMessageAlert(title: .error, message: .chooseMS)
                return
            }
        }
    }
    
//    func deleteMS(with id: Int) -> Bool{
//        if let msIndex = availableMSList.firstIndex(where: { $0.serviceFk == id }){
//            availableMSList.remove(at: msIndex)
//            return true
//        }
//        return false
//    }
    
}


// MARK: - OPProfilePresenter Store Order  -
extension OPProfilePresenter{
    
    
    // MARK: -  bookingServices  -
    func bookingServices() {
        guard let branch = opBranchDetails else { return }
        let serviceBookingDetailsList = availableMSList.filter({ $0.otherProviderTypeFk == pageType }).map({
            MSOrderRequest(
                serviceId: $0.serviceFk,
                price: $0.price,
                priceAfterDiscount: $0.priceAfterDiscount,
                commessionValue: $0.commessionNetValue
            )
        })
        
        func showErrorMessage() ->Bool{
            func canMakeOrder()->Bool {
                if serviceBookingDetailsList.isEmpty { return false}
                return true
            }
            
            
            let isCan = canMakeOrder()
            if !isCan { view?.showMessageAlert(title: .error, message: .chooseMS) }
            return !isCan
        }

        
        switch requestType{
        case .services(_):
            if showErrorMessage(){ return }
            let request = AddOrderRequest(
                type: pageType,
                opBranchId: branch.otherProviderBranchID,
                serviceBookingDetails: serviceBookingDetailsList
            )
            storeServiceOrder(request)
        case .eprescription(let ep):
            let request = AddOrderRequest(
                type: pageType,
                opBranchId: branch.otherProviderBranchID,
                doctorName: ep.doctorNameLocalized,
                prescriptionId: ep.preescriptionID,
                serviceBookingDetails:serviceBookingDetailsList
            )
            storeServiceOrder(request, ep:ep)
        case .uploadImage(_):
            let request = AddOrderRequest(
                type: pageType,
                opBranchId: branch.otherProviderBranchID,
                serviceBookingDetails: serviceBookingDetailsList
            )
            uploadImages(request)
        default:
            break
        }
    }
    
    // MARK: -  storeServiceOrder  -
    private func storeServiceOrder(_ request:AddOrderRequest, ep:EPrescription? = nil){
        HUD.show(.progress)
        let url = NetworkURL(.addNewOrder(request))
        msNetworkRepository?.fetch(AddOrderReponse.self, from: url){ [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                if let error = response.errormessage, response.successtate != 200 {
                    if HUD.isVisible { HUD.flash(.error) }
                    self.view?.showMessageAlert(title: .error, message: error)
                    return
                }
                if HUD.isVisible { HUD.flash(.success) }
                self.view?.showBookedServices(response.orderInfo, ep: ep)
            case .failure(let error):
                if HUD.isVisible { HUD.flash(.error) }
                self.view?.showMessageAlert(title: .error, message: error.localizedDescription)
            }
        }//end closure
    }
    
    // MARK: -  uploadImages  -
    private func uploadImages(_ request:AddOrderRequest){
        HUD.show(.progress)
        var imagesData:[(name:String, image:Data)] = []
        for index in 0...imagesList.count - 1{
            if let imgData = imagesList[index].pngData(){
                imagesData.append(("prescription\( UUID().uuidString)", imgData))
            }
        }
        let url = NetworkURL(.uploadImages)
        msNetworkRepository?.upload(imagesData, UPImagesReponse.self, from: url){ [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                if let error = response.errormessage, response.successtate != 200 {
                    if HUD.isVisible { HUD.flash(.error) }
                    self.view?.showMessageAlert(title: .error, message: error)
                    return
                }
                let addOrderRequest = AddOrderRequest(
                    type: request.type,
                    opBranchId: request.opBranchId,
                    doctorName: request.doctorName,
                    prescriptionId: request.prescriptionId,
                    filePathList:  response.filePathList,
                    serviceBookingDetails: request.serviceBookingDetails
                )
                self.linkUploadPrescriptionFiles(addOrderRequest)
            case .failure(let error):
                if HUD.isVisible { HUD.flash(.error) }
                self.view?.showMessageAlert(title: .error, message: error.localizedDescription)
            }
        }//end closure
    }
    
    // MARK: -  linkUploadPrescriptionFiles  -
    private func linkUploadPrescriptionFiles(_ request:AddOrderRequest){
        let upFilesequest = UPFilesRequest(
            type: request.type,
            filePathList: request.filePathList
        )
        let url = NetworkURL(.upFilesRequest(upFilesequest))
        msNetworkRepository?.fetch(UPFilesReponse.self, from: url){ [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                if let error = response.errormessage, response.successtate != 200 {
                    if HUD.isVisible { HUD.flash(.error) }
                    self.view?.showMessageAlert(title: .error, message: error)
                    return
                }
                self.storeServiceOrder(request)
            case .failure(let error):
                if HUD.isVisible { HUD.flash(.error) }
                self.view?.showMessageAlert(title: .error, message: error.localizedDescription)
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
            if ms.conditionsList.isEmpty { continue }
            attributedString.append(NSAttributedString(
                string: "- \(ms.serviceNameLocalized)\n",
                attributes: [
                    .font: UIFont.font(style: .bold, size: 14),
                    .foregroundColor : UIColor.selectedPCColor ?? UIColor.blue
                ])
            )
//            if ms.conditionsList.isEmpty {
//                attributedString.append(NSAttributedString(
//                    string: "   - \("no Pre-Request".localized)\n",
//                    attributes: [
//                        .font: UIFont.font(style: .regular, size: 14),
//                        .foregroundColor : UIColor.darkGray
//                    ]
//                ))
//                continue
//            }
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
        if let msPreRequest = branch.msPreRequest, msPreRequest.length > 0 {
            self.msPreRequest = msPreRequest
        }else{ self.msPreRequest = nil }
        avatar = URL(string: "\(URLs.baseURLImage)\(branch.otherProviderImage)")
    }
}

extension Array{
    
    fileprivate var uniqueService: [Service] {
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
    
    fileprivate func unrepeatedService(_ spList:[ServicePriceList]) -> [Service] {
        guard let list = self as? [Service] else { return [] }
        var unrepeatedService: [Service] = []
        for service in list {
            if spList.contains(where: { $0.serviceFk == service.serviceID }){
                continue
            }
            unrepeatedService.append(service)
        }
        return unrepeatedService
    }
    
    fileprivate func mergeWithUniqueServices(_ list2:[Service]) -> [Service] {
        guard let list1 = self as? [Service] else { return [] }
        let servicesList = list1 + list2
        let msList = servicesList.uniqueService
        return msList
    }
}
