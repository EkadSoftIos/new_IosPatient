//
//  MSView.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/7/22.
//

import UIKit
import SwiftUI
import SwiftMessages

class MSView: UIView, BookingMSViewProtocol, BookedSViewProtocol{

    // MARK: - static variables -
    public static var instance:MSView{
        Bundle.loadView(fromNib: "MSView", withType: MSView.self)
    }
    
    // MARK: - Outlet variables -
    @IBOutlet weak var msTitleLabel: UILabel!
    @IBOutlet weak var msListStackView: UIStackView!
    
    // MARK: - private properties -
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyShadow( 0.3 )
    }
    
    // MARK: - config -
    func configView(display: BookingMSViewDisplay, presenter: BookingMSViewPresenter){
        msTitleLabel.text = display.title
        for ms in display.msList {
            let msView = BookingServiceView.instance
            msView.configView(display: ms, presenter: presenter)
            msListStackView.addArrangedSubview(msView)
        }
        if !display.isHiddenTotal {
            let display = BookingServiceViewDisplay(display.totalPrice, display.totalPriceBefore)
            let msView = BookingServiceView.instance
            msView.configView(display: display)
            msListStackView.addArrangedSubview(msView)
        }
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    // MARK: - config -
    func configView(display: BookedSViewDisplay, presenter: BookedSViewPresenter){
        msTitleLabel.text = display.title
        for ms in display.msList {
            let msView = BookedServiceView.instance
            msView.configView(display: ms, presenter: presenter)
            msListStackView.addArrangedSubview(msView)
        }
        if !display.isHiddenTotal {
            let display = BookedServiceViewDisplay(display.totalPrice)
            let msView = BookedServiceView.instance
            msView.configView(display: display)
            msListStackView.addArrangedSubview(msView)
        }
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    
}


protocol BookingMSViewPresenter:AnyObject{
    func deleteMS(with id:Int)
}


protocol BookingMSViewProtocol{
    func configView(display:BookingMSViewDisplay, presenter:BookingMSViewPresenter)
}


struct BookingMSViewDisplay{
    let title: String
    let totalPrice: String
    let totalPriceBefore: String
    let isHiddenTotal:Bool
    let msList:[BookingServiceViewDisplay]
}

protocol BookedSViewPresenter:AnyObject{
    func resultBtnTapped(with id:Int)
}

protocol BookedSViewProtocol{
    func configView(display: BookedSViewDisplay, presenter: BookedSViewPresenter)
}

struct BookedSViewDisplay{
    let title: String
    let totalPrice: String
    let isHiddenTotal:Bool
    let msList:[BookedServiceViewDisplay]
}

