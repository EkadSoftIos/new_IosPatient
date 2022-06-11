//
//  OrderListReponse.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/9/22.
//

import Foundation

// MARK: - OrderListReponse
struct OrderListReponse: Codable {
    let successtate: Int
    let errormessage: String?
    let orders: [Order]
    
    enum CodingKeys: String, CodingKey {
        case orders = "message"
        case successtate, errormessage
    }
}

// MARK: - Message
struct Order: Codable {
    let serviceBookingID: Int
    let bookingNumber: String
    let urlToCreateQRCode: String
    let createDate: String
    let doctorName: String?
    let doctorFk:Int?
    let notes: String?
    let price, priceAfterDiscount:Double
    let itemCount, otherProviderBranchID: Int
    let branchNameLocalized: String
    let branchFullAddress: String
    let otherProviderNameLocalized: String
    let otherProviderImage: String
    let otherProviderID: Int
    let otherProviderType: String
    let otherProviderTypeFk: Int

    enum CodingKeys: String, CodingKey {
        case serviceBookingID = "serviceBookingId"
        case bookingNumber, urlToCreateQRCode, createDate, doctorName, doctorFk, notes, price, priceAfterDiscount, itemCount
        case otherProviderBranchID = "otherProviderBranchId"
        case branchNameLocalized = "branchName_Localized"
        case branchFullAddress
        case otherProviderNameLocalized = "otherProviderName_Localized"
        case otherProviderImage
        case otherProviderID = "otherProviderId"
        case otherProviderType, otherProviderTypeFk
    }
}

/*
{
  "BookingNumber": "string",
  "OtherProviderFk": 0,
  "OtherProviderTypeFk": 0,
  "FromDate": "2022-05-23T11:27:18.781Z",
  "ToDate": "2022-05-23T11:27:18.781Z",
  "RowNum": 0,
  "PageNum": 0
}
 {"OtherProviderTypeFk":1,"PageNum":1,"RowNum":10}
*/

struct OrderListRequest:Codable {
    
    var type:MSType? = nil
    var otherProviderFk:Int? = nil
    var fromDate:String? = nil
    var toDate:String? = nil
    var searchBookingNumber:String? = nil
    var pageNum:Int? = nil
    var rowNum:Int = 10
    
    
    enum CodingKeys: String, CodingKey {
        case rowNum = "RowNum"
        case pageNum = "PageNum"
        case toDate = "ToDate"
        case fromDate = "FromDate"
        case type = "OtherProviderTypeFk"
        case otherProviderFk = "OtherProviderFk"
        case searchBookingNumber = "BookingNumber"
    }
    
}
