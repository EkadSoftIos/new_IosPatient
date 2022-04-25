//
//  ForgotPasswordModel.swift
//  E4Doctor
//
//  Created by mac on 12/01/2021.
//
 
 
import Foundation

//class ForgotPasswordModel: Codable {
//    var message: String?
//    var tokencode: String?
//}

struct ForgotPasswordModel: Codable {
    let successtate: Int?
    let errormessage: String?
    let message: ForgotPasswordMsg?
}

// MARK: - Message
struct ForgotPasswordMsg: Codable {
    let message, tokencode: String
}
