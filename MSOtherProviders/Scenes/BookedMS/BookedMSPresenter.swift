//
//  BookedMSPresenter.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/8/22.
//
//

import Foundation

//MARK: Presenter -
protocol BookedMSPresenterProtocol: AnyObject {
    var order:OrderInfo { get set }
    var eprescription: EPrescription? { get set }
    /**
     * Add here your methods for communication VIEW -> PROTOCOL
     */
    func viewDidLoad()
}

class BookedMSPresenter {
    
    // MARK: - Public properties -
    var order: OrderInfo{
        get{ orderInfo }
        set{ orderInfo = newValue }
    }
    
    var eprescription: EPrescription? {
        get{ ep }
        set{ ep = newValue }
    }
    
    // MARK: - Private properties -
    private var ep:EPrescription?
    private var orderInfo: OrderInfo!
    private weak var view: BookedMSViewProtocol?
    
    // MARK: - Init -
    init(view: BookedMSViewProtocol) {
        self.view = view
    }
}

// MARK: - Extensions -
extension BookedMSPresenter: BookedMSPresenterProtocol {
    
    func viewDidLoad() {
        guard let qrcode = orderInfo.urlToCreateQRCode.generateQRCode,
        let barcode = orderInfo.bookingNumber.generateBarCode
        else {
            view?.showMessageAlert(title: .error, message: "")
            return
        }
        var doctorName:String?
        if let doctor = ep?.doctorNameLocalized{
            doctorName = "\("By Dr:".localized) \(doctor)"
        }
            
        view?.updateView(qrcode: qrcode, barcode: barcode, doctorName: doctorName)
    }
}
