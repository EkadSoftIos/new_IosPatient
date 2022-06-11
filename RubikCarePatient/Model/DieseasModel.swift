//
//  DieseasModel.swift
//  E4 Patient
//
//  Created by mohab on 27/02/2021.
//

import Foundation
struct DieseasModel: Codable {
    let successtate: Int
    let errormessage: String
    let message: [DieseasMessage]
}

// MARK: - Message
struct DieseasMessage: Codable {
    let diseaseID: Int
    let diseaseNameAr, diseaseNameEn, createDate: String
    let isActive, deleted: Bool
  //  let tblPatientDisease, tblPrescription: [JSONAny]
    let nameLocalized: String

    enum CodingKeys: String, CodingKey {
        case diseaseID = "diseaseId"
        case diseaseNameAr, diseaseNameEn, createDate, isActive, deleted/*, tblPatientDisease, tblPrescription*/
        case nameLocalized = "name_Localized"
    }
}
