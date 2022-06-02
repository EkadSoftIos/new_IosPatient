//
//  UILabel+Extenions.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 5/31/22.
//

import UIKit

extension UILabel {
    
    func setStrikethroughStyle(){
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: text ?? "")
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
        attributedText = attributeString
    }
    
}
