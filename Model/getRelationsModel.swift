//
//  getRelations.swift
//  E4 Patient
//
//  Created by mohab on 06/03/2021.
//

import Foundation
struct getRelationsModel: Codable {
    let successtate: Int?
    let errormessage: String?
    let message: [getRelationsMessage]?
}

// MARK: - Message
struct getRelationsMessage: Codable {
    let relationID: Int?
    let relationNameAr, relationNameEn: String?
    let createDate: String?
    let isActive, deleted: Bool?
    let nameLocalized: String?

    enum CodingKeys: String, CodingKey {
        case relationID = "relationId"
        case relationNameAr, relationNameEn, createDate, isActive, deleted
        case nameLocalized = "name_Localized"
    }
}
