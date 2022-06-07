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
    
}

extension Float {
    
    var stringValue:String{
        String(format: "%.01f \("EGP".localized)", self)
    }
    
}
