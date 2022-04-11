//
//  textField.swift
//  WasetCaptain
//
//  Created by mohab on 8/25/20.
//  Copyright © 2020 panorama. All rights reserved.
//

import Foundation
import Foundation
import UIKit
class TextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 10)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
