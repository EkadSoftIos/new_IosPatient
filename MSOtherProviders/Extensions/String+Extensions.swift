//
//  String+Extensions.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 5/31/22.
//

import Foundation


extension String{
    
    var dateFormated:String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        guard let date = dateFormatter.date(from:self) else{
            return self
        }
        let formatter = DateFormatter()
        var calendar = Calendar.current
        let code = Languagee.language.rawValue
        calendar.locale = Locale(identifier: code)
        formatter.calendar = calendar
        formatter.dateFormat = "MMM dd, yyyy"
        formatter.locale = Locale(identifier: code)
        let dateString = formatter.string(from: date)
        return dateString
    }
    
}