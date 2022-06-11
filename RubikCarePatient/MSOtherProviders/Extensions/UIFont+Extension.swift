//
//  UIFont+Extension.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/5/22.
//

import UIKit


extension UIFont{
    
    enum FontStyle {
        case regular, bold
    }
    
    
    
    static func font(style: FontStyle, size: CGFloat, upScaleForIPad: Bool = true ) -> UIFont {
        var size = size
        if UIDevice.current.userInterfaceIdiom == .pad && upScaleForIPad {
            size = size.iPadScalableFontSize
        }
        return UIFont(name: fontName(style: style), size: size) ?? .systemFont(ofSize: size)
    }
    
    
    private static func fontName(style: FontStyle) -> String {
        switch style {
        case .regular: return "SegoeUI"
        case .bold: return "SegoeUI-Semibold"
        }
    }
    
    
}
