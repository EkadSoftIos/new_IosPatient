//
//  AdFSPagerViewCell.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 5/31/22.
//

import FSPagerView
import Foundation

protocol FSPagerViewCellProtocol{
    func config(display:SliderDisplayCell)
}

extension FSPagerViewCell: FSPagerViewCellProtocol {
    
    func config(display:SliderDisplayCell) {
        imageView?.kf.indicatorType = .activity
        imageView?.kf.setImage(with: display.imgURL, placeholder: UIImage(named: "placeholder"))
        imageView?.cornerRadius = 20
        imageView?.contentMode = .scaleToFill
        textLabel?.superview?.isHidden = true
        contentView.layer.shadowOpacity = 0.3
    }
    
}
