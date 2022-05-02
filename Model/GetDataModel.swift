//
//  GetDataModel.swift
//  E4 Patient
//
//  Created by mohab on 25/02/2021.
//

import Foundation
//struct UserDataModel: Codable {
//    let successtate: Int?
//    let errormessage: String?
//    var message: UserDataMessage?
//}

// MARK: - Message
//struct UserDataMessage: Codable {
//    var patientID: Int?
//       var patientLoginUserID, patientFirstName, patientLastName, patientEmail: String?
//       var patientMobileCode, patientMobile, patientBirthDate: String?
//       var patientGender: Int?
//       var patientWeight, patientHeight: Double?
//       var blodGroupFk: Int?
//    var attachedIDPath : String?
//       var  patientProfileImage, tokenCode: String?
//       var tokenDateTime: String?
//       var tempPassword, createDate: String?
//       var isActive, deleted: Bool?
//       var countryid: Int?
//       var patientIdentification, forgrtpasswordToken, profilePercentage: String?
//       var profilepercentageList: ProfilepercentageList?
//       var blodGroupFkNavigation: BlodGroupFkNavigation?
//       var tblPatientAddress: [TblPatientAddress]?
//       var tblPatientAllergies: [TblPatientAllergy]?
//       var tblPatientContact: [TblPatientContact]?
//       var tblPatientDisease: [TblPatientDisease]?
//       var tblPatientMedicalReport: [TblPatientMedicalReport]?
//       var tblPatientMedicine: [TblPatientMedicine]?
//       var tblPatientProfilePermition: [TblPatientProfilePermition]?
//       var tblPatientSocialHistory: [TblPatientSocialHistory]?
//       var tblPatientSocialFamily: [TblPatientSocialFamily]?
//       var tblPatientSurgery: [TblPatientSurgery]?
//       let visitSummery: [VisitSummery]?
//       let followUpCardList: [FollowUpCardList]?
//
//       enum CodingKeys: String, CodingKey {
//           case patientID = "patientId"
//           case patientLoginUserID = "patientLoginUserId"
//           case patientFirstName, patientLastName, patientEmail, patientMobileCode, patientMobile, patientBirthDate, patientGender, patientWeight, patientHeight, blodGroupFk
//           case attachedIDPath = "attachedIdPath"
//           case patientProfileImage, tokenCode, tokenDateTime, tempPassword, createDate, isActive, deleted, countryid, patientIdentification, forgrtpasswordToken
//           case profilePercentage = "profile_Percentage"
//           case profilepercentageList = "profilepercentage_List"
//           case blodGroupFkNavigation, tblPatientAddress, tblPatientAllergies, tblPatientContact, tblPatientDisease, tblPatientMedicalReport, tblPatientMedicine, tblPatientProfilePermition, tblPatientSocialHistory, tblPatientSocialFamily, tblPatientSurgery, visitSummery, followUpCardList
//       }
//   }
struct VisitSummery: Codable {
    let date: String?
    let bookingFk, doctorID: Int?
    let summeryOrReport, doctorName: String?
    let bookingSummaryFiles: [BookingSummaryFile]?
}
struct BookingSummaryFile: Codable {
    let bookingSummaryFilesID: Int?
    let createDate: String?
    let bookingFk: Int?
    let bookingSummaryFilesPath: String?

    enum CodingKeys: String, CodingKey {
        case bookingSummaryFilesID = "bookingSummaryFilesId"
        case createDate, bookingFk, bookingSummaryFilesPath
    }
}
// MARK: - TblPatientMedicalReport
//struct TblPatientMedicalReport: Codable {
//    let patientMedicalReportID, patientFk: Int?
//    let medicalReportName, medicalReportDate, medicalReportResult, medicalReportResultFile: String?
//   // let businessProviderEmployeeFk: Int
//    let doctorName: String?
//    //let medicalReportFromFk: Int
//    let notes, createDate: String?
//    let isActive, deleted: Bool?
//
//    enum CodingKeys: String, CodingKey {
//        case patientMedicalReportID = "patientMedicalReportId"
//        case patientFk, medicalReportName, medicalReportDate, medicalReportResult, medicalReportResultFile, /*businessProviderEmployeeFk,*/ doctorName/*, medicalReportFromFk*/, notes, createDate, isActive, deleted
//    }
//}
   // MARK: - BlodGroupFkNavigation
   struct BlodGroupFkNavigation: Codable {
       var blodGroupID: Int?
       var blodGroupNameAr, blodGroupNameEn, nameLocalized, createDate: String?
       var isActive, deleted: Bool?

       enum CodingKeys: String, CodingKey {
           case blodGroupID = "blodGroupId"
           case blodGroupNameAr, blodGroupNameEn
           case nameLocalized = "name_Localized"
           case createDate, isActive, deleted
       }
   }

   // MARK: - ProfilepercentageList
   struct ProfilepercentageList: Codable {
       var basicData, socialHistory, disease, profilePermition: String?
       var medicine, address, allergies, socialFamily: String?
       var blodGroup, contact: String?
   }

   // MARK: - TblPatientAddress
   struct TblPatientAddress: Codable {
       var patientAddressID, patientFk: Int?
       var patientAddressName: String?
       var countryFk: Int?
       var countryNameLocalized: String?
       var cityFk: Int?
       var cityNameLocalized: String?
       var areaFk: Int?
       var areaNameLocalized, streetName, buldingNum, floor: String?
       var landMark, addressLang, addressLat: String?
       var mapAddress: String?
       var isMain: Bool?
       var createDate: String?
       var isActive, deleted: Bool?

       enum CodingKeys: String, CodingKey {
           case patientAddressID = "patientAddressId"
           case patientFk, patientAddressName, countryFk
           case countryNameLocalized = "country_name_localized"
           case cityFk
           case cityNameLocalized = "city_name_localized"
           case areaFk
           case areaNameLocalized = "area_name_localized"
           case streetName, buldingNum, floor, landMark, addressLang, addressLat, mapAddress, isMain, createDate, isActive, deleted
       }
   }

   // MARK: - TblPatientAllergy
   struct TblPatientAllergy: Codable {
       var patientAllergiesID, patientFk: Int?
       var allergiesName, allergiesTriggeredBy, allergiesOccuered, allergiesFiristDiagonsed: String?
       var medicationIDS: String?
       var notes: String?
       var createDate: String?
       var isActive, deleted: Bool?

       enum CodingKeys: String, CodingKey {
           case patientAllergiesID = "patientAllergiesId"
           case patientFk, allergiesName, allergiesTriggeredBy, allergiesOccuered, allergiesFiristDiagonsed
           case medicationIDS = "medicationIds"
           case notes, createDate, isActive, deleted
       }
   }

   // MARK: - TblPatientContact
   struct TblPatientContact: Codable {
       var patientContactID, patientFk: Int?
       var contactName: String?
       var relationFk: Int?
       var relationLocalizedName: String?
       var contactMobileCode: String?
       var contactMobile, contactEmail: String?
       var contactAddress: String?
       var contactCountryFk, contactCityFk, contactAreaFk: Int?
       var createDate: String?
       var isActive, deleted: Bool?

       enum CodingKeys: String, CodingKey {
           case patientContactID = "patientContactId"
           case patientFk, contactName, relationFk
           case relationLocalizedName = "relation_localized_name"
           case contactMobileCode, contactMobile, contactEmail, contactAddress, contactCountryFk, contactCityFk, contactAreaFk, createDate, isActive, deleted
       }
   }

   // MARK: - TblPatientDisease
   struct TblPatientDisease: Codable {
       var patientDiseaseID, patientFk: Int?
       var diseaseFk, diseaseStatusFk: Int?
       var medicationIDS, diagonsedDate: String?
       var notes: String?
       var businessProviderEmployeeFk: Int?
       var doctorName: String?
       var createDate: String?
       var isActive, deleted: Bool?

       enum CodingKeys: String, CodingKey {
           case patientDiseaseID = "patientDiseaseId"
           case patientFk, diseaseFk, diseaseStatusFk
           case medicationIDS = "medicationIds"
           case diagonsedDate, notes, businessProviderEmployeeFk, doctorName, createDate, isActive, deleted
       }
   }

   // MARK: - TblPatientMedicine
//   struct TblPatientMedicine: Codable {
//    var patientMedicineID, patientFk, medicationFk: Int?
//    //, diseaseStatusFk dateFrom, dateTo frequencyOfRepetition, frequencyValue, , schedualType
//    var  notes: String?
//    var businessProviderEmployeeFk: Int?
//    var createDate: String?
//    var isActive, deleted: Bool?
//    var doctorName: String?
//    var quantity: Int?
//    var whenTake: String?
//    var durationType: Int?
//    var whenMedicationTakenFk: Int?
//    var whenMedicationTakenName: String?
//    var  durationTypetNameLocalized: String?
//    //. var  schedualType: Int
//    //  var schedualDays: String
//    var prescriptionFk: Int?
//    var showInList: Bool?
//    var medicationName, medicineForm, medicineStrenght: String?
//    var medicineImagePath, medicinAboutLocalized: String?
//    var DurationValue: Int?
//    enum CodingKeys: String, CodingKey {
//           case patientMedicineID = "patientMedicineId"
//           case patientFk, medicationFk, notes, businessProviderEmployeeFk, createDate, isActive, deleted, doctorName, quantity, whenTake, prescriptionFk, showInList, medicationName, medicineForm, medicineStrenght, medicineImagePath, durationType, whenMedicationTakenFk
//        //diseaseStatusFk,
//           case medicinAboutLocalized = "medicinAbout_Localized"
//        case durationTypetNameLocalized = "durationTypetName_Localized"
//        case whenMedicationTakenName = "whenMedicationTakenName_Localized"
//        case DurationValue = "durationValue"
//       }
//   }

   // MARK: - TblPatientProfilePermition
//   struct TblPatientProfilePermition: Codable {
//       var patientProfilePermitionID, patientFk: Int?
//       var forAllDoctors: Bool?
//       var doctorIDS: String?
//       var showPersonalDetails, showAddress: Bool?
//       var showEmergencyContact, showDisease: Bool?
//       var showMedication, showAllergies, showSocialHistory, showSocialFamily: Bool?
//       var showSurgery: Bool?
//    var showMedicalReport: Bool?
//       enum CodingKeys: String, CodingKey {
//           case patientProfilePermitionID = "patientProfilePermitionId"
//           case patientFk, forAllDoctors
//           case doctorIDS = "doctorIds"
//           case showPersonalDetails, showAddress, showEmergencyContact, showDisease, showMedication, showAllergies, showSocialHistory, showSocialFamily, showSurgery,showMedicalReport
//       }
//   }

   // MARK: - TblPatientSocialFamily
   struct TblPatientSocialFamily: Codable {
       var patientSocialFamilyID, patientFk, relationFk: Int?
       var notes, createDate: String?
       var isActive, deleted: Bool?
       var relationNameLocalized: String?

       enum CodingKeys: String, CodingKey {
           case patientSocialFamilyID = "patientSocialFamilyId"
           case patientFk, relationFk, notes, createDate, isActive, deleted
           case relationNameLocalized = "relation_name_Localized"
       }
   }

   // MARK: - TblPatientSocialHistory
   struct TblPatientSocialHistory: Codable {
       var patientSocialHistoryID, patientFk: Int?
       var job, education: String?
       var isSmoke, alcoholConsumption: Bool?
       var maritalStatusFk, childerenNum: Int?
       var generalDite, exercise, createDate: String?
       var isActive, deleted: Bool?

       enum CodingKeys: String, CodingKey {
           case patientSocialHistoryID = "patientSocialHistoryId"
           case patientFk, job, education, isSmoke, alcoholConsumption, maritalStatusFk, childerenNum, generalDite, exercise, createDate, isActive, deleted
       }
   }

   // MARK: - TblPatientSurgery
   struct TblPatientSurgery: Codable {
       var patientSurgeryID, patientFk: Int?
       var patientSurgeryName, addingData, patientSurgeryDate: String?
       var businessProviderEmployeeFk: Int?
       var doctorName, notes: String?
       var createDate: String?
       var isActive, deleted: Bool?
       enum CodingKeys: String, CodingKey {
           case patientSurgeryID = "patientSurgeryId"
           case patientFk, patientSurgeryName, addingData, patientSurgeryDate, businessProviderEmployeeFk, doctorName, notes, createDate, isActive, deleted
       }
   }
    struct FollowUpCardList: Codable {
        let followUpCardID, patientFk: Int?
        let diabetes, hypertension, height, weight: String?
        let temperature, followUpCardDate, notes, createDate: String?
        let createdByDoctorFk: Int?
        let doctorName: String?

        enum CodingKeys: String, CodingKey {
            case followUpCardID = "followUpCardId"
            case patientFk, diabetes, hypertension, height, weight, temperature, followUpCardDate, notes, createDate, createdByDoctorFk, doctorName
        }
    }

















struct UserDataModel: Codable {
    let successtate: Int?
    let errormessage: String?
    var message: UserDataMessage?
}

// MARK: - Message
struct UserDataMessage: Codable {
    let patientID: Int?
    let patientLoginUserID, patientFirstName, patientLastName, patientEmail: String?
    let patientMobileCode, patientMobile, patientBirthDate: String?
    let patientGender: Int?
    let blodGroupFk: Int?
    let patientWeight, patientHeight: Double?
    let attachedIDPath: String?
    let patientProfileImage, tokenCode: String?
    let tokenDateTime: String?
    let tempPassword, createDate: String?
    let isActive, deleted: Bool?
    let countryid: Int?
    let patientIdentification: String?
    let forgrtpasswordToken: String?
    let profilePercentage: String?
    let profilepercentageList: ProfilepercentageList?
    let blodGroupFkNavigation: BlodGroupFkNavigation?
    let tblPatientAddress: [TblPatientAddress]?
    var tblPatientAllergies: [TblPatientAllergy]?
    var tblPatientContact: [TblPatientContact]?
    var tblPatientDisease: [TblPatientDisease]?
    var tblPatientMedicalReport: [TblPatientMedicalReport]?
    var tblPatientMedicine: [TblPatientMedicine]?
    let tblPatientProfilePermition: [TblPatientProfilePermition]?
    let tblPatientSocialHistory: [TblPatientSocialHistory]?
    var tblPatientSocialFamily: [TblPatientSocialFamily]?
    var tblPatientSurgery: [TblPatientSurgery]?
    let phone: String?
    let visitSummery: [VisitSummery]?
    let followUpCardList: [FollowUpCardList]?
//    let insuranceList: [JSONAny]?

    enum CodingKeys: String, CodingKey {
        case patientID = "patientId"
        case patientLoginUserID = "patientLoginUserId"
        case patientFirstName, patientLastName, patientEmail, patientMobileCode, patientMobile, patientBirthDate, patientGender, patientWeight, patientHeight, blodGroupFk
        case attachedIDPath = "attachedIdPath"
        case patientProfileImage, tokenCode, tokenDateTime, tempPassword, createDate, isActive, deleted, countryid, patientIdentification, forgrtpasswordToken
        case profilePercentage = "profile_Percentage"
        case profilepercentageList = "profilepercentage_List"
        case blodGroupFkNavigation, tblPatientAddress, tblPatientAllergies, tblPatientContact, tblPatientDisease, tblPatientMedicalReport, tblPatientMedicine, tblPatientProfilePermition, tblPatientSocialHistory, tblPatientSocialFamily, tblPatientSurgery, phone, visitSummery, followUpCardList
    }
}

// MARK: - ProfilepercentageList


// MARK: - TblPatientAddress


// MARK: - TblPatientMedicalReport
struct TblPatientMedicalReport: Codable {
    let patientMedicalReportID, patientFk: Int?
    let medicalReportName, medicalReportDate, medicalReportResult, medicalReportResultFile: String?
    let businessProviderEmployeeFk: Int?
    let doctorName: String?
    let medicalReportFromFk: String?
    let notes, createDate: String?
    let isActive, deleted: Bool?
    let createdByDoctorFk: String?
    let createdByDoctorName: String?

    enum CodingKeys: String, CodingKey {
        case patientMedicalReportID = "patientMedicalReportId"
        case patientFk, medicalReportName, medicalReportDate, medicalReportResult, medicalReportResultFile, businessProviderEmployeeFk, doctorName, medicalReportFromFk, notes, createDate, isActive, deleted, createdByDoctorFk, createdByDoctorName
    }
}

// MARK: - TblPatientMedicine
struct TblPatientMedicine: Codable {
    let patientMedicineID, patientFk, medicationFk: Int?
    let diseaseStatusFk, dateFrom, dateTo: String?
    let notes: String?
    let businessProviderEmployeeFk: Int?
    let createDate: String?
    let isActive, deleted: Bool?
    let doctorName: String?
    let quantity: Int?
    let whenTake: String?
    let frequencyOfRepetition, frequencyValue, schedualType, schedualDays: String?
    let prescriptionFk: Int?
    let showInList: Bool?
    let medicationName, medicineForm, medicineStrenght, medicineImagePath: String?
    let medicinAboutLocalized: String?
    let whenMedicationTakenFk: Int?
    let whenMedicationTakenNameLocalized: String?
    let durationType: Int?
    let durationTypetNameLocalized: String?
    let durationValue: Int?
    let createdByDoctorFk: String?
    let createdByDoctorName: String?

    enum CodingKeys: String, CodingKey {
        case patientMedicineID = "patientMedicineId"
        case patientFk, medicationFk, diseaseStatusFk, dateFrom, dateTo, notes, businessProviderEmployeeFk, createDate, isActive, deleted, doctorName, quantity, whenTake, frequencyOfRepetition, frequencyValue, schedualType, schedualDays, prescriptionFk, showInList, medicationName, medicineForm, medicineStrenght, medicineImagePath
        case medicinAboutLocalized = "medicinAbout_Localized"
        case whenMedicationTakenFk
        case whenMedicationTakenNameLocalized = "whenMedicationTakenName_Localized"
        case durationType
        case durationTypetNameLocalized = "durationTypetName_Localized"
        case durationValue, createdByDoctorFk, createdByDoctorName
    }
}

// MARK: - TblPatientProfilePermition
struct TblPatientProfilePermition: Codable {
    let patientProfilePermitionID, patientFk: Int?
    let forAllDoctors: Bool?
    let doctorIDS: String?
    let showEmergencyContact, showDisease, showMedication, showAllergies: Bool?
    let showSocialHistory, showSocialFamily, showSurgery, showMedicalReport: Bool?
    let showFollowUpCard: Bool?
    let showDiseaseAnalysis: Bool?
    var showPersonalDetails, showAddress: Bool?

//    let doctorList: JSONNull?

    enum CodingKeys: String, CodingKey {
        case patientProfilePermitionID = "patientProfilePermitionId"
        case patientFk, forAllDoctors
        case doctorIDS = "doctorIds"
        case showEmergencyContact, showDisease, showMedication, showAllergies, showSocialHistory, showSocialFamily, showSurgery, showMedicalReport, showFollowUpCard, showDiseaseAnalysis,showPersonalDetails, showAddress
    }
}

// MARK: - TblPatientSocialHistory


// MARK: - VisitSummery


// MARK: - Encode/decode helpers



class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}
