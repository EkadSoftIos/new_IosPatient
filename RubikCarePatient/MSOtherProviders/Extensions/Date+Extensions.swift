//
//  Date+Extension.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/9/22.
//

import Foundation


extension Date{
    
    var asString:String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.string(from: self)
    }
    
    func dateByAdding( component: Calendar.Component, value:Int) -> Date{
        let calendar = Calendar.current
        return calendar.date(byAdding: component, value: value, to: self) ?? self
    }
    
}
