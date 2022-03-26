//
//  FontEnum.swift
//  TaxiOrder
//
//  Created by apple on 8/29/19.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation

struct AppFont {
    enum Cairo: String {
        case light      = "Cairo-Light"
        case regular    = "Cairo-Regular"
        case black      = "Cairo-Black"
        case bold       = "Cairo-Bold"
        case extraLight = "Cairo-ExtraLight"
        case semiBold   = "Cairo-SemiBold"
        var value :String {
            return self.rawValue
        }
    }
    
}
