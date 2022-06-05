//
//  CGFloat+Extension.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/5/22.
//

import UIKit


extension CGFloat{
    
    static func constant(ofSize size: CGFloat, upScaleForIPad: Bool = true ) -> CGFloat {
        var size = size
        if UIDevice.current.userInterfaceIdiom == .pad && upScaleForIPad {
            size = size.iPadScalableFontSize
        }
        return size
    }
    
    static func constantMenu(ofSize size: CGFloat, upScaleForIPad: Bool = true ) -> CGFloat {
        var size = size
        if UIDevice.current.userInterfaceIdiom == .pad && upScaleForIPad {
            size = size + 50
        }
        return size
    }
}

extension CGFloat {
    var iPadScalableFontSize: Self {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return self * Self(1.5)
        } else {
            return self
        }
    }
}
