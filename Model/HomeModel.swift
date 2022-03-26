//
//  homeModel.swift
//  E4 Patient
//
//  Created by mohab on 31/05/2021.
//

import Foundation
struct HomeModel: Codable {
    var successtate: Int?
    var errormessage: String?
    var message: HomeMessage?
}

// MARK: - Message
struct HomeMessage: Codable {
    var patientID: Int?
    var patientLoginUserID, patientFirstName, patientLastName, patientEmail: String?
    var patientProfileImage, createDate, lastVisitDate: String?
    var slider: [Slider]?
    var speciality: [Speciality]?
    var doctorDataForAPI: [DoctorDataForAPI]?

    enum CodingKeys: String, CodingKey {
        case patientID = "patientId"
        case patientLoginUserID = "patientLoginUserId"
        case patientFirstName, patientLastName, patientEmail, patientProfileImage, createDate, lastVisitDate, slider, speciality
        case doctorDataForAPI = "doctorDataForApi"
    }
}

// MARK: - DoctorDataForAPI
struct DoctorDataForAPI: Codable {
    var businessProviderEmployeeID, businessProviderFk: Int?
    var doctorName: String?
    var prefixTitleLocalized: String?
    var specialityID: Int?
    var specialityLocalized, profileImage: String?
    var totalRate, totalViews, totalpatients, visitNo: Int?
    var fullProfisionalDetailsLocalized: String?
    var branchAddressLocalized: String?

    enum CodingKeys: String, CodingKey {
        case businessProviderEmployeeID = "businessProviderEmployeeId"
        case businessProviderFk, doctorName
        case prefixTitleLocalized = "prefixTitle_Localized"
        case specialityID = "specialityId"
        case specialityLocalized = "speciality_Localized"
        case profileImage, totalRate, totalViews, totalpatients
        case fullProfisionalDetailsLocalized = "fullProfisionalDetails_Localized"
        case branchAddressLocalized = "branchAddress_Localized"
    }
}



// MARK: - Slider
struct Slider: Codable {
    var sliderID, sliderTypeFk: Int?
    var sliderTitle, sliderText: String?
    var sliderImagePath: String?
    var isActive: Bool?
    var createDate: String?

    enum CodingKeys: String, CodingKey {
        case sliderID = "sliderId"
        case sliderTypeFk, sliderTitle, sliderText, sliderImagePath, isActive, createDate
    }
}

// MARK: - Speciality
struct Speciality: Codable {
    var specialityID: Int?
    var specialityNameAr, specialityNameEn: String?
    var specialityParentFk: Int?
    var createDate: String?
    var isActive, deleted: Bool?
    var nameLocalized, parentSpecialityNameAr, parentSpecialityNameEn: String?
    var specialityImagePath: String?
    var numberOfDoctors: Int?

    enum CodingKeys: String, CodingKey {
        case specialityID = "specialityId"
        case specialityNameAr, specialityNameEn, specialityParentFk, createDate, isActive, deleted
        case nameLocalized = "name_Localized"
        case parentSpecialityNameAr, parentSpecialityNameEn, specialityImagePath, numberOfDoctors
    }
}
