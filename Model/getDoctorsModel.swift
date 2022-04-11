//
//  getDoctorsModel.swift
//  E4 Patient
//
//  Created by mohab on 21/03/2021.
//

import Foundation
struct GetDoctorsModel: Codable {
    var successtate: Int?
    var errormessage: String?
    var message: [GetDoctorsMessage]
}

// MARK: - Message
struct GetDoctorsMessage: Codable {
    var businessProviderEmployeeID, businessProviderFk: Int
    var employeeName: String
    var prefixTitleLocalized: PrefixTitleLocalized?

    enum CodingKeys: String, CodingKey {
        case businessProviderEmployeeID = "businessProviderEmployeeId"
        case businessProviderFk, employeeName
        case prefixTitleLocalized = "prefixTitle_Localized"
    }
}

enum PrefixTitleLocalized: String, Codable {
    case dr = "Dr"
    case empty = ""
    case prof = "Prof"
    case أ = "أ"
}
