//
//  SpecialityModel.swift
//  E4 Patient
//
//  Created by mohab on 15/03/2021.
//

import Foundation
struct SpecialityModel: Codable {
    var successtate: Int
    var errormessage: String
    var message: [SpecialityMessage]
}

// MARK: - Message
struct SpecialityMessage: Codable {
    var specialityID: Int
    var specialityNameAr, specialityNameEn: String
    var specialityParentFk: Int?
    var createDate: String
    var isActive, deleted: Bool
    var specialityImagePath: String?
    //var specialityParentFkNavigation: JSONNull?
    var inverseSpecialityParentFkNavigation: [Message]
   // var lookupMainCategorySpeciality, tblBusinessProvider, tblBusinessProviderEmployee, tblClient: [JSONAny]
    var nameLocalized, parentSpecialityNameAr, parentSpecialityNameEn: String

    enum CodingKeys: String, CodingKey {
        case specialityID = "specialityId"
        case specialityNameAr, specialityNameEn, specialityParentFk, createDate, isActive, deleted, specialityImagePath, inverseSpecialityParentFkNavigation
              /*lookupMainCategorySpeciality, tblBusinessProvider, tblBusinessProviderEmployee, tblClient, specialityParentFkNavigation*/
        case nameLocalized = "name_Localized"
        case parentSpecialityNameAr, parentSpecialityNameEn
    }
}
