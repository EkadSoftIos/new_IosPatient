//
//  homeModel.swift
//  E4 Patient
//
//  Created by mohab on 31/05/2021.
//

import Foundation
struct FavouriteDoctorBaseJson: Codable {
    let successtate: Int?
    let errormessage: String?
    let message: [FavouriteDoctorMessage]?
}
struct FavouriteDoctorMessage: Codable {
    let businessProviderEmployeeID, businessProviderFk: Int?
    let doctorName: String?
    let doctorNamePrefixTitle: String?
    let prefixTitleLocalized: String?
    let specialityID: Int?
    let specialityLocalized, profileImage: String?
    let totalRate: Int?
    let consultationServiceFees: Int?
    let sponsered: Bool?
    let tblBusinessProviderBranchUser: [TblBusinessProviderBranchUser1]?
    let tblEmployeeConsultationService: [TblEmployeeConsultationService]?
    let doctorCanDo: String?
    let mainAddress: FavouriteDoctorMainAddress?
    let isOnline, isFavourite: Bool?
    let fullProfisionalDetailsLocalized: String?
    let profisionalDetailsLocalized: String?
    let doctorCanDoString: String?
    let visitNo: Int?
    let entityName: String?

    enum CodingKeys: String, CodingKey {
        case businessProviderEmployeeID = "businessProviderEmployeeId"
        case businessProviderFk, doctorName
        case doctorNamePrefixTitle = "doctorName_PrefixTitle"
        case prefixTitleLocalized = "prefixTitle_Localized"
        case specialityID = "specialityId"
        case specialityLocalized = "speciality_Localized"
        case profileImage, totalRate, consultationServiceFees, sponsered, tblBusinessProviderBranchUser, tblEmployeeConsultationService, doctorCanDo, mainAddress, isOnline, isFavourite
        case fullProfisionalDetailsLocalized = "fullProfisionalDetails_Localized"
        case profisionalDetailsLocalized = "profisionalDetails_Localized"
        case doctorCanDoString, visitNo, entityName
    }
}
struct FavouriteDoctorMainAddress: Codable {
    let businessProviderBranchID, businessProviderFk: Int?
    let branchNameLocalized: String?
    let countryfk, cityFk, areaFk: Int?
    let branchStreetLocalized, branchBuldingNo, branchFloor, branchLandmarkLocalized: String?
    let branchLang, branchLat: String?
    let isMain: Bool?
    let countryLocalized, cityLocalized, areaLocalized: String?

    enum CodingKeys: String, CodingKey {
        case businessProviderBranchID = "businessProviderBranchId"
        case businessProviderFk
        case branchNameLocalized = "branchName_Localized"
        case countryfk, cityFk, areaFk
        case branchStreetLocalized = "branchStreet_Localized"
        case branchBuldingNo, branchFloor
        case branchLandmarkLocalized = "branchLandmark_Localized"
        case branchLang, branchLat, isMain
        case countryLocalized = "country_Localized"
        case cityLocalized = "city_Localized"
        case areaLocalized = "area_Localized"
    }
}
struct TblBusinessProviderBranchUser1: Codable {
    let businessProviderBranchUserID, businessProviderBranchFk, businessProviderEmployeeFk: Int?
    let branchNameAr, branchNameEn, branchNameLocalized: String?
    let distance: String?
    let longitude, latitude: String?

    enum CodingKeys: String, CodingKey {
        case businessProviderBranchUserID = "businessProviderBranchUserId"
        case businessProviderBranchFk, businessProviderEmployeeFk, branchNameAr, branchNameEn
        case branchNameLocalized = "branchName_Localized"
        case distance, longitude, latitude
    }
}
struct TblEmployeeConsultationService: Codable {
    let employeeConsultationServiceID, businessProviderEmployeeFk, consultationServiceFk: Int?
    let businessProviderBranchFk, consultationServiceFees: Int?
    let consultationServiceCurrencyFk: Int?
    let consultationServiceDuration, parentID, validForDays: Int?
    let createDate: String?
    let isActive, deleted: Bool?
    let allowBranch: Bool?
    let branchNameAr, branchNameEn, branchNameLocalized, consultationServiceNameAr: String?
    let consultationServiceNameEn, consultationServiceNameLocalized: String?
    let secondConsultation: [TblEmployeeConsultationService]?

    enum CodingKeys: String, CodingKey {
        case employeeConsultationServiceID = "employeeConsultationServiceId"
        case businessProviderEmployeeFk, consultationServiceFk, businessProviderBranchFk, consultationServiceFees, consultationServiceCurrencyFk, consultationServiceDuration
        case parentID = "parentId"
        case validForDays, createDate, isActive, deleted, allowBranch, branchNameAr, branchNameEn
        case branchNameLocalized = "branchName_Localized"
        case consultationServiceNameAr, consultationServiceNameEn
        case consultationServiceNameLocalized = "consultationServiceName_Localized"
        case secondConsultation
    }
}
