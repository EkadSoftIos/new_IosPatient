//
//  DoctorSearchModel.swift
//  E4 Patient
//
//  Created by Nada on 8/14/21.
//

import Foundation
struct DoctorSearchModel: Codable {
    let successtate: Int?
    let errormessage: String?
    let message: [DoctorSearchData]?
}
struct DoctorSearchData: Codable {
    let businessProviderEmployeeID, businessProviderFk: Int?
    let doctorName, doctorNamePrefixTitle, prefixTitleLocalized: String?
    let specialityID: Int?
    let specialityLocalized: String?
    let profileImage: String?
    let totalRate: Int?
    let consultationServiceFees: Int?
    let sponsered: Bool?
    let tblBusinessProviderBranchUser: [TblBusinessProviderBranchUser]?
    let tblEmployeeConsultationService: String?
    let doctorCanDo: [Int]?
    let mainAddress: MainAddress?
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
struct MainAddress: Codable {
    let businessProviderBranchID, businessProviderFk: Int?
    let branchNameLocalized: String?
    let countryfk, cityFk, areaFk: Int?
    let branchStreetLocalized, branchBuldingNo, branchFloor, branchLandmarkLocalized: String?
    let branchLang, branchLat: String?
    let isMain: Bool?
    let countryLocalized: String?
    let cityLocalized: String?
    let areaLocalized: String?

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
struct TblBusinessProviderBranchUser: Codable {
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
