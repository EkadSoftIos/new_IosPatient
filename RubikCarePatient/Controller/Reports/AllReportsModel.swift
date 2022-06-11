//
//  AllReportsModel.swift
//  E4 Patient
//
//  Created by Ahmed Kassem on 25/05/2022.
//

import Foundation

// MARK: - AllReportsModel
struct AllReportsModel: Codable {
    let successtate: Int?
    let errormessage: String?
    let message: [AllReportsData]?
}

// MARK: - Message
struct AllReportsData: Codable {
    let id, type: Int?
    let clientName: String?
    let doctorName: String?
    let doctorProfileImage: String?
    let doctorBranchNameLocalized: String?
    let entityNameLocalized: String?
    let imagepath: String?
    let name: String?
    let profileImage: String?
    let email: String?
    let mobileCode, mobile: String?
    let patientGender, patientWeight, patientHeight: Int?
    let patientBirthDate: String?
    let blodGroupFk: Int?
    let blodGroupnameLocalized: String
    let bookingNo, doctorFk, patientOrRepFk, serviceType: Int
    let businessProviderBranchFk, patientAddressFk: Int?
    let medicalServiceFk: Int?
    let consultationServiceFk: Int?
    let consultationServiceLocalized: String?
    let medicalServiceLocalized, bookingDate, startTime: String?
    let endTime: String?
    let bookingReason: String?
    let bookingFees: Int?
    let eCliniccommission, paymentType: Int?
    let currencyFk: Int?
    let bookingStatus: Int?
    let bookingSummery: String?
    let showBookingSummeryTopatient, isOverBooking: Bool?
    let isPaied: Bool?
    let paiedDate: String?
    let branchAddressLocalized: String?
    let patientAddressLocalized: String?
    let patientOrPharma: String?
    let serviceTypeName: String?
    let bookingStatusName: String?
    let paymentTypeName: String?
    let typeName: String?
//    let history: [JSONAny]
    let bookingAvilableButtons: BookingAvilableButtons?
    let readyToStartVideo: Bool?
    let doctorInsuranceFk, bookingInsuranceFees: Int?
    let totalBookingFees: Int?

    enum CodingKeys: String, CodingKey {
        case id, type
        case clientName = "client_name"
        case doctorName = "doctor_name"
        case doctorProfileImage = "doctor_ProfileImage"
        case doctorBranchNameLocalized = "doctor_BranchName_Localized"
        case entityNameLocalized = "entityName_Localized"
        case imagepath, name, profileImage, email, mobileCode, mobile, patientGender, patientWeight, patientHeight, patientBirthDate, blodGroupFk
        case blodGroupnameLocalized = "blodGroupname_Localized"
        case bookingNo, doctorFk, patientOrRepFk, serviceType, businessProviderBranchFk, patientAddressFk, medicalServiceFk, consultationServiceFk
        case consultationServiceLocalized = "consultationService_localized"
        case medicalServiceLocalized = "medicalService_localized"
        case bookingDate, startTime, endTime, bookingReason, bookingFees, eCliniccommission, paymentType, currencyFk, bookingStatus, bookingSummery, showBookingSummeryTopatient, isOverBooking, isPaied, paiedDate
        case branchAddressLocalized = "branchAddress_Localized"
        case patientAddressLocalized = "patientAddress_Localized"
        case patientOrPharma
        case serviceTypeName = "serviceType_Name"
        case bookingStatusName, paymentTypeName, typeName, bookingAvilableButtons, readyToStartVideo, doctorInsuranceFk, bookingInsuranceFees, totalBookingFees
    }
}

// MARK: - BookingAvilableButtons
//struct BookingAvilableButtons: Codable {
//    let avilableButtonsForDoctor, avilableButtonsForPatient: AvilableButtons?
//}
//
//// MARK: - AvilableButtonsFor
//struct AvilableButtons: Codable {
//    let enterConfirmationCode, acceptOrConfirm: Bool?
//    let acceptOrConfirmLocalized: String?
//    let cancel: Bool?
//    let cancelLocalized: String?
//    let startVideo: Bool?
//    let startVideoLocalized: String?
//    let joinVideo: Bool?
//    let joinVideoLocalized: String?
//    let endVideo: Bool?
//    let endVideoLocalized: String?
//    let noshow: Bool?
//    let noshowLocalized: String?
//    let markAsPaied: Bool?
//    let markAsPaiedLocalized: String?
//    let addFeedBack, afterFinishedButtons, markAsArrive: Bool?
//    let markAsArriveLocalized: String?
//    let markAsReservedNow: Bool?
//    let markAsReservedNowLocalized: String?
//    let markAsptientOrRepIsOnline: Bool
//    let markAsptientOrRepIsOnlineLocalized: String?
//    let enterConfirmationCodeLocalized: String?
//
//    enum CodingKeys: String, CodingKey {
//        case enterConfirmationCode, acceptOrConfirm
//        case acceptOrConfirmLocalized = "acceptOrConfirm_Localized"
//        case cancel
//        case cancelLocalized = "cancel_Localized"
//        case startVideo
//        case startVideoLocalized = "startVideo_Localized"
//        case joinVideo
//        case joinVideoLocalized = "joinVideo_Localized"
//        case endVideo
//        case endVideoLocalized = "endVideo_Localized"
//        case noshow
//        case noshowLocalized = "noshow_Localized"
//        case markAsPaied
//        case markAsPaiedLocalized = "markAsPaied_Localized"
//        case addFeedBack, afterFinishedButtons, markAsArrive
//        case markAsArriveLocalized = "markAsArrive_Localized"
//        case markAsReservedNow
//        case markAsReservedNowLocalized = "markAsReservedNow_Localized"
//        case markAsptientOrRepIsOnline
//        case markAsptientOrRepIsOnlineLocalized = "markAsptientOrRepIsOnline_Localized"
//        case enterConfirmationCodeLocalized = "enterConfirmationCode_Localized"
//    }
//}
