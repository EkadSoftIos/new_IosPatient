//
//  UserLocation.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/2/22.
//

import Foundation

// MARK: - ULocationReponse
struct ULocationReponse: Codable {
    let successtate: Int
    let errormessage: String?
    let message: [ULCountry]
}

// MARK: - Country
struct ULCountry: Codable {
    let imageCountryUploadURL, noLogo: String
    let countryID: Int
    let countryNameAr, countryNameEn, countryShortName, countryLogo: String
    let countryCode: String
    let countryRequiredPhoneNum: Int
    let createDate: String
    let isActive, deleted: Bool
    let lookupCity: [City]
    let countryLogoPng1000Px, countryLogoPng100Px, countryLogoPng250Px, countryLogoSVG: String
    let nameLocalized: String

    enum CodingKeys: String, CodingKey {
        case imageCountryUploadURL
        case noLogo = "no_Logo"
        case countryID = "countryId"
        case countryNameAr, countryNameEn, countryShortName, countryLogo, countryCode, countryRequiredPhoneNum, createDate, isActive, deleted, lookupCity
        case countryLogoPng1000Px = "countryLogo_png1000px"
        case countryLogoPng100Px = "countryLogo_png100px"
        case countryLogoPng250Px = "countryLogo_png250px"
        case countryLogoSVG = "countryLogo_svg"
        case nameLocalized = "name_Localized"
    }
}

// MARK: - LookupCity
struct City: Codable {
    let cityID: Int
    let cityNameAr, cityNameEn: String
    let countryFk: Int
    let createDate: String
    let isActive, deleted: Bool
    let lookupArea: [Area]
    let nameLocalized: String

    enum CodingKeys: String, CodingKey {
        case cityID = "cityId"
        case cityNameAr, cityNameEn, countryFk, createDate, isActive, deleted, lookupArea
        case nameLocalized = "name_Localized"
    }
}

// MARK: - LookupArea
struct Area: Codable {
    let areaID: Int
    let areaNameAr, areaNameEn: String
    let cityFk: Int
    let createDate: String
    let isActive, deleted: Bool
    let createdByID: Int?
    let createdByIDNavigation: String?
    let nameLocalized: String

    enum CodingKeys: String, CodingKey {
        case areaID = "areaId"
        case areaNameAr, areaNameEn, cityFk, createDate, isActive, deleted
        case createdByID = "createdById"
        case createdByIDNavigation = "createdByIdNavigation"
        case nameLocalized = "name_Localized"
    }
}
