//
//  employeIDModel.swift
//  E4 Patient
//
//  Created by mohab on 31/03/2021.
//

import Foundation
struct BusinessProvideremployeModel: Codable {
    var successtate: Int?
    var errormessage: String?
    var message: [BusinessProvideremployeMessage]?
}

// MARK: - Message
struct BusinessProvideremployeMessage: Codable {
    var businessProviderEmployeeID, businessProviderFk: Int?
    var employeeName, prefixTitleLocalized: String?

    enum CodingKeys: String, CodingKey {
        case businessProviderEmployeeID = "businessProviderEmployeeId"
        case businessProviderFk, employeeName
        case prefixTitleLocalized = "prefixTitle_Localized"
    }
}
