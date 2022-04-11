//
//  getAllMedicineModel.swift
//  E4 Patient
//
//  Created by mohab on 06/03/2021.
//

import Foundation
struct getAllMedicineModel: Codable {
    let successtate: Int?
    let errormessage: String?
    var message: [AllMedicineMessage]?
}

// MARK: - Message
struct AllMedicineMessage: Codable {
    let medicationID: Int?
    let medicationName, nameLocalized, medicineTypeNameLocalized: String?
    let medicineType: Int?
    let medicineImagePath: String?
    let medicineFormFk, medicineStrenghtFk, strenghtValue, companyFk: Int?
    let medicineCategoryFk: Int?
    let medicinAboutLocalized: String?
    let medicinIndicationLocalized, medicinSideEffectsLocalized, medicinDoseLocalized, medicinActiveIngrdientLocalized: String?
    let medicinPrecautionsLocalized: String?
    let medicineForm, medicineStrenght: String?
    let inFrequencyLst: Bool?

    enum CodingKeys: String, CodingKey {
        case medicationID = "medicationId"
        case medicationName
        case nameLocalized = "name_Localized"
        case medicineTypeNameLocalized = "medicineType_name_Localized"
        case medicineType, medicineImagePath, medicineFormFk, medicineStrenghtFk, strenghtValue, companyFk, medicineCategoryFk
        case medicinAboutLocalized = "medicinAbout_Localized"
        case medicinIndicationLocalized = "medicinIndication_Localized"
        case medicinSideEffectsLocalized = "medicinSideEffects_Localized"
        case medicinDoseLocalized = "medicinDose_Localized"
        case medicinActiveIngrdientLocalized = "medicinActiveIngrdient_Localized"
        case medicinPrecautionsLocalized = "medicinPrecautions_Localized"
        case medicineForm, medicineStrenght, inFrequencyLst
    }
}
