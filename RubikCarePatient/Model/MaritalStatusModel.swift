//
//  MaritalStatusModel.swift
//  E4 Patient
//
//  Created by mohab on 13/03/2021.
//

import Foundation
struct MaritalStatusModel: Codable {
    var successtate: Int
    var errormessage: String
    var message: [MaritalStatusMessage]
}

// MARK: - Message
struct MaritalStatusMessage: Codable {
    var maritalStatusID: Int
    var maritalStatusNameAr, maritalStatusNameEn, createDate: String
    var isActive, deleted: Bool
    //var tblPatientSocialHistory: [JSONAny]
    var nameLocalized: String

    enum CodingKeys: String, CodingKey {
        case maritalStatusID = "maritalStatusId"
        case maritalStatusNameAr, maritalStatusNameEn, createDate, isActive, deleted/*, tblPatientSocialHistory*/
        case nameLocalized = "name_Localized"
    }
}
