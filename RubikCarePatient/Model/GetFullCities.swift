//
//  GetFullCities.swift
//  E4 Patient
//
//  Created by Zyad Galal on 27/02/2021.
//

import Foundation


// MARK: - RepoModel
struct GetFullCitiesModel: Codable {
    let successtate: Int?
    let errormessage: String?
    let message: [GetFullCitiesModelMessage]?
}

// MARK: - Message
struct GetFullCitiesModelMessage: Codable {
    let countryID: Int?
    let countryNameEn: String?
    let lookupCity: [LookupCity]?


    enum CodingKeys: String, CodingKey {
        case countryID = "countryId"
        case countryNameEn
        case lookupCity
    }
}

// MARK: - LookupCity
struct LookupCity: Codable {
    let cityID: Int?
    let cityNameEn: String?
    
    let lookupArea: [LookupArea]?
    
    enum CodingKeys: String, CodingKey {
        case cityID = "cityId"
        case cityNameEn , lookupArea
    }
}

// MARK: - LookupArea
struct LookupArea: Codable {
    let areaID: Int?
    let areaNameEn: String?

    enum CodingKeys: String, CodingKey {
        case areaID = "areaId"
        case areaNameEn
    }
}
