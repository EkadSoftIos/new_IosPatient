//
//  SuccessModel.swift
//  E4 Patient
//
//  Created by mohab on 27/02/2021.
//

import Foundation
struct SuccessModel: Codable {
    let successtate: Int?
    let errormessage, message: String?
}
struct SuccessModelImage: Codable {
    let successtate: Int?
    let errormessage, message: String?
}
struct SuccessWithoutMsgModel: Codable {
    let successtate: Int?
    let errormessage: String?
}
