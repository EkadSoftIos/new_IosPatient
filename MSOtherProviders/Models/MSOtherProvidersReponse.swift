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
    let message: MSMessage
}

// MARK: - Message
struct MSMessage: Codable {
    let lastPrescriptions: [LastPrescription]
    let ads: [Ad]
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

// MARK: - LastPrescription
struct LastPrescription: Codable {
    let doctorFk, preescriptionID: Int
    let preescriptionDate, doctorNameLocalized: String
    let orderID, orderDate: String?
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
