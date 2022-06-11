//
//  ServiceView.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/7/22.
//

import UIKit

struct BookingServiceViewDisplay{
    let id:Int
    let msName:String
    let price:String
    let priceBefore:String
    let isAvailable:Bool
    let isHiddenDeleteBtn:Bool
    
    init(_ service:ServicePriceList, isHiddenDeleteBtn:Bool = false){
        id = service.serviceFk
        msName = service.serviceNameLocalized
        price = service.priceAfterDiscount.stringValue
        priceBefore = service.price.stringValue
        isAvailable = true
        self.isHiddenDeleteBtn = isHiddenDeleteBtn
    }
    
    init(_ service:Service){
        id = service.serviceID
        msName = service.serviceNameLocalized
        price = "unavailable".localized
        priceBefore = ""
        isAvailable = false
        isHiddenDeleteBtn = true
    }
    
    
    init(_ totalPrice: String, _ totalPriceBefore: String){
        id = -1
        msName = "Total Cost".localized
        price = totalPrice
        priceBefore = totalPriceBefore
        isAvailable = true
        isHiddenDeleteBtn = true
    }
}

class BookingServiceView: UIView {

    // MARK: - static variables -
    public static var instance:BookingServiceView{
        Bundle.loadView(fromNib: "BookingServiceView", withType: BookingServiceView.self)
    }
    
    // MARK: - Outlet variables -
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var msNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceBeforeLabel: UILabel!
    
    
    // MARK: - private properties -
    private var id:Int!
    private weak var presenter:BookingMSViewPresenter?
    
    // MARK: - config -
    func configView(display:BookingServiceViewDisplay, presenter:BookingMSViewPresenter? = nil){
        tag = display.id
        self.id = display.id
        self.presenter = presenter
        msNameLabel.text = display.msName
        priceLabel.text = display.price
        priceBeforeLabel.text = display.priceBefore
        priceBeforeLabel.setStrikethroughStyle()
        deleteBtn.isHidden = display.isHiddenDeleteBtn
        if !display.isAvailable { priceLabel.textColor = .red }
        else { priceLabel.textColor = .selectedPCColor }
        if presenter == nil {
            deleteBtn.isHidden = true
            msNameLabel.font = UIFont.font(style: .bold, size: 14)
            priceLabel.font = UIFont.font(style: .bold, size: 14)
            priceBeforeLabel.font = UIFont.font(style: .bold, size: 14)
        }
    }
    
    // MARK: - delete Action -
    @IBAction func deleteBtnTapped(_ sender: Any) {
        presenter?.deleteMS(with: id)
    }
    
    
    
//    @IBAction func deleteBtnTapped(_ sender: Any) {
//        if let isDeleted = presenter?.deleteMS(with: id), isDeleted {
//            removeView(with: id)
//        }
//    }
    
//    func removeView(with tag:Int){
//        guard let superView = superview as? UIStackView
//        else { return }
//        superView.removeArrangedSubview(with: tag)
//    }
}
