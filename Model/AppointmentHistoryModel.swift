//
//  homeModel.swift
//  E4 Patient
//
//  Created by mohab on 31/05/2021.
//

import Foundation
struct AppointmentHistoryModel: Codable {
    let successtate : Int?
    let errormessage : String?
    var message : [AppointmentMessage]?

    enum CodingKeys: String, CodingKey {

        case successtate = "successtate"
        case errormessage = "errormessage"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        successtate = try values.decodeIfPresent(Int.self, forKey: .successtate)
        errormessage = try values.decodeIfPresent(String.self, forKey: .errormessage)
        message = try values.decodeIfPresent([AppointmentMessage].self, forKey: .message)
    }

}

// MARK: - Message
struct AppointmentMessage: Codable {
    let bookingId : Int?
    let doctor_name : String?
    let profileImage : String?
    let prefixTitle_Localized : String?
    let fullProfisionalDetails_Localized : String?
    let profisionalDetails_Localized : String?
    let branchName_Localized : String?
    let branchLang : String?
    let branchLat : String?
    let patientName : String?
    let patientProfileImage : String?
    let patientEmail : String?
    let patientMobileCode : String?
    let patientMobile : String?
    let bookingNo : Int?
    let doctorFk : Int?
    let patientFk : Int?
    let patientBirthDate : String?
    let patientGender : Int?
    let serviceType : Int?
    let businessProviderBranchFk : Int?
    let patientAddressFk : Int?
    let medicalServiceFk : Int?
    let consultationServiceFk : Int?
    let consultationService_localized : String?
    let medicalService_localized : String?
    let bookingDate : String?
    let startTime : String?
    let endTime : String?
    let bookingReason : String?
    let bookingFees : Int?
    let paymentType : Int?
    let currencyFk : Int?
    let bookingStatus : Int?
    let confirmationToken : String?
    let createDate : String?
    let createdBy : String?
    let bookingSummery : String?
    let showBookingSummeryTopatient : Bool?
    let isOverBooking : Bool?
    let isPaied : Bool?
    let paiedDate : String?
    let branchAddress_Localized : String?
    let entityName_Localized : String?
    let imagepath : String?
    let isOnline : Bool?
    let serviceType_Name : String?
    let bookingStatusName : String?
    let paymentTypeName : String?
    let history : [AppointmentHistory]?
    let patientReview : [PatientReview1]?
    let patientWeight : Int?
    let patientHeight : Int?
    let doctorEmail : String?
    let videoWatingListId : Int?
    let meetingId : String?
    let meetingPassword : String?
    let startUrl : String?
    let videoStatus : Int?
    let allOverallVal : Int?
    let bookingAvilableButtons : AppointmentBookingAvilableButtons?
    let patientAddress : String?
    let specialityPath : String?
    let readyToStartVideo : Bool?

    enum CodingKeys: String, CodingKey {

        case bookingId = "bookingId"
        case doctor_name = "doctor_name"
        case profileImage = "profileImage"
        case prefixTitle_Localized = "prefixTitle_Localized"
        case fullProfisionalDetails_Localized = "fullProfisionalDetails_Localized"
        case profisionalDetails_Localized = "profisionalDetails_Localized"
        case branchName_Localized = "branchName_Localized"
        case branchLang = "branchLang"
        case branchLat = "branchLat"
        case patientName = "patientName"
        case patientProfileImage = "patientProfileImage"
        case patientEmail = "patientEmail"
        case patientMobileCode = "patientMobileCode"
        case patientMobile = "patientMobile"
        case bookingNo = "bookingNo"
        case doctorFk = "doctorFk"
        case patientFk = "patientFk"
        case patientBirthDate = "patientBirthDate"
        case patientGender = "patientGender"
        case serviceType = "serviceType"
        case businessProviderBranchFk = "businessProviderBranchFk"
        case patientAddressFk = "patientAddressFk"
        case medicalServiceFk = "medicalServiceFk"
        case consultationServiceFk = "consultationServiceFk"
        case consultationService_localized = "consultationService_localized"
        case medicalService_localized = "medicalService_localized"
        case bookingDate = "bookingDate"
        case startTime = "startTime"
        case endTime = "endTime"
        case bookingReason = "bookingReason"
        case bookingFees = "bookingFees"
        case paymentType = "paymentType"
        case currencyFk = "currencyFk"
        case bookingStatus = "bookingStatus"
        case confirmationToken = "confirmationToken"
        case createDate = "createDate"
        case createdBy = "createdBy"
        case bookingSummery = "bookingSummery"
        case showBookingSummeryTopatient = "showBookingSummeryTopatient"
        case isOverBooking = "isOverBooking"
        case isPaied = "isPaied"
        case paiedDate = "paiedDate"
        case branchAddress_Localized = "branchAddress_Localized"
        case entityName_Localized = "entityName_Localized"
        case imagepath = "imagepath"
        case isOnline = "isOnline"
        case serviceType_Name = "serviceType_Name"
        case bookingStatusName = "bookingStatusName"
        case paymentTypeName = "paymentTypeName"
        case history = "history"
        case patientReview = "patientReview"
        case patientWeight = "patientWeight"
        case patientHeight = "patientHeight"
        case doctorEmail = "doctorEmail"
        case videoWatingListId = "videoWatingListId"
        case meetingId = "meetingId"
        case meetingPassword = "meetingPassword"
        case startUrl = "startUrl"
        case videoStatus = "videoStatus"
        case allOverallVal = "allOverallVal"
        case bookingAvilableButtons = "bookingAvilableButtons"
        case patientAddress = "patientAddress"
        case specialityPath = "specialityPath"
        case readyToStartVideo = "readyToStartVideo"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        bookingId = try values.decodeIfPresent(Int.self, forKey: .bookingId)
        doctor_name = try values.decodeIfPresent(String.self, forKey: .doctor_name)
        profileImage = try values.decodeIfPresent(String.self, forKey: .profileImage)
        prefixTitle_Localized = try values.decodeIfPresent(String.self, forKey: .prefixTitle_Localized)
        fullProfisionalDetails_Localized = try values.decodeIfPresent(String.self, forKey: .fullProfisionalDetails_Localized)
        profisionalDetails_Localized = try values.decodeIfPresent(String.self, forKey: .profisionalDetails_Localized)
        branchName_Localized = try values.decodeIfPresent(String.self, forKey: .branchName_Localized)
        branchLang = try values.decodeIfPresent(String.self, forKey: .branchLang)
        branchLat = try values.decodeIfPresent(String.self, forKey: .branchLat)
        patientName = try values.decodeIfPresent(String.self, forKey: .patientName)
        patientProfileImage = try values.decodeIfPresent(String.self, forKey: .patientProfileImage)
        patientEmail = try values.decodeIfPresent(String.self, forKey: .patientEmail)
        patientMobileCode = try values.decodeIfPresent(String.self, forKey: .patientMobileCode)
        patientMobile = try values.decodeIfPresent(String.self, forKey: .patientMobile)
        bookingNo = try values.decodeIfPresent(Int.self, forKey: .bookingNo)
        doctorFk = try values.decodeIfPresent(Int.self, forKey: .doctorFk)
        patientFk = try values.decodeIfPresent(Int.self, forKey: .patientFk)
        patientBirthDate = try values.decodeIfPresent(String.self, forKey: .patientBirthDate)
        patientGender = try values.decodeIfPresent(Int.self, forKey: .patientGender)
        serviceType = try values.decodeIfPresent(Int.self, forKey: .serviceType)
        businessProviderBranchFk = try values.decodeIfPresent(Int.self, forKey: .businessProviderBranchFk)
        patientAddressFk = try values.decodeIfPresent(Int.self, forKey: .patientAddressFk)
        medicalServiceFk = try values.decodeIfPresent(Int.self, forKey: .medicalServiceFk)
        consultationServiceFk = try values.decodeIfPresent(Int.self, forKey: .consultationServiceFk)
        consultationService_localized = try values.decodeIfPresent(String.self, forKey: .consultationService_localized)
        medicalService_localized = try values.decodeIfPresent(String.self, forKey: .medicalService_localized)
        bookingDate = try values.decodeIfPresent(String.self, forKey: .bookingDate)
        startTime = try values.decodeIfPresent(String.self, forKey: .startTime)
        endTime = try values.decodeIfPresent(String.self, forKey: .endTime)
        bookingReason = try values.decodeIfPresent(String.self, forKey: .bookingReason)
        bookingFees = try values.decodeIfPresent(Int.self, forKey: .bookingFees)
        paymentType = try values.decodeIfPresent(Int.self, forKey: .paymentType)
        currencyFk = try values.decodeIfPresent(Int.self, forKey: .currencyFk)
        bookingStatus = try values.decodeIfPresent(Int.self, forKey: .bookingStatus)
        confirmationToken = try values.decodeIfPresent(String.self, forKey: .confirmationToken)
        createDate = try values.decodeIfPresent(String.self, forKey: .createDate)
        createdBy = try values.decodeIfPresent(String.self, forKey: .createdBy)
        bookingSummery = try values.decodeIfPresent(String.self, forKey: .bookingSummery)
        showBookingSummeryTopatient = try values.decodeIfPresent(Bool.self, forKey: .showBookingSummeryTopatient)
        isOverBooking = try values.decodeIfPresent(Bool.self, forKey: .isOverBooking)
        isPaied = try values.decodeIfPresent(Bool.self, forKey: .isPaied)
        paiedDate = try values.decodeIfPresent(String.self, forKey: .paiedDate)
        branchAddress_Localized = try values.decodeIfPresent(String.self, forKey: .branchAddress_Localized)
        entityName_Localized = try values.decodeIfPresent(String.self, forKey: .entityName_Localized)
        imagepath = try values.decodeIfPresent(String.self, forKey: .imagepath)
        isOnline = try values.decodeIfPresent(Bool.self, forKey: .isOnline)
        serviceType_Name = try values.decodeIfPresent(String.self, forKey: .serviceType_Name)
        bookingStatusName = try values.decodeIfPresent(String.self, forKey: .bookingStatusName)
        paymentTypeName = try values.decodeIfPresent(String.self, forKey: .paymentTypeName)
        history = try values.decodeIfPresent([AppointmentHistory].self, forKey: .history)
        patientReview = try values.decodeIfPresent([PatientReview1].self, forKey: .patientReview)
        patientWeight = try values.decodeIfPresent(Int.self, forKey: .patientWeight)
        patientHeight = try values.decodeIfPresent(Int.self, forKey: .patientHeight)
        doctorEmail = try values.decodeIfPresent(String.self, forKey: .doctorEmail)
        videoWatingListId = try values.decodeIfPresent(Int.self, forKey: .videoWatingListId)
        meetingId = try values.decodeIfPresent(String.self, forKey: .meetingId)
        meetingPassword = try values.decodeIfPresent(String.self, forKey: .meetingPassword)
        startUrl = try values.decodeIfPresent(String.self, forKey: .startUrl)
        videoStatus = try values.decodeIfPresent(Int.self, forKey: .videoStatus)
        allOverallVal = try values.decodeIfPresent(Int.self, forKey: .allOverallVal)
        bookingAvilableButtons = try values.decodeIfPresent(AppointmentBookingAvilableButtons.self, forKey: .bookingAvilableButtons)
        patientAddress = try values.decodeIfPresent(String.self, forKey: .patientAddress)
        specialityPath = try values.decodeIfPresent(String.self, forKey: .specialityPath)
        readyToStartVideo = try values.decodeIfPresent(Bool.self, forKey: .readyToStartVideo)
    }

}

struct AppointmentHistory : Codable {
    let bookingHistoryId : Int?
    let bookingFk : Int?
    let historyStatus : Int?
    let changeStatusTime : String?
    let changeStatusReason : String?
    let historyStatusName : String?

    enum CodingKeys: String, CodingKey {

        case bookingHistoryId = "bookingHistoryId"
        case bookingFk = "bookingFk"
        case historyStatus = "historyStatus"
        case changeStatusTime = "changeStatusTime"
        case changeStatusReason = "changeStatusReason"
        case historyStatusName = "historyStatusName"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        bookingHistoryId = try values.decodeIfPresent(Int.self, forKey: .bookingHistoryId)
        bookingFk = try values.decodeIfPresent(Int.self, forKey: .bookingFk)
        historyStatus = try values.decodeIfPresent(Int.self, forKey: .historyStatus)
        changeStatusTime = try values.decodeIfPresent(String.self, forKey: .changeStatusTime)
        changeStatusReason = try values.decodeIfPresent(String.self, forKey: .changeStatusReason)
        historyStatusName = try values.decodeIfPresent(String.self, forKey: .historyStatusName)
    }

}
struct AppointmentBookingAvilableButtons : Codable {
    let avilableButtonsForDoctor : AppointmentAvilableButtonsForDoctor?
    let avilableButtonsForPatient : AppointmentAvilableButtonsForPatient?

    enum CodingKeys: String, CodingKey {

        case avilableButtonsForDoctor = "avilableButtonsForDoctor"
        case avilableButtonsForPatient = "avilableButtonsForPatient"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        avilableButtonsForDoctor = try values.decodeIfPresent(AppointmentAvilableButtonsForDoctor.self, forKey: .avilableButtonsForDoctor)
        avilableButtonsForPatient = try values.decodeIfPresent(AppointmentAvilableButtonsForPatient.self, forKey: .avilableButtonsForPatient)
    }

}
struct AppointmentAvilableButtonsForPatient : Codable {
    let acceptOrConfirm : Bool?
    let acceptOrConfirm_Localized : String?
    let cancel : Bool?
    let cancel_Localized : String?
    let startVideo : Bool?
    let startVideo_Localized : String?
    let joinVideo : Bool?
    let joinVideo_Localized : String?
    let endVideo : Bool?
    let endVideo_Localized : String?
    let noshow : Bool?
    let noshow_Localized : String?
    let markAsPaied : Bool?
    let markAsPaied_Localized : String?
    let addFeedBack : Bool?
    let afterFinishedButtons : Bool?
    let markAsArrive : Bool?
    let markAsArrive_Localized : String?
    let markAsReservedNow : Bool?
    let markAsReservedNow_Localized : String?
    let markAsptientOrRepIsOnline : Bool?
    let markAsptientOrRepIsOnline_Localized : String?

    enum CodingKeys: String, CodingKey {

        case acceptOrConfirm = "acceptOrConfirm"
        case acceptOrConfirm_Localized = "acceptOrConfirm_Localized"
        case cancel = "cancel"
        case cancel_Localized = "cancel_Localized"
        case startVideo = "startVideo"
        case startVideo_Localized = "startVideo_Localized"
        case joinVideo = "joinVideo"
        case joinVideo_Localized = "joinVideo_Localized"
        case endVideo = "endVideo"
        case endVideo_Localized = "endVideo_Localized"
        case noshow = "noshow"
        case noshow_Localized = "noshow_Localized"
        case markAsPaied = "markAsPaied"
        case markAsPaied_Localized = "markAsPaied_Localized"
        case addFeedBack = "addFeedBack"
        case afterFinishedButtons = "afterFinishedButtons"
        case markAsArrive = "markAsArrive"
        case markAsArrive_Localized = "markAsArrive_Localized"
        case markAsReservedNow = "markAsReservedNow"
        case markAsReservedNow_Localized = "markAsReservedNow_Localized"
        case markAsptientOrRepIsOnline = "markAsptientOrRepIsOnline"
        case markAsptientOrRepIsOnline_Localized = "markAsptientOrRepIsOnline_Localized"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        acceptOrConfirm = try values.decodeIfPresent(Bool.self, forKey: .acceptOrConfirm)
        acceptOrConfirm_Localized = try values.decodeIfPresent(String.self, forKey: .acceptOrConfirm_Localized)
        cancel = try values.decodeIfPresent(Bool.self, forKey: .cancel)
        cancel_Localized = try values.decodeIfPresent(String.self, forKey: .cancel_Localized)
        startVideo = try values.decodeIfPresent(Bool.self, forKey: .startVideo)
        startVideo_Localized = try values.decodeIfPresent(String.self, forKey: .startVideo_Localized)
        joinVideo = try values.decodeIfPresent(Bool.self, forKey: .joinVideo)
        joinVideo_Localized = try values.decodeIfPresent(String.self, forKey: .joinVideo_Localized)
        endVideo = try values.decodeIfPresent(Bool.self, forKey: .endVideo)
        endVideo_Localized = try values.decodeIfPresent(String.self, forKey: .endVideo_Localized)
        noshow = try values.decodeIfPresent(Bool.self, forKey: .noshow)
        noshow_Localized = try values.decodeIfPresent(String.self, forKey: .noshow_Localized)
        markAsPaied = try values.decodeIfPresent(Bool.self, forKey: .markAsPaied)
        markAsPaied_Localized = try values.decodeIfPresent(String.self, forKey: .markAsPaied_Localized)
        addFeedBack = try values.decodeIfPresent(Bool.self, forKey: .addFeedBack)
        afterFinishedButtons = try values.decodeIfPresent(Bool.self, forKey: .afterFinishedButtons)
        markAsArrive = try values.decodeIfPresent(Bool.self, forKey: .markAsArrive)
        markAsArrive_Localized = try values.decodeIfPresent(String.self, forKey: .markAsArrive_Localized)
        markAsReservedNow = try values.decodeIfPresent(Bool.self, forKey: .markAsReservedNow)
        markAsReservedNow_Localized = try values.decodeIfPresent(String.self, forKey: .markAsReservedNow_Localized)
        markAsptientOrRepIsOnline = try values.decodeIfPresent(Bool.self, forKey: .markAsptientOrRepIsOnline)
        markAsptientOrRepIsOnline_Localized = try values.decodeIfPresent(String.self, forKey: .markAsptientOrRepIsOnline_Localized)
    }

}
struct AppointmentAvilableButtonsForDoctor : Codable {
    let acceptOrConfirm : Bool?
    let acceptOrConfirm_Localized : String?
    let cancel : Bool?
    let cancel_Localized : String?
    let startVideo : Bool?
    let startVideo_Localized : String?
    let joinVideo : Bool?
    let joinVideo_Localized : String?
    let endVideo : Bool?
    let endVideo_Localized : String?
    let noshow : Bool?
    let noshow_Localized : String?
    let markAsPaied : Bool?
    let markAsPaied_Localized : String?
    let addFeedBack : Bool?
    let afterFinishedButtons : Bool?
    let markAsArrive : Bool?
    let markAsArrive_Localized : String?
    let markAsReservedNow : Bool?
    let markAsReservedNow_Localized : String?
    let markAsptientOrRepIsOnline : Bool?
    let markAsptientOrRepIsOnline_Localized : String?

    enum CodingKeys: String, CodingKey {

        case acceptOrConfirm = "acceptOrConfirm"
        case acceptOrConfirm_Localized = "acceptOrConfirm_Localized"
        case cancel = "cancel"
        case cancel_Localized = "cancel_Localized"
        case startVideo = "startVideo"
        case startVideo_Localized = "startVideo_Localized"
        case joinVideo = "joinVideo"
        case joinVideo_Localized = "joinVideo_Localized"
        case endVideo = "endVideo"
        case endVideo_Localized = "endVideo_Localized"
        case noshow = "noshow"
        case noshow_Localized = "noshow_Localized"
        case markAsPaied = "markAsPaied"
        case markAsPaied_Localized = "markAsPaied_Localized"
        case addFeedBack = "addFeedBack"
        case afterFinishedButtons = "afterFinishedButtons"
        case markAsArrive = "markAsArrive"
        case markAsArrive_Localized = "markAsArrive_Localized"
        case markAsReservedNow = "markAsReservedNow"
        case markAsReservedNow_Localized = "markAsReservedNow_Localized"
        case markAsptientOrRepIsOnline = "markAsptientOrRepIsOnline"
        case markAsptientOrRepIsOnline_Localized = "markAsptientOrRepIsOnline_Localized"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        acceptOrConfirm = try values.decodeIfPresent(Bool.self, forKey: .acceptOrConfirm)
        acceptOrConfirm_Localized = try values.decodeIfPresent(String.self, forKey: .acceptOrConfirm_Localized)
        cancel = try values.decodeIfPresent(Bool.self, forKey: .cancel)
        cancel_Localized = try values.decodeIfPresent(String.self, forKey: .cancel_Localized)
        startVideo = try values.decodeIfPresent(Bool.self, forKey: .startVideo)
        startVideo_Localized = try values.decodeIfPresent(String.self, forKey: .startVideo_Localized)
        joinVideo = try values.decodeIfPresent(Bool.self, forKey: .joinVideo)
        joinVideo_Localized = try values.decodeIfPresent(String.self, forKey: .joinVideo_Localized)
        endVideo = try values.decodeIfPresent(Bool.self, forKey: .endVideo)
        endVideo_Localized = try values.decodeIfPresent(String.self, forKey: .endVideo_Localized)
        noshow = try values.decodeIfPresent(Bool.self, forKey: .noshow)
        noshow_Localized = try values.decodeIfPresent(String.self, forKey: .noshow_Localized)
        markAsPaied = try values.decodeIfPresent(Bool.self, forKey: .markAsPaied)
        markAsPaied_Localized = try values.decodeIfPresent(String.self, forKey: .markAsPaied_Localized)
        addFeedBack = try values.decodeIfPresent(Bool.self, forKey: .addFeedBack)
        afterFinishedButtons = try values.decodeIfPresent(Bool.self, forKey: .afterFinishedButtons)
        markAsArrive = try values.decodeIfPresent(Bool.self, forKey: .markAsArrive)
        markAsArrive_Localized = try values.decodeIfPresent(String.self, forKey: .markAsArrive_Localized)
        markAsReservedNow = try values.decodeIfPresent(Bool.self, forKey: .markAsReservedNow)
        markAsReservedNow_Localized = try values.decodeIfPresent(String.self, forKey: .markAsReservedNow_Localized)
        markAsptientOrRepIsOnline = try values.decodeIfPresent(Bool.self, forKey: .markAsptientOrRepIsOnline)
        markAsptientOrRepIsOnline_Localized = try values.decodeIfPresent(String.self, forKey: .markAsptientOrRepIsOnline_Localized)
    }

}
struct PatientReview1 : Codable {
    let doctorReplyDate : String?
    let patientReviewId : Int?
    let bookingFk : Int?
    let patientFk : Int?
    let doctorFk : Int?
    let doctor_name : String?
    let profileImage : String?
    let patientName : String?
    let patientProfileImage : String?
    let doctorRate : Int?
    let clinicRate : Int?
    let assistantRate : Int?
    let patientNote : String?
    let doctorReply : String?
    let createDate : String?
    let deleted : Bool?
    let patientReviewComplaint : [PatientReviewComplaint]?
    let totalRate : Double?

    enum CodingKeys: String, CodingKey {

        case doctorReplyDate = "doctorReplyDate"
        case patientReviewId = "patientReviewId"
        case bookingFk = "bookingFk"
        case patientFk = "patientFk"
        case doctorFk = "doctorFk"
        case doctor_name = "doctor_name"
        case profileImage = "profileImage"
        case patientName = "patientName"
        case patientProfileImage = "patientProfileImage"
        case doctorRate = "doctorRate"
        case clinicRate = "clinicRate"
        case assistantRate = "assistantRate"
        case patientNote = "patientNote"
        case doctorReply = "doctorReply"
        case createDate = "createDate"
        case deleted = "deleted"
        case patientReviewComplaint = "patientReviewComplaint"
        case totalRate = "totalRate"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        doctorReplyDate = try values.decodeIfPresent(String.self, forKey: .doctorReplyDate)
        patientReviewId = try values.decodeIfPresent(Int.self, forKey: .patientReviewId)
        bookingFk = try values.decodeIfPresent(Int.self, forKey: .bookingFk)
        patientFk = try values.decodeIfPresent(Int.self, forKey: .patientFk)
        doctorFk = try values.decodeIfPresent(Int.self, forKey: .doctorFk)
        doctor_name = try values.decodeIfPresent(String.self, forKey: .doctor_name)
        profileImage = try values.decodeIfPresent(String.self, forKey: .profileImage)
        patientName = try values.decodeIfPresent(String.self, forKey: .patientName)
        patientProfileImage = try values.decodeIfPresent(String.self, forKey: .patientProfileImage)
        doctorRate = try values.decodeIfPresent(Int.self, forKey: .doctorRate)
        clinicRate = try values.decodeIfPresent(Int.self, forKey: .clinicRate)
        assistantRate = try values.decodeIfPresent(Int.self, forKey: .assistantRate)
        patientNote = try values.decodeIfPresent(String.self, forKey: .patientNote)
        doctorReply = try values.decodeIfPresent(String.self, forKey: .doctorReply)
        createDate = try values.decodeIfPresent(String.self, forKey: .createDate)
        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        patientReviewComplaint = try values.decodeIfPresent([PatientReviewComplaint].self, forKey: .patientReviewComplaint)
        totalRate = try values.decodeIfPresent(Double.self, forKey: .totalRate)
    }

}
struct PatientReviewComplaint : Codable {
    let patientReviewComplaintId : Int?
    let patientReviewFk : Int?
    let complaintText : String?

    enum CodingKeys: String, CodingKey {

        case patientReviewComplaintId = "patientReviewComplaintId"
        case patientReviewFk = "patientReviewFk"
        case complaintText = "complaintText"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        patientReviewComplaintId = try values.decodeIfPresent(Int.self, forKey: .patientReviewComplaintId)
        patientReviewFk = try values.decodeIfPresent(Int.self, forKey: .patientReviewFk)
        complaintText = try values.decodeIfPresent(String.self, forKey: .complaintText)
    }

}
