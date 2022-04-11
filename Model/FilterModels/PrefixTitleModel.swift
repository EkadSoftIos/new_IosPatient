//
//  PrefixTitleModel.swift
//  E4 Patient
//
//  Created by Nada on 8/12/21.
//

import Foundation

struct PrefixtitleModel: Codable {
    let successtate: Int?
    let errormessage: String?
    let message: [prefixData]?
}

struct prefixData: Codable {
    let prefixTitleID: Int?
    let prefixTitleNameAr, prefixTitleNameEn: String?
    let createDate: String?
    let isActive: Bool?
    let deleted: Bool?
    let createdByID: Int?
    let createdByIDNavigation: String?
    let tblBusinessProviderEmployee: [String]?
    let nameLocalized: String?

    enum CodingKeys: String, CodingKey {
        case prefixTitleID = "prefixTitleId"
        case prefixTitleNameAr, prefixTitleNameEn, createDate, isActive, deleted
        case createdByID = "createdById"
        case createdByIDNavigation = "createdByIdNavigation"
        case tblBusinessProviderEmployee
        case nameLocalized = "name_Localized"
    }
}
