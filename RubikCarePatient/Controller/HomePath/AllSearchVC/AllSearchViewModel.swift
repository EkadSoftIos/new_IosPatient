//
//  AllSearchViewModel.swift
//  E4 Patient
//
//  Created by Nada on 8/14/21.
//

import Foundation

protocol AllSearchViewModelProtocol {
    func getAllDoctor()
    func filterDoctors(ConsultationServiceId: Int?, date: String?, medicalArray: [Int]?, subServiceArray: [Int]?, mainSpecialityId: Int?, gender: Int?, toPrice: String?, fromPrice: String?, allowCancellation: Bool?, prefixIdArray: [Int]?, professionalIdArray: [Int]?, sortType: Int?, lat: String?, lng: String?, cityId: Int?, areaId: Int?)
}

class AllSearchViewModel {
    
    var doctorSearch = [DoctorDataForAPI]()
    var filteredDoctors = [DoctorDataForAPI]()
    
    var filteredDoctorsearch = [DoctorSearchData]()
    var filterDoctors = [DoctorSearchData]()
    let showError = Observable<String>(value: "")
    let isLoading = Observable<Bool>(value: false)
    let reloadDoctorSearchTB = Observable<Bool>(value: false)
    
}
extension AllSearchViewModel: AllSearchViewModelProtocol {
    func getAllDoctor() {
        self.isLoading.value = true
        NetworkClient.performRequest(_type: HomeModel.self, router: .home) {[weak self] (result) in
            guard let self = self else {return}
            self.isLoading.value = false
            switch result{
            case .success(let model):
                print(model)
                if model.successtate == 200{
                    self.doctorSearch = model.message?.doctorDataForAPI ?? []
                    self.filteredDoctors = self.doctorSearch
                    self.reloadDoctorSearchTB.value = true
                }else{
                    self.showError.value = model.errormessage ?? ""
                }
            case .failure(let err):
                self.showError.value = err.localizedDescription
            
            }
        }
    }
    func filterDoctors(ConsultationServiceId: Int?, date: String?, medicalArray: [Int]?, subServiceArray: [Int]?, mainSpecialityId: Int?, gender: Int?, toPrice: String?, fromPrice: String?, allowCancellation: Bool?, prefixIdArray: [Int]?, professionalIdArray: [Int]?, sortType: Int?, lat: String?, lng: String?, cityId: Int?, areaId: Int?) {
        var para: [String: Any] = [:]
        if date != nil {
            para["AvilableDate"] = date
        }
        if medicalArray?.count != 0 {
            para["MedicalServiceId_list"] = medicalArray
        }
        if subServiceArray?.count != 0 {
            para["SubSpecialityId_list"] = subServiceArray
        }
        if mainSpecialityId != nil {
            para["MainSpecialityID"] = mainSpecialityId
        }
        if gender != nil {
            para["Gender"] = gender
        }
        if toPrice != nil {
            para["ConsultationServiceFees_to"] = toPrice
        }
        if fromPrice != nil {
            para["ConsultationServiceFees_from"] = fromPrice
        }
        if allowCancellation != nil {
            para["AllowFreeCancelation"] = allowCancellation
        }
        if prefixIdArray?.count != 0 {
            para["PrefixTitleFkList"] = prefixIdArray
        }
        if professionalIdArray?.count != 0 {
            para["ProfessionalDetailIds"] = professionalIdArray
        }
        if sortType != nil {
            para["sortType"] = sortType
        }
        if lat != nil && lng != nil {
            para["Latitude"] = lat
            para["Longitude"] = lng
            para["distance"] = 10
        }
        if areaId != nil {
            para["AreaId"] = areaId
        }
        if cityId != nil {
            para["CityId"] = cityId
        }
        if ConsultationServiceId != nil {
            para["ConsultationServiceId"] = ConsultationServiceId
        }
        
        print(para)
        self.isLoading.value = true
        NetworkClient.performRequest(_type: DoctorSearchModel.self, router: .doctorSearch(parameters: para)) {[weak self] (result) in
            guard let self = self else { return }
            self.isLoading.value = false
            switch result {
            case.success(let data):
                print(data)
                self.filterDoctors = data.message ?? []
                self.filteredDoctorsearch = self.filterDoctors
                self.reloadDoctorSearchTB.value = true
            case.failure(let err):
                self.showError.value = err.localizedDescription
            }
        }
    }
}
