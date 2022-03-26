//
//  BusinessProviderModel.swift
//  E4 Patient
//
//  Created by mohab on 30/03/2021.
//

import Foundation
struct BusinessProviderModel: Codable {
    var successtate: Int?
    var errormessage: String?
    var message: [BusinessProviderMessage]?
}

// MARK: - Message
struct BusinessProviderMessage: Codable {
    var businessProviderID: Int?
    var entityNameLocalized: String?

    enum CodingKeys: String, CodingKey {
        case businessProviderID = "businessProviderId"
        case entityNameLocalized = "entityName_Localized"
    }
}
