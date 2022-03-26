//
//  getEmergencyModel.swift
//  E4 Patient
//
//  Created by mohab on 14/03/2021.
//

import Foundation
struct GetEmergencyModel: Codable {
    var successtate: Int
    var errormessage: String
    var message: [GetEmergencyMessage]
}

// MARK: - Message
struct GetEmergencyMessage: Codable {
    var emergencyID: Int
    var emergencyNameAr, emergencyNameEn, emergencyPhone, createDate: String
    var isActive, deleted: Bool
    var nameLocalized: String

    enum CodingKeys: String, CodingKey {
        case emergencyID = "emergencyId"
        case emergencyNameAr, emergencyNameEn, emergencyPhone, createDate, isActive, deleted
        case nameLocalized = "name_Localized"
    }
}
