//
//  ReportServiceListModel.swift
//  E4 Patient
//
//  Created by Ahmed Kassem on 29/05/2022.
//

import Foundation

struct ReportServiceListModel: Codable {
    let successtate: Int?
    let errormessage: String?
    let message: [ReportServiceListData]?
}

// MARK: - Message
struct ReportServiceListData: Codable {
    let id: Int?
    let nameLocalized: String?

    enum CodingKeys: String, CodingKey {
        case id
        case nameLocalized = "name_Localized"
    }
}
