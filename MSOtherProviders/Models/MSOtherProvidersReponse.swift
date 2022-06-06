//
//  MSResponse.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 5/24/22.
//

import Foundation

// MARK: - MedicalServicesReponse
struct MSOtherProvidersReponse: Codable {
    let successtate: Int
    let errormessage: String?
    let message: MSData
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
    let servicePrescriptionID, serviceID: Int
    let serviceNameLocalized, serviceTypeNameLocalized: String
    let serviceTypeID, otherProviderTypeFk: Int
    let conditionsList: [String]

    enum CodingKeys: String, CodingKey {
        case servicePrescriptionID = "servicePrescriptionId"
        case serviceID = "serviceId"
        case serviceNameLocalized = "serviceName_Localized"
        case serviceTypeNameLocalized = "serviceTypeName_Localized"
        case serviceTypeID = "serviceTypeId"
        case otherProviderTypeFk
        case conditionsList = "conditions_list"
    }
}

