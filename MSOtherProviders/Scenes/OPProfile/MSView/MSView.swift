//
//  MSView.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/7/22.
//

import UIKit
import SwiftUI
import SwiftMessages

protocol MSViewPresenter:AnyObject{
    func deleteMS(at index:Int)
}

protocol MSViewProtocol{
    func configView(display:MSViewDisplay, presenter:MSViewPresenter)
}

struct MSViewDisplay{
    let title: String
    let totalPrice: String
    let totalPriceBefore: String
    let isHiddenTotal:Bool
    let msList:[ServiceViewDisplay]
}

class MSView: UIView, MSViewProtocol{

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
    func configView(display: MSViewDisplay, presenter: MSViewPresenter){
        msTitleLabel.text = display.title
        for ms in display.msList {
            let msView = ServiceView.instance
            msView.configView(display: ms, presenter: presenter)
            msListStackView.addArrangedSubview(msView)
        }
        if !display.isHiddenTotal {
            let display = ServiceViewDisplay(display.totalPrice, display.totalPriceBefore)
            let msView = ServiceView.instance
            msView.configView(display: display)
            msListStackView.addArrangedSubview(msView)
        }
        setNeedsLayout()
        layoutIfNeeded()
    }
}

