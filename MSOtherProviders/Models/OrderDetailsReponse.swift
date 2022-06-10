//
//  OrderDetailsReponse.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/10/22.
//

import Foundation

// MARK: - OrderDetailsReponse
struct OrderDetailsReponse: Codable {
    let successtate: Int
    let errormessage: String?
    let orderDetails: OrderDetails
    
    enum CodingKeys: String, CodingKey {
        case orderDetails = "message"
        case successtate, errormessage
    }
}

// MARK: - Message
struct OrderDetails: Codable {
    let serviceBookingID: Int
    let bookingNumber: String
    let urlToCreateQRCode: String
    let createDate:String
    let doctorName: String?
    let doctorFk:Int?
    let notes: String?
    let price, priceAfterDiscount, itemCount, otherProviderBranchID: Int
    let branchNameLocalized, branchFullAddress, otherProviderNameLocalized, otherProviderImage: String
    let otherProviderID: Int
    let otherProviderType: String
    let otherProviderTypeFk: Int
    let files: [EPFile]?
    let msDetails: [MSDetail]?
    let hasMedicalReport: Bool
    let patientMedicalReportID, businessProviderEmployeeFk: Int?
    let prescriptionDoctorName: String

    enum CodingKeys: String, CodingKey {
        case serviceBookingID = "serviceBookingId"
        case bookingNumber, urlToCreateQRCode, createDate, doctorName, doctorFk, notes, price, priceAfterDiscount, itemCount
        case otherProviderBranchID = "otherProviderBranchId"
        case branchNameLocalized = "branchName_Localized"
        case branchFullAddress
        case msDetails = "details"
        case otherProviderNameLocalized = "otherProviderName_Localized"
        case otherProviderImage
        case otherProviderID = "otherProviderId"
        case otherProviderType, otherProviderTypeFk, files, hasMedicalReport
        case patientMedicalReportID = "patientMedicalReportId"
        case businessProviderEmployeeFk, prescriptionDoctorName
    }
}

// MARK: - Detail
struct MSDetail: Codable {
    let serviceBookingDetailsID: Int
    let commessionValue: Double
    let notes: String?
    let otherProviderBranchServiceFk, serviceID: Int
    let price, priceAfterDiscount:Double
    let serviceNameLocalized: String
    
    enum CodingKeys: String, CodingKey {
        case serviceBookingDetailsID = "serviceBookingDetailsId"
        case commessionValue, notes, price, priceAfterDiscount, otherProviderBranchServiceFk
        case serviceID = "serviceId"
        case serviceNameLocalized = "serviceName_Localized"
    }
}

// MARK: - File
struct EPFile: Codable {
    let serviceBookingFileID: Int
    let filePath: String

    enum CodingKeys: String, CodingKey {
        case serviceBookingFileID = "serviceBookingFileId"
        case filePath
    }
}
