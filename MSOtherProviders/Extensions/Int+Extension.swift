//
//  Int+Extension.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/7/22.
//

import Foundation


extension Int{
    
    func stringServicesValue(_ servicesNum:Int)-> String{
        String(format: "%d/%d %@", self, servicesNum,  "Services".localized)
    }
}
