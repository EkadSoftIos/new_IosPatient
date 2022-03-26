//
//  WhenMedicationMode.swift
//  E4 Patient
//
//  Created by mohab on 21/03/2021.
//

import Foundation
struct getwhenModel: Codable {
    var successtate: Int?
    var errormessage: String?
    var message: [WhenMessage]?
}

// MARK: - Message
struct WhenMessage: Codable {
    var whenMedicationTakenID: Int?
    var whenMedicationTakenNameAr, whenMedicationTakenNameEn, createDate: String?
    var isActive, deleted: Bool?
    var whenMedicationTakenNameLocalized: String?

    enum CodingKeys: String, CodingKey {
        case whenMedicationTakenID = "whenMedicationTakenId"
        case whenMedicationTakenNameAr, whenMedicationTakenNameEn, createDate, isActive, deleted 
        case whenMedicationTakenNameLocalized = "whenMedicationTakenName_Localized"
    }
}
