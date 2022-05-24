//
//  DoctorReviewsModel.swift
//  E4 Patient
//
//  Created by Nada on 8/27/21.
//

import Foundation

struct DoctorReviewsModel: Codable {
    let successtate: Int?
    let errormessage: String?
    let message: DoctorReviewsData?
}
struct DoctorReviewsData: Codable {
    let businessProviderEmployeeID, businessProviderFk: Int?
    let doctorName, prefixTitleLocalized: String?
    let specialityID: Int?
    let specialityLocalized, profileImage: String?
    let totalRate ,totalDoctorRate, totalClinicRate, totalAssistantRate: Double?
    let totalpatients: Int?
    let patientReviewList: [PatientReviewList]?

    enum CodingKeys: String, CodingKey {
        case businessProviderEmployeeID = "businessProviderEmployeeId"
        case businessProviderFk, doctorName
        case prefixTitleLocalized = "prefixTitle_Localized"
        case specialityID = "specialityId"
        case specialityLocalized = "speciality_Localized"
        case profileImage, totalRate, totalDoctorRate, totalClinicRate, totalAssistantRate, totalpatients, patientReviewList
    }
}
struct PatientReviewList: Codable {
    let patientReviewID, bookingFk, patientFk, doctorFk: Int?
    let doctorRate, clinicRate, assistantRate: Int?
    let patientNote, doctorReply, createDate: String?
    let doctorReplyDate: String?
    let deleted: Bool?
    let patient: Patient?
    let isComplained: Bool?
    let totalRate: Double?

    enum CodingKeys: String, CodingKey {
        case patientReviewID = "patientReviewId"
        case bookingFk, patientFk, doctorFk, doctorRate, clinicRate, assistantRate, patientNote, doctorReply, createDate, doctorReplyDate, deleted, patient, isComplained, totalRate
    }
}
struct Patient: Codable {
    let firstName, lastName, mobile, email: String?
    let personalImage: String?
    let gender: Int?
    let birthDate, phoneCode: String?

    enum CodingKeys: String, CodingKey {
        case firstName, lastName, mobile, email
        case personalImage = "personal_image"
        case gender, birthDate, phoneCode
    }
}
