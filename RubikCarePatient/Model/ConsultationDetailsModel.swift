//
//  ConsultationDetailsModel.swift
//  E4 Patient
//
//  Created by Nada on 9/5/21.
//

import Foundation

struct ConsultationDetailsModel : Codable {
    let successtate : Int?
    let errormessage : String?
    let message : ConsultationDetailsData?

    enum CodingKeys: String, CodingKey {

        case successtate = "successtate"
        case errormessage = "errormessage"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        successtate = try values.decodeIfPresent(Int.self, forKey: .successtate)
        errormessage = try values.decodeIfPresent(String.self, forKey: .errormessage)
        message = try values.decodeIfPresent(ConsultationDetailsData.self, forKey: .message)
    }

}
struct ConsultationDetailsData : Codable {
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
    let patientGender : Int?
    let patientWeight : String?
    let patientHeight : String?
    let patientBirthDate : String?
    let blodGroupFk : Int?
    let blodGroupname_Localized : String?
    let serviceType : Int?
    let businessProviderBranchFk : Int?
    let patientAddressFk : Int?
    let medicalServiceFk : String?
    let consultationServiceFk : Int?
    let bookingDate : String?
    let startTime : String?
    let endTime : String?
    let bookingReason : String?
    let bookingFees : Double?
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
    let consultationService_localized : String?
    let medicalService_localized : String?
    let serviceType_Name : String?
    let bookingStatusName : String?
    let paymentTypeName : String?
    let history : [History]?
    let patientReview : [PatientReview]?
    let bookingSummaryFiles : [BookingSummaryFiles]?
    let prescription : [Prescription]?
    let bookingAvilableButtons : BookingAvilableButtons?
    let readyToStartVideo : String?

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
        case patientGender = "patientGender"
        case patientWeight = "patientWeight"
        case patientHeight = "patientHeight"
        case patientBirthDate = "patientBirthDate"
        case blodGroupFk = "blodGroupFk"
        case blodGroupname_Localized = "blodGroupname_Localized"
        case serviceType = "serviceType"
        case businessProviderBranchFk = "businessProviderBranchFk"
        case patientAddressFk = "patientAddressFk"
        case medicalServiceFk = "medicalServiceFk"
        case consultationServiceFk = "consultationServiceFk"
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
        case consultationService_localized = "consultationService_localized"
        case medicalService_localized = "medicalService_localized"
        case serviceType_Name = "serviceType_Name"
        case bookingStatusName = "bookingStatusName"
        case paymentTypeName = "paymentTypeName"
        case history = "history"
        case patientReview = "patientReview"
        case bookingSummaryFiles = "bookingSummaryFiles"
        case prescription = "prescription"
        case bookingAvilableButtons = "bookingAvilableButtons"
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
        patientGender = try values.decodeIfPresent(Int.self, forKey: .patientGender)
        patientWeight = try values.decodeIfPresent(String.self, forKey: .patientWeight)
        patientHeight = try values.decodeIfPresent(String.self, forKey: .patientHeight)
        patientBirthDate = try values.decodeIfPresent(String.self, forKey: .patientBirthDate)
        blodGroupFk = try values.decodeIfPresent(Int.self, forKey: .blodGroupFk)
        blodGroupname_Localized = try values.decodeIfPresent(String.self, forKey: .blodGroupname_Localized)
        serviceType = try values.decodeIfPresent(Int.self, forKey: .serviceType)
        businessProviderBranchFk = try values.decodeIfPresent(Int.self, forKey: .businessProviderBranchFk)
        patientAddressFk = try values.decodeIfPresent(Int.self, forKey: .patientAddressFk)
        medicalServiceFk = try values.decodeIfPresent(String.self, forKey: .medicalServiceFk)
        consultationServiceFk = try values.decodeIfPresent(Int.self, forKey: .consultationServiceFk)
        bookingDate = try values.decodeIfPresent(String.self, forKey: .bookingDate)
        startTime = try values.decodeIfPresent(String.self, forKey: .startTime)
        endTime = try values.decodeIfPresent(String.self, forKey: .endTime)
        bookingReason = try values.decodeIfPresent(String.self, forKey: .bookingReason)
        bookingFees = try values.decodeIfPresent(Double.self, forKey: .bookingFees)
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
        consultationService_localized = try values.decodeIfPresent(String.self, forKey: .consultationService_localized)
        medicalService_localized = try values.decodeIfPresent(String.self, forKey: .medicalService_localized)
        serviceType_Name = try values.decodeIfPresent(String.self, forKey: .serviceType_Name)
        bookingStatusName = try values.decodeIfPresent(String.self, forKey: .bookingStatusName)
        paymentTypeName = try values.decodeIfPresent(String.self, forKey: .paymentTypeName)
        history = try values.decodeIfPresent([History].self, forKey: .history)
        patientReview = try values.decodeIfPresent([PatientReview].self, forKey: .patientReview)
        bookingSummaryFiles = try values.decodeIfPresent([BookingSummaryFiles].self, forKey: .bookingSummaryFiles)
        prescription = try values.decodeIfPresent([Prescription].self, forKey: .prescription)
        bookingAvilableButtons = try values.decodeIfPresent(BookingAvilableButtons.self, forKey: .bookingAvilableButtons)
        readyToStartVideo = try values.decodeIfPresent(String.self, forKey: .readyToStartVideo)
    }

}
struct BookingSummaryFiles : Codable {
    let bookingSummaryFilesId : Int?
    let createDate : String?
    let bookingFk : Int?
    let bookingSummaryFilesPath : String?

    enum CodingKeys: String, CodingKey {

        case bookingSummaryFilesId = "bookingSummaryFilesId"
        case createDate = "createDate"
        case bookingFk = "bookingFk"
        case bookingSummaryFilesPath = "bookingSummaryFilesPath"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        bookingSummaryFilesId = try values.decodeIfPresent(Int.self, forKey: .bookingSummaryFilesId)
        createDate = try values.decodeIfPresent(String.self, forKey: .createDate)
        bookingFk = try values.decodeIfPresent(Int.self, forKey: .bookingFk)
        bookingSummaryFilesPath = try values.decodeIfPresent(String.self, forKey: .bookingSummaryFilesPath)
    }

}
struct Prescription : Codable {
    let preescriptionId : Int?
    let preescriptionDate : String?
    let bookingFk : Int?
    let doctorID : String?
    let preescriptionNote : String?
    let doctorReport : String?
    let lookupDiseaseFk : String?
    let doctorName : String?
    let tblPatientMedicine : [TblPatientMedicinee]?
    let bookingSummaryFiles : String?

    enum CodingKeys: String, CodingKey {

        case preescriptionId = "preescriptionId"
        case preescriptionDate = "preescriptionDate"
        case bookingFk = "bookingFk"
        case doctorID = "doctorID"
        case preescriptionNote = "preescriptionNote"
        case doctorReport = "doctorReport"
        case lookupDiseaseFk = "lookupDiseaseFk"
        case doctorName = "doctorName"
        case tblPatientMedicine = "tblPatientMedicine"
        case bookingSummaryFiles = "bookingSummaryFiles"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        preescriptionId = try values.decodeIfPresent(Int.self, forKey: .preescriptionId)
        preescriptionDate = try values.decodeIfPresent(String.self, forKey: .preescriptionDate)
        bookingFk = try values.decodeIfPresent(Int.self, forKey: .bookingFk)
        doctorID = try values.decodeIfPresent(String.self, forKey: .doctorID)
        preescriptionNote = try values.decodeIfPresent(String.self, forKey: .preescriptionNote)
        doctorReport = try values.decodeIfPresent(String.self, forKey: .doctorReport)
        lookupDiseaseFk = try values.decodeIfPresent(String.self, forKey: .lookupDiseaseFk)
        doctorName = try values.decodeIfPresent(String.self, forKey: .doctorName)
        tblPatientMedicine = try values.decodeIfPresent([TblPatientMedicinee].self, forKey: .tblPatientMedicine)
        bookingSummaryFiles = try values.decodeIfPresent(String.self, forKey: .bookingSummaryFiles)
    }

}
struct TblPatientMedicinee : Codable {
    let patientMedicineId : Int?
    let patientFk : Int?
    let medicationFk : Int?
    let diseaseStatusFk : String?
    let dateFrom : String?
    let dateTo : String?
    let notes : String?
    let businessProviderEmployeeFk : Int?
    let createDate : String?
    let isActive : Bool?
    let deleted : Bool?
    let doctorName : String?
    let quantity : Int?
    let whenTake : String?
    let frequencyOfRepetition : String?
    let frequencyValue : String?
    let schedualType : String?
    let schedualDays : String?
    let prescriptionFk : Int?
    let showInList : Bool?
    let whenMedicationTakenFk : Int?
    let whenMedicationTakenName_Localized : String?
    let durationType : Int?
    let durationTypetName_Localized : String?
    let durationValue : Int?
    let inFrequencyLst : Bool?
    let medicationName : String?
    let medicineForm : String?
    let medicineStrenght : String?
    let medicineImagePath : String?
    let medicinAbout_Localized : String?
    let createdByDoctorFk : String?

    enum CodingKeys: String, CodingKey {

        case patientMedicineId = "patientMedicineId"
        case patientFk = "patientFk"
        case medicationFk = "medicationFk"
        case diseaseStatusFk = "diseaseStatusFk"
        case dateFrom = "dateFrom"
        case dateTo = "dateTo"
        case notes = "notes"
        case businessProviderEmployeeFk = "businessProviderEmployeeFk"
        case createDate = "createDate"
        case isActive = "isActive"
        case deleted = "deleted"
        case doctorName = "doctorName"
        case quantity = "quantity"
        case whenTake = "whenTake"
        case frequencyOfRepetition = "frequencyOfRepetition"
        case frequencyValue = "frequencyValue"
        case schedualType = "schedualType"
        case schedualDays = "schedualDays"
        case prescriptionFk = "prescriptionFk"
        case showInList = "showInList"
        case whenMedicationTakenFk = "whenMedicationTakenFk"
        case whenMedicationTakenName_Localized = "whenMedicationTakenName_Localized"
        case durationType = "durationType"
        case durationTypetName_Localized = "durationTypetName_Localized"
        case durationValue = "durationValue"
        case inFrequencyLst = "inFrequencyLst"
        case medicationName = "medicationName"
        case medicineForm = "medicineForm"
        case medicineStrenght = "medicineStrenght"
        case medicineImagePath = "medicineImagePath"
        case medicinAbout_Localized = "medicinAbout_Localized"
        case createdByDoctorFk = "createdByDoctorFk"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        patientMedicineId = try values.decodeIfPresent(Int.self, forKey: .patientMedicineId)
        patientFk = try values.decodeIfPresent(Int.self, forKey: .patientFk)
        medicationFk = try values.decodeIfPresent(Int.self, forKey: .medicationFk)
        diseaseStatusFk = try values.decodeIfPresent(String.self, forKey: .diseaseStatusFk)
        dateFrom = try values.decodeIfPresent(String.self, forKey: .dateFrom)
        dateTo = try values.decodeIfPresent(String.self, forKey: .dateTo)
        notes = try values.decodeIfPresent(String.self, forKey: .notes)
        businessProviderEmployeeFk = try values.decodeIfPresent(Int.self, forKey: .businessProviderEmployeeFk)
        createDate = try values.decodeIfPresent(String.self, forKey: .createDate)
        isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        doctorName = try values.decodeIfPresent(String.self, forKey: .doctorName)
        quantity = try values.decodeIfPresent(Int.self, forKey: .quantity)
        whenTake = try values.decodeIfPresent(String.self, forKey: .whenTake)
        frequencyOfRepetition = try values.decodeIfPresent(String.self, forKey: .frequencyOfRepetition)
        frequencyValue = try values.decodeIfPresent(String.self, forKey: .frequencyValue)
        schedualType = try values.decodeIfPresent(String.self, forKey: .schedualType)
        schedualDays = try values.decodeIfPresent(String.self, forKey: .schedualDays)
        prescriptionFk = try values.decodeIfPresent(Int.self, forKey: .prescriptionFk)
        showInList = try values.decodeIfPresent(Bool.self, forKey: .showInList)
        whenMedicationTakenFk = try values.decodeIfPresent(Int.self, forKey: .whenMedicationTakenFk)
        whenMedicationTakenName_Localized = try values.decodeIfPresent(String.self, forKey: .whenMedicationTakenName_Localized)
        durationType = try values.decodeIfPresent(Int.self, forKey: .durationType)
        durationTypetName_Localized = try values.decodeIfPresent(String.self, forKey: .durationTypetName_Localized)
        durationValue = try values.decodeIfPresent(Int.self, forKey: .durationValue)
        inFrequencyLst = try values.decodeIfPresent(Bool.self, forKey: .inFrequencyLst)
        medicationName = try values.decodeIfPresent(String.self, forKey: .medicationName)
        medicineForm = try values.decodeIfPresent(String.self, forKey: .medicineForm)
        medicineStrenght = try values.decodeIfPresent(String.self, forKey: .medicineStrenght)
        medicineImagePath = try values.decodeIfPresent(String.self, forKey: .medicineImagePath)
        medicinAbout_Localized = try values.decodeIfPresent(String.self, forKey: .medicinAbout_Localized)
        createdByDoctorFk = try values.decodeIfPresent(String.self, forKey: .createdByDoctorFk)
    }

}
