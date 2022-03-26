//
//  ProfessionalTitleModel.swift
//  E4 Patient
//
//  Created by Nada on 8/13/21.
//

import Foundation

struct ProfessionalTitleModel: Codable {
    let successtate: Int?
    let errormessage: String?
    let message: [ProfessionalTitleData]?
}

struct ProfessionalTitleData: Codable {
    let profisionalDetailsID: Int?
    let profisionalDetailsNameAr, profisionalDetailsNameEn, createDate: String?
    let isActive, deleted: Bool?
    let createdByID: Int?
    let createdByIDNavigation: String?
    let tblBusinessProviderEmployee: [String]?
    let nameLocalized: String?

    enum CodingKeys: String, CodingKey {
        case profisionalDetailsID = "profisionalDetailsId"
        case profisionalDetailsNameAr, profisionalDetailsNameEn, createDate, isActive, deleted
        case createdByID = "createdById"
        case createdByIDNavigation = "createdByIdNavigation"
        case tblBusinessProviderEmployee
        case nameLocalized = "name_Localized"
    }
}
