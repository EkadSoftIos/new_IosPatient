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

extension Int {
    
    var generateQRCode:UIImage?{
        guard let filter = CIFilter(name: "CIQRCodeGenerator"),
              !"\(self)".isEmpty
        else { return nil }
        
        let data = "\(self)".data(using: String.Encoding.ascii)
        filter.setValue(data, forKey: "inputMessage")
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        guard let output = filter.outputImage?.transformed(by: transform)
        else { return nil }
        
        return UIImage(ciImage: output)
    }
    
    var generateBarCode:UIImage?{
        guard let filter = CIFilter(name: "CICode128BarcodeGenerator"),
              !"\(self)".isEmpty
        else { return nil }
        
        let data = "\(self)".data(using: String.Encoding.ascii)
        filter.setValue(data, forKey: "inputMessage")
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        guard let output = filter.outputImage?.transformed(by: transform)
        else { return nil }
        
        return UIImage(ciImage: output)
    }
    
}
