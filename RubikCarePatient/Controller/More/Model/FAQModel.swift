//
//  FAQModel.swift
//  E4 Patient
//
//  Created by Ahmed Kassem on 21/05/2022.
//

import Foundation

// MARK: - Welcome
struct FAQModel: Codable {
    let successtate: Int?
    let errormessage: String?
    let message: [FAQData]?
}

// MARK: - Message
struct FAQData: Codable {
    let helpsupportID: Int?
    let helpsupportNameAr, helpsupportNameEn, helpsupportAnswerAr, helpsupportAnswerEn: String?
    let createDate, nameLocalized, helpsupportAnswerLocalized: String?

    enum CodingKeys: String, CodingKey {
        case helpsupportID = "helpsupportId"
        case helpsupportNameAr, helpsupportNameEn, helpsupportAnswerAr, helpsupportAnswerEn, createDate
        case nameLocalized = "name_Localized"
        case helpsupportAnswerLocalized = "helpsupportAnswer_Localized"
    }
}
