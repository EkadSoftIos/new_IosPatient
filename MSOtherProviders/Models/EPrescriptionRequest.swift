//
//  EPrescriptionRequest.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 5/30/22.
//

import Foundation

//{"PageNum":1,"PatientId":484,"ProviderType":1,"RowNum":10}

struct EPrescriptionRequest:Codable {
    
    var type:MSType? = nil
    
    var patientId:Int? = nil
    
    var pageNum:Int? = nil
    var rowNum:Int = 10
    
    enum CodingKeys: String, CodingKey {
        case rowNum = "RowNum"
        case pageNum = "PageNum"
        case type = "ProviderType"
        case patientId = "PatientId"
    }
    
}
