//
//  ServiceView.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/7/22.
//

import UIKit

struct ServiceViewDisplay{
    let id:Int
    let msName:String
    let price:String
    let priceBefore:String
    let isAvailable:Bool
    
    init(_ service:ServicePriceList){
        id = service.serviceFk
        msName = service.serviceNameLocalized
        price = service.priceAfterDiscount.stringValue
        priceBefore = service.price.stringValue
        isAvailable = true
    }
    
    init(_ totalPrice: String, _ totalPriceBefore: String){
        id = -1
        msName = "Total Cost".localized
        price = totalPrice
        priceBefore = totalPriceBefore
        isAvailable = true
    }
}

class ServiceView: UIView {

    // MARK: - static variables -
    public static var instance:ServiceView{
        Bundle.loadView(fromNib: "ServiceView", withType: ServiceView.self) 
    }
    
    // MARK: - Outlet variables -
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var msNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceBeforeLabel: UILabel!
    
    
    // MARK: - private properties -
    private var id:Int!
    private weak var presenter:MSViewPresenter?
    
    // MARK: - config -
    func configView(display:ServiceViewDisplay, presenter:MSViewPresenter? = nil){
        self.id = display.id
        self.presenter = presenter
        msNameLabel.text = display.msName
        priceLabel.text = display.price
        priceBeforeLabel.text = display.priceBefore
        priceBeforeLabel.setStrikethroughStyle()
        deleteBtn.isHidden = !display.isAvailable
        priceBeforeLabel.isHidden = !display.isAvailable
        if presenter == nil {
            deleteBtn.isHidden = true
            msNameLabel.font = UIFont.font(style: .bold, size: 14)
            priceLabel.font = UIFont.font(style: .bold, size: 14)
            priceBeforeLabel.font = UIFont.font(style: .bold, size: 14)
        }
    }
    
    // MARK: - delete Action -
    @IBAction func deleteBtnTapped(_ sender: Any) {
        presenter?.deleteMS(at: id)
    }
}
