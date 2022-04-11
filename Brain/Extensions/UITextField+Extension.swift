//
//  UITextField+Extension.swift
//  TYOUT
//
//  Created by Mohamed Lotfy on 10/3/18.
//  Copyright © 2018 Gra7. All rights reserved.
//

import UIKit

extension UITextField{
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }

}

