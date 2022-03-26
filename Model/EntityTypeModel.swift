//
//  EntityTypeModel.swift
//  E4 Patient
//
//  Created by mohab on 15/03/2021.
//

import Foundation
struct EntityTypeModel: Codable {
    var successtate: Int
    var errormessage: String
    var message: [EntityTypeMessage]
}

// MARK: - Message
struct EntityTypeMessage: Codable {
    var entityTypeID: Int
    var entityTypeNameAr, entityTypeNameEn, createDate: String
    var isActive, deleted: Bool
   // var lookupConsultationService, lookupEmployeeType, tblBusinessProvider, tblAdvertise: [JSONAny]
    var nameLocalized: String

    enum CodingKeys: String, CodingKey {
        case entityTypeID = "entityTypeId"
        case entityTypeNameAr, entityTypeNameEn, createDate, isActive, deleted
             //, lookupConsultationService, lookupEmployeeType, tblBusinessProvider, tblAdvertise
        case nameLocalized = "name_Localized"
    }
}
