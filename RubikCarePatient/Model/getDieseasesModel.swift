//
//  getDieseasesModel.swift
//  E4 Patient
//
//  Created by mohab on 09/03/2021.
//

import Foundation
struct getDieseasesModel: Codable {
    var successtate: Int
    var errormessage: String
    var message: [DieseasesMessage]
}

// MARK: - Message
struct DieseasesMessage: Codable {
    var diseaseID: Int
    var diseaseNameAr, diseaseNameEn, createDate: String
    var isActive, deleted: Bool
   // var tblPatientDisease, tblPrescription: [JSONAny]
    var nameLocalized: String

    enum CodingKeys: String, CodingKey {
        case diseaseID = "diseaseId"
        case diseaseNameAr, diseaseNameEn, createDate, isActive, deleted/*, tblPatientDisease, tblPrescription*/
        case nameLocalized = "name_Localized"
    }
}
