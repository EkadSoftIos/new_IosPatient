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

// MARK: - EPsReponse
struct EPsReponse: Codable {
    let successtate: Int
    let errormessage: String?
    let message: [EPrescription]
}

// MARK: - Message
struct EPrescription: Codable {
    let doctorFk, preescriptionID: Int
    let orderID, orderDate: String?
    let preescriptionDate, doctorNameLocalized: String
    let doctorProfileImage: String?
    let services: [Service]

    enum CodingKeys: String, CodingKey {
        case doctorFk
        case preescriptionID = "preescriptionId"
        case preescriptionDate
        case orderID = "orderId"
        case orderDate
        case doctorNameLocalized = "doctor_name_Localized"
        case doctorProfileImage = "doctor_ProfileImage"
        case services
    }
}

