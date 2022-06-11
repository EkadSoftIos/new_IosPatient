//
//  File.swift
//  E4 Patient
//
//  Created by mohab on 13/03/2021.
//

import Foundation
struct DiseaseStatusModel: Codable {
    var successtate: Int
    var errormessage: String
    var message: [DiseaseStatusMessage]
}

// MARK: - Message
struct DiseaseStatusMessage: Codable {
    var diseaseStatusID: Int
    var diseaseStatusNameAr, diseaseStatusNameEn, createDate: String
    var isActive, deleted: Bool
   // var tblPatientDisease, tblPatientMedicine: [JSONAny]
    var nameLocalized: String

    enum CodingKeys: String, CodingKey {
        case diseaseStatusID = "diseaseStatusId"
        case diseaseStatusNameAr, diseaseStatusNameEn, createDate, isActive, deleted/*, tblPatientDisease, tblPatientMedicine*/
        case nameLocalized = "name_Localized"
    }
}
