//
//  WalletModel.swift
//  E4 Patient
//
//  Created by Ahmed Kassem on 04/06/2022.
//

import Foundation

struct WalletModel: Codable {
    let successtate: Int?
    let errormessage: String?
    let message: WalletData?
}

// MARK: - Message
struct WalletData: Codable {
    let patientID: Int?
    let totalIncome, totalExpense, totalPending: Double?
    let totalAvaliableBalance, totalCurrentBalance: Double?

    enum CodingKeys: String, CodingKey {
        case patientID = "patientId"
        case totalIncome, totalExpense, totalPending, totalAvaliableBalance, totalCurrentBalance
    }
}
