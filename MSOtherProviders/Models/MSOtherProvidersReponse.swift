//
//  MSResponse.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 5/24/22.
//

import Foundation

// MARK: - MSOPListReponse
struct OPListReponse: Codable {
    let successtate: Int
    let errormessage: String?
    let opsList: [OtherProvider]
    
    enum CodingKeys: String, CodingKey {
        case opsList = "message"
        case successtate, errormessage
    }
}

// MARK: - Message
struct OtherProvider: Codable {
    let otherProviderID: Int
    let otherProviderNameLocalized: String

    enum CodingKeys: String, CodingKey {
        case otherProviderID = "otherProviderId"
        case otherProviderNameLocalized = "otherProviderName_Localized"
    }
}

// MARK: - MedicalServicesReponse
struct MSOtherProvidersReponse: Codable {
    let successtate: Int
    let errormessage: String?
    let msData: MSData
    
    enum CodingKeys: String, CodingKey {
        case msData = "message"
        case successtate, errormessage
    }
}

// MARK: - Message
struct MSData: Codable {
    let lastPrescriptions: [EPrescription]
    let ads: [Ad]?
}



// MARK: - Ad
struct Ad: Codable {
    let otherProviderAdvertisementID: Int
    let image: String

    enum CodingKeys: String, CodingKey {
        case otherProviderAdvertisementID = "otherProviderAdvertisementId"
        case image
    }
}

// MARK: - Service
struct Service: Codable {
    let serviceID: Int
    let serviceNameLocalized: String
    let serviceTypeNameLocalized: String
    let conditionsList: [String]
    let commessionNetValue: Double?

    
    let servicePrescriptionID: Int?
    let serviceTypeID: Int?
    let otherProviderTypeFk:MSType?

    let serviceTypeFk: Int?
    let price, priceAfterDiscount: Double?
    
    enum CodingKeys: String, CodingKey {
        case servicePrescriptionID = "servicePrescriptionId"
        case serviceID = "serviceId"
        case serviceNameLocalized = "serviceName_Localized"
        case serviceTypeNameLocalized = "serviceTypeName_Localized"
        case serviceTypeID = "serviceTypeId"
        case otherProviderTypeFk, commessionNetValue
        case conditionsList = "conditions_list"
        case serviceTypeFk, price, priceAfterDiscount
    }
}
