//
//  WalletTransactionModel.swift
//  E4 Patient
//
//  Created by Ahmed Kassem on 04/06/2022.
//

import Foundation

// MARK: - Welcome
struct WalletTransactionModel: Codable {
    let successtate: Int?
    let errormessage: String?
    let message: [WalletTransactionData]?
}

// MARK: - Message
struct WalletTransactionData: Codable {
    let patientWaletID, patientFk, balanceBefore: Int?
    let amount: Int?
    let balanceAfter, factor, transactionType: Int?
    let paymentType, bookingFk, orderFk, textBookingFk: Int?
    let textBookingNo: String?
    let transactionDate: String?
    let currencyFk: Int?
    let createDate: String?
    let consultationServiceNameLocalized: String?
    let consultationServiceFk: Int?
    let doctorName: String?
    let patientName: String?
    let transactionTypeName: String?
    let paymentTypeName: String?

    enum CodingKeys: String, CodingKey {
        case patientWaletID = "patientWaletId"
        case patientFk, balanceBefore, amount, balanceAfter, factor, transactionType, paymentType, bookingFk, orderFk, textBookingFk, textBookingNo, transactionDate, currencyFk, createDate
        case consultationServiceNameLocalized = "consultationServiceName_Localized"
        case consultationServiceFk, doctorName, patientName, transactionTypeName, paymentTypeName
    }
}
