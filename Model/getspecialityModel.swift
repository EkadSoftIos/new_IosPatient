//
//  getspecialityModel.swift
//  E4 Patient
//
//  Created by mohab on 22/03/2021.
//

import Foundation
struct GetspecialityModel: Codable {
    var successtate: Int?
    var errormessage: String?
    var message: [GetspecialityMessage]?
}

// MARK: - Message
struct GetspecialityMessage: Codable {
    var specialityID: Int?
    var specialityNameAr, specialityNameEn: String?
    var specialityParentFk: Int?
    var createDate: String?
    var isActive, deleted: Bool?
    var specialityImagePath: String?
    //var specialityParentFkNavigation: Int?
   // var inverseSpecialityParentFkNavigation: [Message]?
    var nameLocalized, parentSpecialityNameAr, parentSpecialityNameEn: String?

    enum CodingKeys: String, CodingKey {
        case specialityID = "specialityId"
        case specialityNameAr, specialityNameEn, specialityParentFk, createDate, isActive, deleted, specialityImagePath
        case nameLocalized = "name_Localized"
        case parentSpecialityNameAr, parentSpecialityNameEn
    }
}
//, specialityParentFkNavigation , inverseSpecialityParentFkNavigation
