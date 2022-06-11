//
//  BookedServiceView.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/10/22.
//

import Foundation

import UIKit

struct BookedServiceViewDisplay{
    let id:Int
    let msName:String
    let price:String
    let isHiddenResultBtn:Bool
    
    init(_ ms:MSDetail, isHiddenResultBtn:Bool = false){
        id = ms.serviceBookingDetailsID
        msName = ms.serviceNameLocalized
        price = ms.priceAfterDiscount.stringValue
        self.isHiddenResultBtn = isHiddenResultBtn
    }
    
    init(_ totalPrice: String){
        id = -1
        msName = "Total Cost".localized
        price = totalPrice
        isHiddenResultBtn = true
    }
}

class BookedServiceView: UIView {

    // MARK: - static variables -
    public static var instance:BookedServiceView{
        Bundle.loadView(fromNib: "BookedServiceView", withType: BookedServiceView.self)
    }
    
    // MARK: - Outlet variables -
    @IBOutlet weak var resultBtn: UIButton!
    @IBOutlet weak var msNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    // MARK: - private properties -
    private var id:Int!
    private weak var presenter:BookedSViewPresenter?
    
    // MARK: - config -
    func configView(display:BookedServiceViewDisplay, presenter:BookedSViewPresenter? = nil){
        tag = display.id
        self.id = display.id
        self.presenter = presenter
        msNameLabel.text = display.msName
        priceLabel.text = display.price
        resultBtn.isHidden = display.isHiddenResultBtn
        if presenter == nil {
            resultBtn.isHidden = true
            msNameLabel.font = UIFont.font(style: .bold, size: 14)
            priceLabel.font = UIFont.font(style: .bold, size: 14)
        }
    }
    
    // MARK: - delete Action -
    @IBAction func resultBtnTapped(_ sender: Any) {
    }

}
