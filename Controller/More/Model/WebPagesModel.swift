//
//  WebPagesModel.swift
//  E4 Patient
//
//  Created by Ahmed Kassem on 21/05/2022.
//

import Foundation

struct WebPagesModel: Codable {
    let successtate: Int?
    let errormessage: String?
    let message: [WebPagesData]?
}

// MARK: - Message
struct WebPagesData: Codable {
    let id: Int?
    let name: String?
    let url: String?
    let content: String?
}
