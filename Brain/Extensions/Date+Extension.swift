//
//  Date+Extension.swift
//  NewHomy
//
//  Created by haniielmalky on 10/13/19.
//  Copyright © 2019 com.Exception. All rights reserved.
//

import Foundation

extension Date {
    
    struct Date_ {
        static let formatter = DateFormatter()
    }
    
    var fullDateString: String {
        Date_.formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        Date_.formatter.locale = NSLocale(localeIdentifier: "en_US") as Locale?
        
        return Date_.formatter.string(from: self)
    }
    
    var dateString: String {
        Date_.formatter.dateFormat = "yyyy-MM-dd"
        Date_.formatter.locale = NSLocale(localeIdentifier: "en_US") as Locale?
        
        return Date_.formatter.string(from: self)
    }
    
    var dayString: String {
        Date_.formatter.dateFormat = "d"
        Date_.formatter.locale = NSLocale(localeIdentifier: "en_US") as Locale?
        
        return Date_.formatter.string(from: self)
    }
    
    var dayNameString: String {
        Date_.formatter.dateFormat = "EEEE"
        Date_.formatter.locale = NSLocale(localeIdentifier: "en_US") as Locale?
        
        return Date_.formatter.string(from: self)
    }
    
    var dayMonthString: String {
        Date_.formatter.dateFormat = "EEE, dd MMMM"
        Date_.formatter.locale = NSLocale(localeIdentifier: "en_US") as Locale?
        
        return Date_.formatter.string(from: self)
    }
    
    var dayMonthTimePMString: String {
        Date_.formatter.dateFormat = "dd MMMM yyyy hh:mm a"
        Date_.formatter.amSymbol = "am"
        Date_.formatter.pmSymbol = "pm"
        Date_.formatter.locale = NSLocale(localeIdentifier: "en_US") as Locale?
        
        return Date_.formatter.string(from: self)
    }
    
    var dayMonthTimeString: String {
         Date_.formatter.dateFormat = "dd MM yyyy hh:mm"
         Date_.formatter.amSymbol = "am"
         Date_.formatter.pmSymbol = "pm"
         Date_.formatter.locale = NSLocale(localeIdentifier: "en_US") as Locale?
         
         return Date_.formatter.string(from: self)
     }
    
    var dateStr: String {
        Date_.formatter.dateFormat = "MM-dd-yyyy"
        Date_.formatter.locale = NSLocale(localeIdentifier: "en_US") as Locale?
        
        return Date_.formatter.string(from: self)
    }
    
    var dateFormatStr: String {
        Date_.formatter.dateFormat = "dd-MM-yyyy"
        Date_.formatter.locale = NSLocale(localeIdentifier: "en_US") as Locale?
        
        return Date_.formatter.string(from: self)
    }
    
    var monthString: String {
        Date_.formatter.dateFormat = "MMM"
        Date_.formatter.locale = NSLocale(localeIdentifier: "en_US") as Locale?
        
        return Date_.formatter.string(from: self)
    }
    
    var monthStr: String {
        Date_.formatter.dateFormat = "MMMM"
        Date_.formatter.locale = NSLocale(localeIdentifier: "en_US") as Locale?
        
        return Date_.formatter.string(from: self)
    }
    
    var yearString: String {
        Date_.formatter.dateFormat = "yyyy"
        Date_.formatter.locale = NSLocale(localeIdentifier: "en_US") as Locale?
        
        return Date_.formatter.string(from: self)
    }
    
    var timeString: String {
        Date_.formatter.dateFormat = "HH:mm:ss"
//        Date_.formatter.dateFormat = "hh:mm:ss a"//"HH:mm"
//        Date_.formatter.amSymbol = "am"
//        Date_.formatter.pmSymbol = "pm"
        Date_.formatter.locale = NSLocale(localeIdentifier: "en_US") as Locale?
        return Date_.formatter.string(from: self)
    }
    
    var hourString: String {
        Date_.formatter.dateFormat = "HH"
 
        Date_.formatter.locale = NSLocale(localeIdentifier: "en_US") as Locale?
        return Date_.formatter.string(from: self)
    }
    
    func checkOverDue(date: Date) -> Bool {
        return (date.compare(self) == ComparisonResult.orderedDescending)
    }
    
    var isOverdue: Bool {
        return (NSDate().compare(self) == ComparisonResult.orderedDescending)
        // deadline is earlier than current date
    }
    
    var isEqualCurrentDate: Bool {
        return (NSDate().compare(self) == ComparisonResult.orderedSame)
    }
    
  
    static var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: Date().noon)!
    }
    static var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: Date().noon)!
    }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
}



