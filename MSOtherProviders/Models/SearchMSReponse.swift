//
//  SearchMSReponse.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 5/30/22.
//

import Foundation


// MARK: - MSReponse
struct MSReponse: Codable {
    let successtate: Int
    let errormessage: String?
    let message: [MedicalService]
}

// MARK: - Message
struct MedicalService: Codable {
    let serviceID: Int
    let serviceNameLocalized: String
    let serviceTypeFk: Int
    let serviceTypeNameLocalized: String
    let price, priceAfterDiscount: Double?
    let commessionNetValue: Double
    let conditionsList: [String]

    enum CodingKeys: String, CodingKey {
        case serviceID = "serviceId"
        case serviceNameLocalized = "serviceName_Localized"
        case serviceTypeFk
        case serviceTypeNameLocalized = "serviceTypeName_Localized"
        case price, priceAfterDiscount, commessionNetValue
        case conditionsList = "conditions_list"
    }
}

