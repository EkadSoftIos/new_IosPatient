//
//  UIView+Extensions.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 5/31/22.
//

import UIKit


extension UIView{
    
    func applyShadow(_ shadowOpacity:Float = 1, shadowRadius:CGFloat = 5 , shadowOffset:CGSize = CGSize(width: 1, height: 1)) {
        layer.masksToBounds = false
        layer.shadowRadius = shadowRadius
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
    }
    
    
    func applyCustomShadow(shadowColor: UIColor, offSet: CGSize, opacity: Float, shadowRadius: CGFloat, cornerRadius: CGFloat, corners: UIRectCorner) {
        
        let shadowLayer = CAShapeLayer()
        let size = CGSize(width: cornerRadius, height: cornerRadius)
        let cgPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: size).cgPath
        shadowLayer.path = cgPath
        shadowLayer.shadowColor = shadowColor.cgColor
        shadowLayer.shadowPath = cgPath
        shadowLayer.shadowOffset = offSet
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowRadius = shadowRadius
        layer.addSublayer(shadowLayer)
    }
    
}
