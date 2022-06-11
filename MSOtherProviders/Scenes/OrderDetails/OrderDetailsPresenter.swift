//
//  OrderDetailsPresenter.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/10/22.
//
//

import Foundation

//MARK: Presenter -
protocol OrderDetailsPresenterProtocol: AnyObject {
    var type:MSType{ get set }
    var order:Order? { get set }
    var numberOfMSItems:Int { get}
    var numberofImages:Int { get }
    /**
     * Add here your methods for communication VIEW -> PROTOCOL
     */
    func viewDidLoad()
    func config(msView:BookedSViewProtocol, index:Int)
    func config(cell:EPImageCellProtocol,indexPath:IndexPath)
}

class OrderDetailsPresenter {
    
    // MARK: - Public properties -
    var type:MSType{
        get{ pageType }
        set{ pageType = newValue }
    }
    
    var order:Order? {
        get{ msOrder }
        set{ msOrder = newValue }
    }
    
    var numberOfMSItems:Int {
        msDisplay.count
    }
    
    var numberofImages:Int{
        guard let photoList = orderDetails?.files else { return 0 }
        return photoList.count > 2 ? 2:photoList.count
    }
    
    // MARK: - Private properties -
    private var msOrder:Order?
    private var pageType:MSType!
    private var orderDetails:OrderDetails?
    private var msDisplay:[BookedSViewDisplay] = []
    private weak var view: OrderDetailsViewProtocol?
    private var msNetworkRepository:MSNetworkRepository?
    
    // MARK: - Init -
    init(view: OrderDetailsViewProtocol,
         networkManager:MSNetworkRepository = MSAPIsManager()) {
        self.view = view
        self.msNetworkRepository = networkManager
    }
}

// MARK: - Extensions -
extension OrderDetailsPresenter: OrderDetailsPresenterProtocol {
    
    func viewDidLoad() {
       fetchData()
    }
    
    // MARK: - fetchData -
    func fetchData() {
        guard let myOrder = msOrder else { return }
        let url = NetworkURL(.orderDetails(myOrder.serviceBookingID))
        msNetworkRepository?.fetch(OrderDetailsReponse.self, from: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                if let error = response.errormessage, response.successtate != 200 {
                    self.view?.showMessageAlert(title: .error, message: error)
                    return
                }
                self.orderDetails = response.orderDetails
                self.setupMSList()
                self.view?.setupOrderDetails(display: OrderDetailsDisplay(orderDetails: response.orderDetails))
            case .failure(let error):
                self.view?.showMessageAlert(title: .error, message: error.localizedDescription)
            }
        }//end closure
    }
    
    // MARK: - setupMSList -
    private func setupMSList(){
        guard let msOrderDetails = orderDetails,
                  let msDetails = msOrderDetails.msDetails
        else { return  }
        
        
        let msList = msDetails.map({ BookedServiceViewDisplay($0) })
        
        var totalPrice = 0.0
        var totalPriceBefore = 0.0
        msDetails.forEach({
            totalPriceBefore += $0.price
            totalPrice += $0.priceAfterDiscount
        })
        let display = BookedSViewDisplay(
            title: pageType.msOrderDetailsTitle,
            totalPrice: totalPrice.stringValue,
            isHiddenTotal: false,  //(msList.isEmpty || totalPrice <= 0.0),
            msList: msList
        )
        msDisplay.append(display)
    }
    
    // MARK: - config msView -
    func config(msView:BookedSViewProtocol, index:Int){
        let  display = msDisplay[index]
        msView.configView(display: display, presenter: self)
    }
    
    // MARK: - config cell -
    func config(cell:EPImageCellProtocol, indexPath:IndexPath){
        guard let photoList = orderDetails?.files else { return }
        let photo = photoList[indexPath.row]
        let url = URL(string: "\(URLs.baseURLImage)\(photo.filePath)")
        let isLast = (photoList.count > 2 && indexPath.row == 2)
        cell.config(url: url, with: isLast)
    }
}


extension OrderDetailsPresenter:BookedSViewPresenter{
    
    func resultBtnTapped(with id: Int) {
        print("tapped")
    }
}


struct OrderDetailsDisplay {
    let branchName:String
    let providerName:String
    let branchAddress:String
    let isEPPhotoFound:Bool
    let isMSListFound:Bool
    let avatar:URL?
    let qrcode:Image?
    let barcode:Image?
    
    init(orderDetails:OrderDetails) {
        branchName = orderDetails.branchNameLocalized
        providerName = orderDetails.otherProviderNameLocalized
        branchAddress = orderDetails.branchFullAddress
        qrcode = orderDetails.urlToCreateQRCode.generateQRCode
        barcode = orderDetails.bookingNumber.generateBarCode
        avatar = URL(string: "\(URLs.baseURLImage)\(orderDetails.otherProviderImage)")
        isEPPhotoFound = (orderDetails.files?.count ?? 0) > 0
        isMSListFound  = (orderDetails.msDetails?.count ?? 0) > 0
    }
}
