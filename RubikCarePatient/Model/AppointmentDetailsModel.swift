//
//  homeModel.swift
//  E4 Patient
//
//  Created by mohab on 31/05/2021.
//

import Foundation
struct AppointmentDetailsBase: Codable {
    let successtate: Int?
    let errormessage: String?
    let message: AppointmentDetailsMessage?
}

// MARK: - Message
struct AppointmentDetailsMessage: Codable {
    let id, type: Int?
    let doctorName, doctorProfileImage, doctorBranchNameLocalized, entityNameLocalized: String?
    let imagepath, name, profileImage, email: String?
    let mobileCode, mobile: String?
    let patientGender: Int?
    let patientWeight, patientHeight: Int?
    let patientBirthDate: String?
    let blodGroupFk: Int?
    let blodGroupnameLocalized: String?
    let bookingNo, doctorFk, patientOrRepFk, serviceType: Int?
    let businessProviderBranchFk: Int?
    let patientAddressFk, medicalServiceFk: Int?
    let consultationServiceFk: Int?
    let consultationServiceLocalized, medicalServiceLocalized, bookingDate, startTime: String?
    let endTime, bookingReason: String?
    let bookingFees, paymentType, currencyFk, bookingStatus: Int?
    let confirmationToken: String?
    let bookingSummery: String?
    let showBookingSummeryTopatient, isOverBooking, isPaied: Bool?
    let paiedDate: String?
    let tblPatientReview: AppointmentDetailsTblPatientReview?
    let branchAddressLocalized, patientAddressLocalized: String?
    let videoWatingListID, meetingID, meetingPassword, startURL: String?
    let videoStatus, doctorRate, clinicRate, assistantRate: Int?
    let totalRate: Int?
    let serviceTypeName, bookingStatusName, paymentTypeName, typeName: String?
    let allowArrive, allowlogintodoctor: Bool?
    let history: [AppointmentDetailsHistory]?
    let bookingAvilableButtons: AppointmentDetailsBookingAvilableButtons?
    let readyToStartVideo, branchIDS: String?
    let paiedValue: Int

    enum CodingKeys: String, CodingKey {
        case id, type
        case doctorName = "doctor_name"
        case doctorProfileImage = "doctor_ProfileImage"
        case doctorBranchNameLocalized = "doctor_BranchName_Localized"
        case entityNameLocalized = "entityName_Localized"
        case imagepath, name, profileImage, email, mobileCode, mobile, patientGender, patientWeight, patientHeight, patientBirthDate, blodGroupFk
        case blodGroupnameLocalized = "blodGroupname_Localized"
        case bookingNo, doctorFk, patientOrRepFk, serviceType, businessProviderBranchFk, patientAddressFk, medicalServiceFk, consultationServiceFk
        case consultationServiceLocalized = "consultationService_localized"
        case medicalServiceLocalized = "medicalService_localized"
        case bookingDate, startTime, endTime, bookingReason, bookingFees, paymentType, currencyFk, bookingStatus, confirmationToken, bookingSummery, showBookingSummeryTopatient, isOverBooking, isPaied, paiedDate, tblPatientReview
        case branchAddressLocalized = "branchAddress_Localized"
        case patientAddressLocalized = "patientAddress_Localized"
        case videoWatingListID = "videoWatingListId"
        case meetingID = "meetingId"
        case meetingPassword
        case startURL = "startUrl"
        case videoStatus, doctorRate, clinicRate, assistantRate, totalRate
        case serviceTypeName = "serviceType_Name"
        case bookingStatusName, paymentTypeName, typeName, allowArrive, allowlogintodoctor, history, bookingAvilableButtons, readyToStartVideo
        case branchIDS = "branchIds"
        case paiedValue
    }
}

// MARK: - BookingAvilableButtons
struct AppointmentDetailsBookingAvilableButtons: Codable {
    let avilableButtonsForDoctor, avilableButtonsForPatient: AvilableButtonsFor?
}

// MARK: - AvilableButtonsFor
struct AvilableButtonsFor: Codable {
    let enterConfirmationCode, acceptOrConfirm: Bool?
    let acceptOrConfirmLocalized: String?
    let cancel: Bool?
    let cancelLocalized: String?
    let startVideo: Bool?
    let startVideoLocalized: String?
    let joinVideo: Bool?
    let joinVideoLocalized: String?
    let endVideo: Bool?
    let endVideoLocalized: String?
    let noshow: Bool?
    let noshowLocalized: String?
    let markAsPaied: Bool?
    let markAsPaiedLocalized: String?
    let addFeedBack, afterFinishedButtons, markAsArrive: Bool?
    let markAsArriveLocalized: String?
    let markAsReservedNow: Bool?
    let markAsReservedNowLocalized: String?
    let markAsptientOrRepIsOnline: Bool?
    let markAsptientOrRepIsOnlineLocalized, enterConfirmationCodeLocalized: String?

    enum CodingKeys: String, CodingKey {
        case enterConfirmationCode, acceptOrConfirm
        case acceptOrConfirmLocalized = "acceptOrConfirm_Localized"
        case cancel
        case cancelLocalized = "cancel_Localized"
        case startVideo
        case startVideoLocalized = "startVideo_Localized"
        case joinVideo
        case joinVideoLocalized = "joinVideo_Localized"
        case endVideo
        case endVideoLocalized = "endVideo_Localized"
        case noshow
        case noshowLocalized = "noshow_Localized"
        case markAsPaied
        case markAsPaiedLocalized = "markAsPaied_Localized"
        case addFeedBack, afterFinishedButtons, markAsArrive
        case markAsArriveLocalized = "markAsArrive_Localized"
        case markAsReservedNow
        case markAsReservedNowLocalized = "markAsReservedNow_Localized"
        case markAsptientOrRepIsOnline
        case markAsptientOrRepIsOnlineLocalized = "markAsptientOrRepIsOnline_Localized"
        case enterConfirmationCodeLocalized = "enterConfirmationCode_Localized"
    }
}

// MARK: - History
struct AppointmentDetailsHistory: Codable {
    let bookingHistoryID, bookingFk, historyStatus, type: Int?
    let changeStatusTime, changeStatusReason, historyStatusName: String?

    enum CodingKeys: String, CodingKey {
        case bookingHistoryID = "bookingHistoryId"
        case bookingFk, historyStatus, type, changeStatusTime, changeStatusReason, historyStatusName
    }
}

// MARK: - TblPatientReview
struct AppointmentDetailsTblPatientReview: Codable {
    let doctorReplyDate: String?
    let patientReviewID, bookingFk, patientFk, doctorFk: Int?
    let doctorName, profileImage, patientName, patientProfileImage: String?
    let doctorRate, clinicRate, assistantRate: Int?
    let patientNote, doctorReply, createDate: String?
    let deleted: Bool?
    let patientReviewComplaint: [String]?
    let totalRate: Int?

    enum CodingKeys: String, CodingKey {
        case doctorReplyDate
        case patientReviewID = "patientReviewId"
        case bookingFk, patientFk, doctorFk
        case doctorName = "doctor_name"
        case profileImage, patientName, patientProfileImage, doctorRate, clinicRate, assistantRate, patientNote, doctorReply, createDate, deleted, patientReviewComplaint, totalRate
    }
}



