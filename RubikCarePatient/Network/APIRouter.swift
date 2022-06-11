//
//  APIRouter.swift
//  ytsInCode
//
//  Created by zyad galal on 9/19/19.
//  Copyright © 2019 zyad galal. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter : URLRequestConvertible{
    case login(params: [String: Any])
    case externallogin(params: [String: Any])
    case checkEmail(params: [String: Any])
    case logout(params: [String: Any])
    case profile
    case GetAdress
    case register(params: [String: Any])
    case deleteAdress(params: [String: Any])
    case addAllergies(params: [String: Any])
    case deleAllergies(Id: Int)
    case deleteDieses(Id: Int)
    case addDieseas(params: [String: Any])
    case codeVerfication(params: [String: Any])
    case forgetPass(params: [String: Any])
    case resendCode(params: [String: Any])
    case getAllCountries
    case addNewAddress(params: [String: Any])
    case mainAddress(params: [String: Any])
    case DeleteContact(params: [String: Any])
    case AddEmergency(params: [String: Any])
    case DeleteMedication(id: Int)
    case getAllMedicine
    case addSocialHistory(params: [String: Any])
    case deleteFamilyHistory(id: Int)
    case addFamily(params: [String: Any])
    case deleteSurgery(id: Int)
    case addSurgery(params: [String: Any])
    case deleteMedical(id: Int)
    case addMedicalReport(params: [String: Any])
    case editProfile(params: [String: Any])
    case changePassword(params: [String: Any])
    case permission(params: [String: Any])
    case getDieseases
    case getBlodGroub
    case getRelations
    case MaritalStatus
    case diesesStatus
    case uploadImage
    case getEmergency
    case EntityType
    case whenMedication
    case getDoctors(params: [String: Any])
    case AddMedication(params: [String: Any])
    case speciality
    case BusinessProvider
    case employePermision(id: Int)
    case home
    case PrefixTitle
    case professionalTitle
    case mainSpeciality
    case medicalServices(id: Int)
    case doctorSearch(parameters: [String: Any])
    case doctorById(id: Int)
    case branchAvailableTime(parameters: [String: Any])
    case walletBalance
    case doctorreviews(id: Int)
    case addBooking(parameters: [String: Any])
    case consultationLog(parameters: [String: Any])
    case consultationDetails(id: Int)
    case AppointmentHistory(params: [String: Any])
    case AppointmentReview(params: [String: Any])
    case GetFavouriteDoctor
    case AddFavouriteDoctor(id: Int)
    case RemoveFavouriteDoctor(id: Int)
    case AppointmentsDetailsCancel(bookingid: Int)
    case cancelAppointment(params: [String: Any])
    case bookingReport(params: [String: Any])
    
    case notificationList
    case readAllNotifications
    case deleteAllNotification
    case deleteNotification(notificationId: Int)
    case readNotification(notificationId: Int)
    case notificationCount
    case faq
    case saveContactUs(params: [String: Any])
    case getFullWebPages
    case reportServiceList
    case reportBranchList
    
    var method : HTTPMethod {
        switch self {
        case .login(_):
          return  .post
        case .externallogin(_):
          return  .post
        case .checkEmail(_):
          return  .post
        case .profile, .GetAdress, .deleAllergies(_), .deleteDieses(_), .DeleteMedication(_), .getAllMedicine,.deleteSurgery(_),.deleteMedical(_), .getDieseases, .getBlodGroub, .diesesStatus, .getEmergency, .getRelations, .MaritalStatus, .EntityType, .deleteFamilyHistory(_), .whenMedication, .employePermision(_), .speciality, .BusinessProvider, .home, .doctorById:
        return .get
        case .deleteAdress(_), .addFamily(_), .AddMedication(_), .getDoctors(_):
              return  .post
        case .register(_), .addAllergies(_), .mainAddress(_), .DeleteContact(_), .AddEmergency(_), .addDieseas(_), . addSocialHistory(_), .addSurgery(_), .addMedicalReport(_), .editProfile(_), .changePassword(_), .permission(_):
            return .post
        case .codeVerfication(_),.uploadImage:
            return .post
        case .resendCode(_):
            return .post
        case .getAllCountries:
        return .get
        case .addNewAddress(_):
            return .post
        case .PrefixTitle, .professionalTitle, .mainSpeciality, .medicalServices:
            return .get
        case .doctorSearch:
            return .post
        case .branchAvailableTime:
            return .post
        case .walletBalance:
            return .get
        case .doctorreviews:
            return .get
        case .addBooking:
            return .post
        case .consultationLog:
            return .post
        case .consultationDetails:
            return .get
        case .AppointmentHistory(_):
            return .post
        case .GetFavouriteDoctor:
            return .get
        case .AppointmentReview(_):
            return .post
        case .AddFavouriteDoctor(_):
            return .get
        case .RemoveFavouriteDoctor(_):
            return .get
        case .AppointmentsDetailsCancel(_):
            return .get
        case.cancelAppointment:
            return .post
        case .logout(_):
            return .post
        case .forgetPass:
            return .post
        case .notificationList:
            return .get
        case .readAllNotifications:
            return .get
        case .deleteAllNotification:
            return .get
        case .deleteNotification(_):
            return .get
        case .readNotification(_):
            return .get
        case .notificationCount:
            return .get
        case.faq:
            return .get
        case.saveContactUs:
            return .post
        case.getFullWebPages:
            return .get
        case.bookingReport:
            return .post
        case.reportServiceList:
            return .get
        case.reportBranchList:
            return .get
        }
    }
    var path : String {
        switch self {
        case .login(_):
            return "\(Constants.baseURL)Common/Login"
        case .externallogin(_):
            return "\(Constants.baseURL)Common/ExternalLogin"
        case .checkEmail(_):
            return "\(Constants.baseURL)Common/CheckUserByEmail"
        case .profile :
            return "\(Constants.baseURL)Patient/Patient_Get_data"
        case .register(_):
            return "\(Constants.baseURL)Common/RegisterPatient"
        case .GetAdress:
            return "\(Constants.baseURL)Patient/getPatientAdrress"
        case .deleteAdress(_):
        return "\(Constants.baseURL)PatientAddress/Delete"
        case .addAllergies(_):
            return "\(Constants.baseURL)PatientAllergies/SaveData"
        case .deleAllergies(let Id):
            return "\(Constants.baseURL)PatientAllergies/delete_by_id?Id=\(Id)"
        case .deleteDieses(let Id):
        return "\(Constants.baseURL)PatientDisease/delete_by_id?Id=\(Id)"
        case .addDieseas(_):
            return "\(Constants.baseURL)PatientDisease/SaveData"
        case .codeVerfication(_):
            return "\(Constants.baseURL)Common/ActivateCode"
        case .getAllCountries:
            return "\(Constants.baseURL)Lookup/Country_get_all_full"
        case .resendCode(_):
            return ""
        case .addNewAddress(_):
            return "\(Constants.baseURL)PatientAddress/SaveData"
        case .mainAddress(_):
            return "\(Constants.baseURL)PatientAddress/UpdateMainAddress"
        case .DeleteContact(_):
            return "\(Constants.baseURL)PatientContact/Delete"
        case .AddEmergency(_):
            return "\(Constants.baseURL)PatientContact/SaveData"
        case  .DeleteMedication(let id):
            return "\(Constants.baseURL)PatientMedicine/delete_by_id?Id=\(id)"
        case .getAllMedicine:
            return "\(Constants.baseURL)Lookup/Medication_get_all"
        case .addSocialHistory(_):
            return "\(Constants.baseURL)PatientSocialHistory/SaveData"
        case .deleteFamilyHistory(let id):
            return "\(Constants.baseURL)PatientSocialFamily/delete_by_id?Id=\(id)"
        case .deleteSurgery(let id):
            return "\(Constants.baseURL)PatientSurgery/delete_by_id?Id=\(id)"
        case .addSurgery(_):
            return "\(Constants.baseURL)PatientSurgery/SaveData"
        case .deleteMedical(let id):
            return "\(Constants.baseURL)PatientMedicalReport/delete_by_id?Id=\(id)"
        case .addMedicalReport(_):
            return "\(Constants.baseURL)PatientMedicalReport/SaveData"
        case .editProfile(_):
            return "\(Constants.baseURL)Patient/UpdateBasicData"
        case .changePassword(_):
            return "\(Constants.baseURL)Common/ChangePasswordByOldPassword"
        case .permission(_):
                return "\(Constants.baseURL)PatientProfilePermition/SaveData"
        case .getDieseases:
            return "\(Constants.baseURL)Lookup/Disease_get_all"
        case .getBlodGroub:
            return "\(Constants.baseURL)Lookup/BlodGroup_get_all"
        case .getRelations:
            return "\(Constants.baseURL)Lookup/Relation_get_all"
        case .MaritalStatus:
            return "\(Constants.baseURL)Lookup/MaritalStatus_get_all"
        case .diesesStatus:
            return "\(Constants.baseURL)Lookup/DiseaseStatus_get_all"
        case .uploadImage:
            return "\(Constants.baseURL)Common/FormDataUpload"
        case .getEmergency:
            return "\(Constants.baseURL)Lookup/Emergency_get_all"
        case .EntityType:
            return "\(Constants.baseURL)Lookup/EntityType_get_all"
        case .addFamily(_):
            return  "\(Constants.baseURL)PatientSocialFamily/SaveData"
        case .AddMedication(_):
            return "\(Constants.baseURL)PatientMedicine/SaveData"
        case .whenMedication:
            return "\(Constants.baseURL)Lookup/WhenMedicationTaken_get_all"
        case .getDoctors:
            return "\(Constants.baseURL)BusinessProviderEmployee/GetAllDoctors"
        case .speciality:
            return "\(Constants.baseURL)Lookup/Speciality_get_all"
        case .BusinessProvider:
            return "\(Constants.baseURL)BusinessProvider/BusinessProvider_GetAll"
        case .employePermision(let id):
            return "\(Constants.baseURL)BusinessProviderEmployee/GetAllEntityDoctor?EntityId=\(id)"
        case .home:
            return "\(Constants.baseURL)Patient/getPatientHome"
        case .PrefixTitle:
            return "\(Constants.baseURL)Lookup/PrefixTilte_get_all"
        case .professionalTitle:
            return "\(Constants.baseURL)Lookup/ProfisionalDetail_get_all"
        case .mainSpeciality:
            return "\(Constants.baseURL)Lookup/Speciality_get_all"
        case .medicalServices(id: let id):
            return "\(Constants.baseURL)Lookup/MedicalService_get_by_Speciality?ID=\(id)"
        case .doctorSearch:
            return "\(Constants.baseURL)Patient/DoctorSearch"
        case .doctorById(id: let id):
            return "\(Constants.baseURL)Patient/Get_Full_doctor_id?Id=\(id)"
        case .branchAvailableTime:
            return "\(Constants.baseURL)Patient/getBranchAvalibleTime"
        case .walletBalance:
            return "\(Constants.baseURL)Patient/getWaletBalance"
        case .doctorreviews(id: let id):
            return "\(Constants.baseURL)Patient/getDoctorReviews?Doctor_id=\(id)"
        case .addBooking:
            return "\(Constants.baseURL)Patient/AddBooking"
        case .consultationLog:
            return "\(Constants.baseURL)Patient/BookingSearch"
        case .consultationDetails(id: let id):
            return "\(Constants.baseURL)Patient/BookingSummery?Booking_id=\(id)"
        case .AppointmentHistory(_):
            return "\(Constants.baseURL)Patient/BookingSearch"
        case .GetFavouriteDoctor:
            return "\(Constants.baseURL)Patient/getFavouritDoctors"
        case .AppointmentReview(params: _):
            return "\(Constants.baseURL)Patient/SaveReview"
        case .AddFavouriteDoctor(let id):
            return "\(Constants.baseURL)Patient/SavefavoriteDoctor?DoctorID=\(id)"
        case .RemoveFavouriteDoctor(let id):
            return "\(Constants.baseURL)Patient/DeletefavoriteDoctorByDoctorID?DoctorID=\(id)"

        case .AppointmentsDetailsCancel(let bookingid):
            let url = "\(Constants.baseURL)\("Patient/GetBookingOrPlanDetails?BookingID=")\(bookingid)\("&type=1")"
            return url
        case .cancelAppointment:
            return "\(Constants.baseURL)Patient/CancelBooking_by_patient"

        case .logout(_):
            return "\(Constants.baseURL)Common/Logout"
        case .forgetPass:
           return "\(Constants.baseURL)Common/ForgetPassword"
        case .notificationList:
            return "\(Constants.baseURL)Patient/GetNotificationList"
        case .readAllNotifications:
            return "\(Constants.baseURL)Patient/MarkAsReadAllNotification"
        case .deleteAllNotification:
            return "\(Constants.baseURL)Patient/DeleteAllNotification"
        case .deleteNotification(let notificationId):
            let url = "\(Constants.baseURL)\("Patient/DeleteNotification?NotificationID=")\(notificationId)"
            return url
        case .readNotification(let notificationId):
            let url = "\(Constants.baseURL)\("Patient/MarkAsReadNotification?NotificationID=")\(notificationId)"
            return url
        case .notificationCount:
            return "\(Constants.baseURL)Patient/GetNotReadNotificationCount"
        case.faq:
            return "\(Constants.baseURL)Common/Gethelpsupport"
        case.saveContactUs:
            return "\(Constants.baseURL)Common/SaveContactUs"
        case.getFullWebPages:
            return "\(Constants.baseURL)Common/GetFullWebPages"
        case.bookingReport:
            return "\(Constants.baseURL)Patient/SearchBookingReport"
        case.reportServiceList:
            return "\(Constants.baseURL)Patient/GetServicesList"
        case.reportBranchList:
            return "\(Constants.baseURL)Patient/GetDoctorList"
        }
    }
    var parameters : Parameters?{
        switch self {
        case .login(let params):
            return params
        case .externallogin(let params):
            return params
        case .checkEmail(let params):
            return params
        case .profile, .GetAdress, .DeleteMedication(_),.getAllMedicine, .deleteFamilyHistory(_), .getDieseases,.getEmergency,.EntityType, .employePermision(_):
            return nil
        case .home:
            return nil
        case .register(let params):
            return params
        case .deleteAdress(let params):
            return params
        case .addAllergies(let params):
            return params
        case .deleAllergies(_), .deleteDieses(_),.deleteSurgery(_),.deleteMedical(_), .getBlodGroub, .getRelations,.MaritalStatus, .diesesStatus, .uploadImage, .speciality, .BusinessProvider:
            return nil
        case .addDieseas(let params):
            return params
        case .codeVerfication(let params):
            return params
        case .resendCode(let params):
            return params
        case .getAllCountries, .whenMedication:
            return nil
        case .addNewAddress(let params):
            return params
        case .mainAddress(let params):
            return params
        case .DeleteContact(let params):
            return params
        case .AddEmergency(let params):
            return params
        case .addSocialHistory(let params):
            return params
        case .addSurgery(let params):
            return params
        case .addMedicalReport(let params):
            return params
        case .editProfile(let params):
            return params
        case.changePassword(let params):
            return params
        case .permission(let params):
            return params
        case .addFamily(let params):
            return params
        case .AddMedication(let params):
            return params
        case  .getDoctors(let params):
            return params
        case .PrefixTitle, .professionalTitle, .mainSpeciality, .medicalServices:
            return nil
        case .doctorSearch(parameters: let para):
            return para
        case.doctorById:
            return nil
        case .branchAvailableTime(parameters: let para):
            return para
        case .walletBalance:
            return nil
        case .doctorreviews:
            return nil
        case .addBooking(parameters: let para):
            return para
        case .consultationLog(parameters: let para):
            return para
        case .consultationDetails:
            return nil
        case .AppointmentHistory(let params):
            return params
        case .GetFavouriteDoctor:
            return nil
        case .AppointmentReview(let params):
            return params
        case .AddFavouriteDoctor(_):
            return nil
        case .RemoveFavouriteDoctor(_):
            return nil
        case .AppointmentsDetailsCancel(_):
            return nil
        case .cancelAppointment(params: let para):
            return para
        case .logout(let params):
            return params
        case .forgetPass(params: let params):
            return params
        case .notificationList:
            return nil
        case .readAllNotifications:
            return nil
        case .deleteAllNotification:
            return nil
        case .deleteNotification(_):
            return nil
        case .readNotification(_):
            return nil
            
        case .notificationCount:
            return nil
        case.faq:
            return nil
        case.saveContactUs(params: let para):
            return para
        case.getFullWebPages:
            return nil
        case.bookingReport(params: let para):
            return para
        case.reportServiceList:
            return nil
        case.reportBranchList:
            return nil
        }
    }
    var apiToken : String {
        return UserDefaults.standard.object(forKey: "token") as! String
    }
    func asURLRequest () throws -> URLRequest{
        let url = try Constants.baseURL.asURL().appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.setValue(ContentType.accept.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        urlRequest.setValue(ContentType.apiRapidKey.rawValue, forHTTPHeaderField: HTTPHeaderField.apiRapidKey.rawValue)
        
        if apiToken != ""{
            urlRequest.setValue("Bearer \(apiToken)", forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        }
        if let parameters = parameters {
            return try JSONEncoding.default.encode(urlRequest, withJSONObject: parameters)

        }
        return urlRequest
    }
}
