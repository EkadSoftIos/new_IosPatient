//
//  DoubleExtesnion.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/7/22.
//

import Foundation


extension Double {
    
    var stringValue:String{
        String(format: "%.01f \("EGP".localized)", self)
    }
    
    var totalStringValue:NSAttributedString {
        let attributedString = NSMutableAttributedString()
        let dText = String(format: "%.01f", self)
        attributedString.append(NSAttributedString(
            string: "\("Total".localized)\n\(dText)",
            attributes: [
                .font: UIFont.font(style: .bold, size: 14),
                .foregroundColor : UIColor.selectedPCColor ?? UIColor.blue
            ])
        )
        attributedString.append(NSAttributedString(
            string: " \("EGP".localized)",
            attributes: [
                .font: UIFont.font(style: .regular, size: 12),
                .foregroundColor : UIColor.selectedPCColor ?? UIColor.blue
            ])
        )
        return attributedString
    }
    
}
