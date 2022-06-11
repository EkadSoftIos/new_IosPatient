//
//  MainSpecialityModel.swift
//  E4 Patient
//
//  Created by Nada on 8/13/21.
//

import Foundation

struct MainSpecialityModel: Codable {
    let successtate: Int?
    let errormessage: String?
    let message: [mainSpecialityData]?
}
struct mainSpecialityData: Codable {
    let specialityID: Int?
    let specialityNameAr, specialityNameEn: String?
    let specialityParentFk: Int?
    let createDate: String?
    let isActive, deleted: Bool?
    let specialityImagePath: String?
    let createdByID: Int?
    let createdByIDNavigation: String?
    let specialityParentFkNavigation: String?
    let inverseSpecialityParentFkNavigation: [InverseSpecialityParentFkNavigation]?
    let lookupMainCategorySpeciality, tblBusinessProvider, tblBusinessProviderEmployee, tblClient: [String]?
    let nameLocalized, parentSpecialityNameAr, parentSpecialityNameEn: String?

    enum CodingKeys: String, CodingKey {
        case specialityID = "specialityId"
        case specialityNameAr, specialityNameEn, specialityParentFk, createDate, isActive, deleted, specialityImagePath
        case createdByID = "createdById"
        case createdByIDNavigation = "createdByIdNavigation"
        case specialityParentFkNavigation, inverseSpecialityParentFkNavigation, lookupMainCategorySpeciality, tblBusinessProvider, tblBusinessProviderEmployee, tblClient
        case nameLocalized = "name_Localized"
        case parentSpecialityNameAr, parentSpecialityNameEn
    }
}

struct InverseSpecialityParentFkNavigation: Codable {
    let specialityID: Int?
    let specialityNameAr, specialityNameEn: String?
    let specialityParentFk: Int?
    let createDate: String?
    let isActive, deleted: Bool?
    let specialityImagePath, createdByID, createdByIDNavigation: Int?
    let inverseSpecialityParentFkNavigation, lookupMainCategorySpeciality, tblBusinessProvider, tblBusinessProviderEmployee: [String]?
    let tblClient: [String]
    let nameLocalized, parentSpecialityNameAr, parentSpecialityNameEn: String?

    enum CodingKeys: String, CodingKey {
        case specialityID = "specialityId"
        case specialityNameAr, specialityNameEn, specialityParentFk, createDate, isActive, deleted, specialityImagePath
        case createdByID = "createdById"
        case createdByIDNavigation = "createdByIdNavigation"
        case inverseSpecialityParentFkNavigation, lookupMainCategorySpeciality, tblBusinessProvider, tblBusinessProviderEmployee, tblClient
        case nameLocalized = "name_Localized"
        case parentSpecialityNameAr, parentSpecialityNameEn
    }
}
