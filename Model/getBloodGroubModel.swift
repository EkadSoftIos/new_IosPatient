//
//  getBloodGroubModel.swift
//  E4 Patient
//
//  Created by mohab on 11/03/2021.
//

import Foundation
struct getBloodGroubModel: Codable {
    var successtate: Int
    var errormessage: String
    var message: [BloodGrouMessage]
}

// MARK: - Message
struct BloodGrouMessage: Codable {
    var blodGroupID: Int
    var blodGroupNameAr, blodGroupNameEn, createDate: String
    var isActive, deleted: Bool
    //var tblPatient: [JSONAny]
    var nameLocalized: String

    enum CodingKeys: String, CodingKey {
        case blodGroupID = "blodGroupId"
        case blodGroupNameAr, blodGroupNameEn, createDate, isActive, deleted/*, tblPatient*/
        case nameLocalized = "name_Localized"
    }
}
