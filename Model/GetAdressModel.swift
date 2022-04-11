//
//  GetAdressModel.swift
//  E4 Patient
//
//  Created by mohab on 26/02/2021.
//

import Foundation
struct GetAdressModel: Codable {
    let successtate: Int
    let errormessage: String
    let message: [AdreessMessage]
}

// MARK: - Message
struct AdreessMessage: Codable {
    let patientAddressID, patientFk: Int
    let patientAddressName: String
    let countryFk: Int
    let countryNameLocalized: String
    let cityFk: Int
    let cityNameLocalized: String
    let areaFk: Int
    let areaNameLocalized, streetName, buldingNum, floor: String
    let landMark, addressLang, addressLat: String
    let mapAddress: String?
    let isMain: Bool
    let createDate: String
    let isActive, deleted: Bool

    enum CodingKeys: String, CodingKey {
        case patientAddressID = "patientAddressId"
        case patientFk, patientAddressName, countryFk
        case countryNameLocalized = "country_name_localized"
        case cityFk
        case cityNameLocalized = "city_name_localized"
        case areaFk
        case areaNameLocalized = "area_name_localized"
        case streetName, buldingNum, floor, landMark, addressLang, addressLat, mapAddress, isMain, createDate, isActive, deleted
    }
}
