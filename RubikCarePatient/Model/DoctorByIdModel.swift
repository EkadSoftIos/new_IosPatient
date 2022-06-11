//
//  DoctorByIdModel.swift
//  E4 Patient
//
//  Created by Nada on 8/20/21.
//

import Foundation

struct DoctorByIdModel : Codable {
    let successtate : Int?
    let errormessage : String?
    let message : DoctorByIdData?

    enum CodingKeys: String, CodingKey {

        case successtate = "successtate"
        case errormessage = "errormessage"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        successtate = try values.decodeIfPresent(Int.self, forKey: .successtate)
        errormessage = try values.decodeIfPresent(String.self, forKey: .errormessage)
        message = try values.decodeIfPresent(DoctorByIdData.self, forKey: .message)
    }

}
struct DoctorByIdData : Codable {
    let subSpecialityName : String?
    let businessProviderEmployeeId : Int?
    let businessProviderFk : Int?
    let loginUserId : String?
    let doctorName : String?
    let employeeMobileNum : String?
    let employeeEmail : String?
    let employeeGender : Int?
    let employeeTypeFk : Int?
    let mainSpecialityFk : Int?
    let speciality_Localized : String?
    let subSpecialityIds : String?
    let prefixTitleFk : Int?
    let prefixTitle_Localized : String?
    let profisionalDetailsFk : Int?
    let isOnline : Bool?
    let isFavourite : Bool?
    let fullProfisionalDetails_Localized : String?
    let profisionalDetails_Localized : String?
    let employeeAbout_Localized : String?
    let createDate : String?
    let isActive : Bool?
    let deleted : Bool?
    let countryid : Int?
    let dateofbirth : String?
    let profileImage : String?
    let sponsered : Bool?
    let employeeFile : String?
    let businessProviderFkNavigation : BusinessProviderFkNavigation?
    let tblEmployeeAcademicQualification : [TblEmployeeAcademicQualification]?
    let tblDoctorsViews : [TblDoctorsViews]?
    let tblPatientReview : [TblPatientReview]?
    let serviceList : [ServiceList]?
    let consultaionServiceLst : String?
    let doctorCanDo : [Int]?
    let rate : String?
    let rate_stars : String?
    let viewersnumber : String?
    let totalpatient : String?
    let totalappointment : String?
    let totalpatientRateCount : String?
    let employeeMedicalService : String?

    enum CodingKeys: String, CodingKey {

        case subSpecialityName = "subSpecialityName"
        case businessProviderEmployeeId = "businessProviderEmployeeId"
        case businessProviderFk = "businessProviderFk"
        case loginUserId = "loginUserId"
        case doctorName = "doctorName"
        case employeeMobileNum = "employeeMobileNum"
        case employeeEmail = "employeeEmail"
        case employeeGender = "employeeGender"
        case employeeTypeFk = "employeeTypeFk"
        case mainSpecialityFk = "mainSpecialityFk"
        case speciality_Localized = "speciality_Localized"
        case subSpecialityIds = "subSpecialityIds"
        case prefixTitleFk = "prefixTitleFk"
        case prefixTitle_Localized = "prefixTitle_Localized"
        case profisionalDetailsFk = "profisionalDetailsFk"
        case isOnline = "isOnline"
        case isFavourite = "isFavourite"
        case fullProfisionalDetails_Localized = "fullProfisionalDetails_Localized"
        case profisionalDetails_Localized = "profisionalDetails_Localized"
        case employeeAbout_Localized = "employeeAbout_Localized"
        case createDate = "createDate"
        case isActive = "isActive"
        case deleted = "deleted"
        case countryid = "countryid"
        case dateofbirth = "dateofbirth"
        case profileImage = "profileImage"
        case sponsered = "sponsered"
        case employeeFile = "employeeFile"
        case businessProviderFkNavigation = "businessProviderFkNavigation"
        case tblEmployeeAcademicQualification = "tblEmployeeAcademicQualification"
        case tblDoctorsViews = "tblDoctorsViews"
        case tblPatientReview = "tblPatientReview"
        case serviceList = "serviceList"
        case consultaionServiceLst = "consultaionServiceLst"
        case doctorCanDo = "doctorCanDo"
        case rate = "rate"
        case rate_stars = "rate_stars"
        case viewersnumber = "viewersnumber"
        case totalpatient = "totalpatient"
        case totalappointment = "totalappointment"
        case totalpatientRateCount = "totalpatientRateCount"
        case employeeMedicalService = "employeeMedicalService"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        subSpecialityName = try values.decodeIfPresent(String.self, forKey: .subSpecialityName)
        businessProviderEmployeeId = try values.decodeIfPresent(Int.self, forKey: .businessProviderEmployeeId)
        businessProviderFk = try values.decodeIfPresent(Int.self, forKey: .businessProviderFk)
        loginUserId = try values.decodeIfPresent(String.self, forKey: .loginUserId)
        doctorName = try values.decodeIfPresent(String.self, forKey: .doctorName)
        employeeMobileNum = try values.decodeIfPresent(String.self, forKey: .employeeMobileNum)
        employeeEmail = try values.decodeIfPresent(String.self, forKey: .employeeEmail)
        employeeGender = try values.decodeIfPresent(Int.self, forKey: .employeeGender)
        employeeTypeFk = try values.decodeIfPresent(Int.self, forKey: .employeeTypeFk)
        mainSpecialityFk = try values.decodeIfPresent(Int.self, forKey: .mainSpecialityFk)
        speciality_Localized = try values.decodeIfPresent(String.self, forKey: .speciality_Localized)
        subSpecialityIds = try values.decodeIfPresent(String.self, forKey: .subSpecialityIds)
        prefixTitleFk = try values.decodeIfPresent(Int.self, forKey: .prefixTitleFk)
        prefixTitle_Localized = try values.decodeIfPresent(String.self, forKey: .prefixTitle_Localized)
        profisionalDetailsFk = try values.decodeIfPresent(Int.self, forKey: .profisionalDetailsFk)
        isOnline = try values.decodeIfPresent(Bool.self, forKey: .isOnline)
        isFavourite = try values.decodeIfPresent(Bool.self, forKey: .isFavourite)
        fullProfisionalDetails_Localized = try values.decodeIfPresent(String.self, forKey: .fullProfisionalDetails_Localized)
        profisionalDetails_Localized = try values.decodeIfPresent(String.self, forKey: .profisionalDetails_Localized)
        employeeAbout_Localized = try values.decodeIfPresent(String.self, forKey: .employeeAbout_Localized)
        createDate = try values.decodeIfPresent(String.self, forKey: .createDate)
        isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        countryid = try values.decodeIfPresent(Int.self, forKey: .countryid)
        dateofbirth = try values.decodeIfPresent(String.self, forKey: .dateofbirth)
        profileImage = try values.decodeIfPresent(String.self, forKey: .profileImage)
        sponsered = try values.decodeIfPresent(Bool.self, forKey: .sponsered)
        employeeFile = try values.decodeIfPresent(String.self, forKey: .employeeFile)
        businessProviderFkNavigation = try values.decodeIfPresent(BusinessProviderFkNavigation.self, forKey: .businessProviderFkNavigation)
        tblEmployeeAcademicQualification = try values.decodeIfPresent([TblEmployeeAcademicQualification].self, forKey: .tblEmployeeAcademicQualification)
        tblDoctorsViews = try values.decodeIfPresent([TblDoctorsViews].self, forKey: .tblDoctorsViews)
        tblPatientReview = try values.decodeIfPresent([TblPatientReview].self, forKey: .tblPatientReview)
        serviceList = try values.decodeIfPresent([ServiceList].self, forKey: .serviceList)
        consultaionServiceLst = try values.decodeIfPresent(String.self, forKey: .consultaionServiceLst)
        doctorCanDo = try values.decodeIfPresent([Int].self, forKey: .doctorCanDo)
        rate = try values.decodeIfPresent(String.self, forKey: .rate)
        rate_stars = try values.decodeIfPresent(String.self, forKey: .rate_stars)
        viewersnumber = try values.decodeIfPresent(String.self, forKey: .viewersnumber)
        totalpatient = try values.decodeIfPresent(String.self, forKey: .totalpatient)
        totalappointment = try values.decodeIfPresent(String.self, forKey: .totalappointment)
        totalpatientRateCount = try values.decodeIfPresent(String.self, forKey: .totalpatientRateCount)
        employeeMedicalService = try values.decodeIfPresent(String.self, forKey: .employeeMedicalService)
    }

}

struct BusinessProviderFkNavigation : Codable {
    let businessProviderId : Int?
    let ownerFirstNameAr : String?
    let ownerFirstNameEn : String?
    let ownerLastNameAr : String?
    let ownerLastNameEn : String?
    let ownerMobile : String?
    let ownerEmail : String?
    let specialityFk : Int?
    let entityNameAr : String?
    let entityNameEn : String?
    let entityTypeFk : Int?
    let aboutAr : String?
    let aboutEn : String?
    let countryIds : String?
    let currencyIds : String?
    let tokenCode : String?
    let tempPassword : String?
    let tokenDateTime : String?
    let isActive : Bool?
    let deleted : Bool?
    let createDate : String?
    let imagepath : String?
    let tblBusinessProviderBranche : String?

    enum CodingKeys: String, CodingKey {

        case businessProviderId = "businessProviderId"
        case ownerFirstNameAr = "ownerFirstNameAr"
        case ownerFirstNameEn = "ownerFirstNameEn"
        case ownerLastNameAr = "ownerLastNameAr"
        case ownerLastNameEn = "ownerLastNameEn"
        case ownerMobile = "ownerMobile"
        case ownerEmail = "ownerEmail"
        case specialityFk = "specialityFk"
        case entityNameAr = "entityNameAr"
        case entityNameEn = "entityNameEn"
        case entityTypeFk = "entityTypeFk"
        case aboutAr = "aboutAr"
        case aboutEn = "aboutEn"
        case countryIds = "countryIds"
        case currencyIds = "currencyIds"
        case tokenCode = "tokenCode"
        case tempPassword = "tempPassword"
        case tokenDateTime = "tokenDateTime"
        case isActive = "isActive"
        case deleted = "deleted"
        case createDate = "createDate"
        case imagepath = "imagepath"
        case tblBusinessProviderBranche = "tblBusinessProviderBranche"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        businessProviderId = try values.decodeIfPresent(Int.self, forKey: .businessProviderId)
        ownerFirstNameAr = try values.decodeIfPresent(String.self, forKey: .ownerFirstNameAr)
        ownerFirstNameEn = try values.decodeIfPresent(String.self, forKey: .ownerFirstNameEn)
        ownerLastNameAr = try values.decodeIfPresent(String.self, forKey: .ownerLastNameAr)
        ownerLastNameEn = try values.decodeIfPresent(String.self, forKey: .ownerLastNameEn)
        ownerMobile = try values.decodeIfPresent(String.self, forKey: .ownerMobile)
        ownerEmail = try values.decodeIfPresent(String.self, forKey: .ownerEmail)
        specialityFk = try values.decodeIfPresent(Int.self, forKey: .specialityFk)
        entityNameAr = try values.decodeIfPresent(String.self, forKey: .entityNameAr)
        entityNameEn = try values.decodeIfPresent(String.self, forKey: .entityNameEn)
        entityTypeFk = try values.decodeIfPresent(Int.self, forKey: .entityTypeFk)
        aboutAr = try values.decodeIfPresent(String.self, forKey: .aboutAr)
        aboutEn = try values.decodeIfPresent(String.self, forKey: .aboutEn)
        countryIds = try values.decodeIfPresent(String.self, forKey: .countryIds)
        currencyIds = try values.decodeIfPresent(String.self, forKey: .currencyIds)
        tokenCode = try values.decodeIfPresent(String.self, forKey: .tokenCode)
        tempPassword = try values.decodeIfPresent(String.self, forKey: .tempPassword)
        tokenDateTime = try values.decodeIfPresent(String.self, forKey: .tokenDateTime)
        isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        createDate = try values.decodeIfPresent(String.self, forKey: .createDate)
        imagepath = try values.decodeIfPresent(String.self, forKey: .imagepath)
        tblBusinessProviderBranche = try values.decodeIfPresent(String.self, forKey: .tblBusinessProviderBranche)
    }

}
struct PolicyNoteList : Codable {
    let type : String?
    let policyNoteList : [String]?

    enum CodingKeys: String, CodingKey {

        case type = "type"
        case policyNoteList = "policyNoteList"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        policyNoteList = try values.decodeIfPresent([String].self, forKey: .policyNoteList)
    }

}
struct ServiceList : Codable {
    let employeeConsultationServiceId : Int?
    let businessProviderEmployeeFk : Int?
    let consultationServiceFk : Int?
    let businessProviderBranchFk : Int?
    let consultationServiceFees : Int?
    let secondConsultationServiceFees : Int?
    let consultationServiceCurrencyFk : Int?
    let consultationServiceDuration : Int?
    let validForDays : String?
    let entityName_Localized : String?
    let branchName_Localized : String?
    let branchAddress_Localized : String?
    let branchLang : String?
    let branchLat : String?
    let imagepath : String?
    let consultationServiceName_Localized : String?
    let landMark_Localized : String?
    let availableText : String?
    let branchImageList : [BranchImageList]?
    let medicalServiceList : [MedicalServiceList]?
    let canPayCach : Bool?
    let canPayOnline : Bool?
    let payOnlineType : Int?
    let policyNoteList : [PolicyNoteList]?

    enum CodingKeys: String, CodingKey {

        case employeeConsultationServiceId = "employeeConsultationServiceId"
        case businessProviderEmployeeFk = "businessProviderEmployeeFk"
        case consultationServiceFk = "consultationServiceFk"
        case businessProviderBranchFk = "businessProviderBranchFk"
        case consultationServiceFees = "consultationServiceFees"
        case secondConsultationServiceFees = "secondConsultationServiceFees"
        case consultationServiceCurrencyFk = "consultationServiceCurrencyFk"
        case consultationServiceDuration = "consultationServiceDuration"
        case validForDays = "validForDays"
        case entityName_Localized = "entityName_Localized"
        case branchName_Localized = "branchName_Localized"
        case branchAddress_Localized = "branchAddress_Localized"
        case branchLang = "branchLang"
        case branchLat = "branchLat"
        case imagepath = "imagepath"
        case consultationServiceName_Localized = "consultationServiceName_Localized"
        case landMark_Localized = "landMark_Localized"
        case availableText = "availableText"
        case branchImageList = "branchImageList"
        case medicalServiceList = "medicalServiceList"
        case canPayCach = "canPayCach"
        case canPayOnline = "canPayOnline"
        case payOnlineType = "payOnlineType"
        case policyNoteList = "policyNoteList"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        employeeConsultationServiceId = try values.decodeIfPresent(Int.self, forKey: .employeeConsultationServiceId)
        businessProviderEmployeeFk = try values.decodeIfPresent(Int.self, forKey: .businessProviderEmployeeFk)
        consultationServiceFk = try values.decodeIfPresent(Int.self, forKey: .consultationServiceFk)
        businessProviderBranchFk = try values.decodeIfPresent(Int.self, forKey: .businessProviderBranchFk)
        consultationServiceFees = try values.decodeIfPresent(Int.self, forKey: .consultationServiceFees)
        secondConsultationServiceFees = try values.decodeIfPresent(Int.self, forKey: .secondConsultationServiceFees)
        consultationServiceCurrencyFk = try values.decodeIfPresent(Int.self, forKey: .consultationServiceCurrencyFk)
        consultationServiceDuration = try values.decodeIfPresent(Int.self, forKey: .consultationServiceDuration)
        validForDays = try values.decodeIfPresent(String.self, forKey: .validForDays)
        entityName_Localized = try values.decodeIfPresent(String.self, forKey: .entityName_Localized)
        branchName_Localized = try values.decodeIfPresent(String.self, forKey: .branchName_Localized)
        branchAddress_Localized = try values.decodeIfPresent(String.self, forKey: .branchAddress_Localized)
        branchLang = try values.decodeIfPresent(String.self, forKey: .branchLang)
        branchLat = try values.decodeIfPresent(String.self, forKey: .branchLat)
        imagepath = try values.decodeIfPresent(String.self, forKey: .imagepath)
        consultationServiceName_Localized = try values.decodeIfPresent(String.self, forKey: .consultationServiceName_Localized)
        landMark_Localized = try values.decodeIfPresent(String.self, forKey: .landMark_Localized)
        availableText = try values.decodeIfPresent(String.self, forKey: .availableText)
        branchImageList = try values.decodeIfPresent([BranchImageList].self, forKey: .branchImageList)
        medicalServiceList = try values.decodeIfPresent([MedicalServiceList].self, forKey: .medicalServiceList)
        canPayCach = try values.decodeIfPresent(Bool.self, forKey: .canPayCach)
        canPayOnline = try values.decodeIfPresent(Bool.self, forKey: .canPayOnline)
        payOnlineType = try values.decodeIfPresent(Int.self, forKey: .payOnlineType)
        policyNoteList = try values.decodeIfPresent([PolicyNoteList].self, forKey: .policyNoteList)
    }

}
struct BranchImageList: Codable {
    let branchImageID, businessProviderBranchFk: Int?
    let imageTilteAr, imageTilteEn, imagePath: String?
    let imageSort: Int?
    let createDate: String?
    let deleted: Bool?

    enum CodingKeys: String, CodingKey {
        case branchImageID = "branchImageId"
        case businessProviderBranchFk, imageTilteAr, imageTilteEn, imagePath, imageSort, createDate, deleted
    }
}
struct MedicalServiceList: Codable {
    let employeeMedicalServiceID, businessProviderEmployeeFk, medicalServiceFk: Int?
    let businessProviderBranchFk: Int?
    let serviceFees, serviceCurrencyFk, serviceDuration: Int?
    let validForClinc, validForHomeVisit, allowBook: Bool?
    let createDate: String?
    let isActive: Bool?
    let branchNameAr, branchNameEn, branchNameLocalized, medicalServiceNameAr: String?
    let medicalServiceNameEn, medicalServiceNameLocalized: String?

    enum CodingKeys: String, CodingKey {
        case employeeMedicalServiceID = "employeeMedicalServiceId"
        case businessProviderEmployeeFk, medicalServiceFk, businessProviderBranchFk, serviceFees, serviceCurrencyFk, serviceDuration, validForClinc, validForHomeVisit, allowBook, createDate, isActive, branchNameAr, branchNameEn
        case branchNameLocalized = "branchName_Localized"
        case medicalServiceNameAr, medicalServiceNameEn
        case medicalServiceNameLocalized = "medicalServiceName_Localized"
    }
}
struct TblDoctorsViews : Codable {
    let doctorsViewsId : Int?
    let businessProviderEmployeeFk : Int?
    let viewsCount : Int?
    let createDate : String?

    enum CodingKeys: String, CodingKey {

        case doctorsViewsId = "doctorsViewsId"
        case businessProviderEmployeeFk = "businessProviderEmployeeFk"
        case viewsCount = "viewsCount"
        case createDate = "createDate"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        doctorsViewsId = try values.decodeIfPresent(Int.self, forKey: .doctorsViewsId)
        businessProviderEmployeeFk = try values.decodeIfPresent(Int.self, forKey: .businessProviderEmployeeFk)
        viewsCount = try values.decodeIfPresent(Int.self, forKey: .viewsCount)
        createDate = try values.decodeIfPresent(String.self, forKey: .createDate)
    }

}
struct TblEmployeeAcademicQualification : Codable {
    let academicQualificationId : Int?
    let graduationTypeFk : Int?
    let qualificationAr : String?
    let qualificationEn : String?
    let qualificationFromAr : String?
    let qualificationFromEn : String?
    let yearOfComplete : Int?
    let monthOfComplete : Int?
    let qualificationImagePath : String?
    let businessProviderEmployeeFk : Int?
    let createDate : String?
    let deleted : Bool?
    let qualificationname_Localized : String?
    let qualificationFromname_Localized : String?
    let graduationType_Localized : String?

    enum CodingKeys: String, CodingKey {

        case academicQualificationId = "academicQualificationId"
        case graduationTypeFk = "graduationTypeFk"
        case qualificationAr = "qualificationAr"
        case qualificationEn = "qualificationEn"
        case qualificationFromAr = "qualificationFromAr"
        case qualificationFromEn = "qualificationFromEn"
        case yearOfComplete = "yearOfComplete"
        case monthOfComplete = "monthOfComplete"
        case qualificationImagePath = "qualificationImagePath"
        case businessProviderEmployeeFk = "businessProviderEmployeeFk"
        case createDate = "createDate"
        case deleted = "deleted"
        case qualificationname_Localized = "qualificationname_Localized"
        case qualificationFromname_Localized = "qualificationFromname_Localized"
        case graduationType_Localized = "graduationType_Localized"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        academicQualificationId = try values.decodeIfPresent(Int.self, forKey: .academicQualificationId)
        graduationTypeFk = try values.decodeIfPresent(Int.self, forKey: .graduationTypeFk)
        qualificationAr = try values.decodeIfPresent(String.self, forKey: .qualificationAr)
        qualificationEn = try values.decodeIfPresent(String.self, forKey: .qualificationEn)
        qualificationFromAr = try values.decodeIfPresent(String.self, forKey: .qualificationFromAr)
        qualificationFromEn = try values.decodeIfPresent(String.self, forKey: .qualificationFromEn)
        yearOfComplete = try values.decodeIfPresent(Int.self, forKey: .yearOfComplete)
        monthOfComplete = try values.decodeIfPresent(Int.self, forKey: .monthOfComplete)
        qualificationImagePath = try values.decodeIfPresent(String.self, forKey: .qualificationImagePath)
        businessProviderEmployeeFk = try values.decodeIfPresent(Int.self, forKey: .businessProviderEmployeeFk)
        createDate = try values.decodeIfPresent(String.self, forKey: .createDate)
        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        qualificationname_Localized = try values.decodeIfPresent(String.self, forKey: .qualificationname_Localized)
        qualificationFromname_Localized = try values.decodeIfPresent(String.self, forKey: .qualificationFromname_Localized)
        graduationType_Localized = try values.decodeIfPresent(String.self, forKey: .graduationType_Localized)
    }

}
struct TblPatientReview : Codable {
    let patientReviewId : Int?
    let bookingFk : Int?
    let patientFk : Int?
    let doctorFk : Int?
    let doctorRate : Int?
    let clinicRate : Int?
    let assistantRate : Int?
    let patientNote : String?
    let doctorReply : String?
    let createDate : String?
    let deleted : Bool?
    let totalRate : Double?

    enum CodingKeys: String, CodingKey {

        case patientReviewId = "patientReviewId"
        case bookingFk = "bookingFk"
        case patientFk = "patientFk"
        case doctorFk = "doctorFk"
        case doctorRate = "doctorRate"
        case clinicRate = "clinicRate"
        case assistantRate = "assistantRate"
        case patientNote = "patientNote"
        case doctorReply = "doctorReply"
        case createDate = "createDate"
        case deleted = "deleted"
        case totalRate = "totalRate"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        patientReviewId = try values.decodeIfPresent(Int.self, forKey: .patientReviewId)
        bookingFk = try values.decodeIfPresent(Int.self, forKey: .bookingFk)
        patientFk = try values.decodeIfPresent(Int.self, forKey: .patientFk)
        doctorFk = try values.decodeIfPresent(Int.self, forKey: .doctorFk)
        doctorRate = try values.decodeIfPresent(Int.self, forKey: .doctorRate)
        clinicRate = try values.decodeIfPresent(Int.self, forKey: .clinicRate)
        assistantRate = try values.decodeIfPresent(Int.self, forKey: .assistantRate)
        patientNote = try values.decodeIfPresent(String.self, forKey: .patientNote)
        doctorReply = try values.decodeIfPresent(String.self, forKey: .doctorReply)
        createDate = try values.decodeIfPresent(String.self, forKey: .createDate)
        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        totalRate = try values.decodeIfPresent(Double.self, forKey: .totalRate)
    }

}
