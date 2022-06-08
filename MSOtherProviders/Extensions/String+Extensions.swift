//
//  String+Extensions.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 5/31/22.
//

import UIKit


extension String{
    
    public static var loading:String{
        "Loading...".localized
    }
    
    public static var storeOrder:String{
        "Please, wait your order is being booked.".localized
    }
    
    public static var uploadingImges:String{
        "Uploading Prescriptions images.".localized
    }
    
    public static var error:String{
        "Error".localized
    }
    
    public static var enableLocationServices:String{
        "Please Enable Location Services in the Settings".localized
    }
    
}

extension String {
    
    
    func ifBlank(use string: String) -> String {
        isBlank ? string : self
    }
    
    var isBlank: Bool {
        trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || trimmingCharacters(in: .whitespacesAndNewlines).lowercased() == "null"
    }
    
    func font(ofSize size:CGFloat = 15) -> UIFont {
        UIFont(name: self, size: size) ?? .systemFont(ofSize: size)
    }
        
}

extension String{
    
    var doubleValue:Double{
        Double(self) ?? 0.0
    }
    
    var dateFormated:String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        var dateFromDateFormatter = dateFormatter.date(from:self)
        if dateFromDateFormatter == nil{
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
            dateFromDateFormatter = dateFormatter.date(from:self)
        }
        guard let date = dateFromDateFormatter else{
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

extension String {
    
    var generateQRCode:UIImage?{
        guard let filter = CIFilter(name: "CIQRCodeGenerator"),
              !isEmpty
        else { return nil }
        
        let data = data(using: String.Encoding.ascii)
        filter.setValue(data, forKey: "inputMessage")
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        guard let output = filter.outputImage?.transformed(by: transform)
        else { return nil }
        
        return UIImage(ciImage: output)
    }
    
    var generateBarCode:UIImage?{
        guard let filter = CIFilter(name: "CICode128BarcodeGenerator"),
              !isEmpty
        else { return nil }
        
        let data = data(using: String.Encoding.ascii)
        filter.setValue(data, forKey: "inputMessage")
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        guard let output = filter.outputImage?.transformed(by: transform)
        else { return nil }
        
        return UIImage(ciImage: output)
    }
    
}
