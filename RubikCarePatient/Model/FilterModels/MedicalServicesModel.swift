//
//  MedicalServicesModel.swift
//  E4 Patient
//
//  Created by Nada on 8/13/21.
//

import Foundation

struct MedicalServicesModel: Codable {
    let successtate: Int?
    let errormessage: String?
    let message: [MedicalServicesData]?
}
struct MedicalServicesData: Codable {
    let medicalServiceID: Int?
    let medicalServiceNameAr, medicalServiceNameEn: String?
    let subCategoryFk: Int?
    let createDate: String?
    let isActive, deleted: Bool?
    let createdByID, createdByIDNavigation, subCategoryFkNavigation: String?
    let tblBooking, tblEmployeeMedicalService: [String]?
    let nameLocalized: String?

    enum CodingKeys: String, CodingKey {
        case medicalServiceID = "medicalServiceId"
        case medicalServiceNameAr, medicalServiceNameEn, subCategoryFk, createDate, isActive, deleted
        case createdByID = "createdById"
        case createdByIDNavigation = "createdByIdNavigation"
        case subCategoryFkNavigation, tblBooking, tblEmployeeMedicalService
        case nameLocalized = "name_Localized"
    }
}
