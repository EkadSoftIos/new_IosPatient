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
    let businessProviderEmployeeID, businessProviderFk: Int?
    let employeeName: String?
    let prefixTitleLocalized: String?
    let loggedUserID: Int?
    let  phone, email: String?

    enum CodingKeys: String, CodingKey {
        case businessProviderEmployeeID = "businessProviderEmployeeId"
        case businessProviderFk, employeeName
        case prefixTitleLocalized = "prefixTitle_Localized"
        case loggedUserID = "loggedUserId"
        case phone, email
    }
}

