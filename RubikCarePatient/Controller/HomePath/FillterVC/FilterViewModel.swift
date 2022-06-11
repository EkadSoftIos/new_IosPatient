//
//  FilterViewModel.swift
//  E4 Patient
//
//  Created by Nada on 8/12/21.
//

import Foundation

protocol FilterViewModelProtocol {
    func getPrefixTitle()
    func getProfessionalTitle()
    func getMainSpeciality()
    func getMedicalServices(id: Int)
}

class FilterViewModel: FilterViewModelProtocol {
    
    var prefixTitle: PrefixtitleModel?
    var professionaltitle: ProfessionalTitleModel?
    var mainSpeciality: MainSpecialityModel?
    var medicalServices: MedicalServicesModel?
    let showError = Observable<String>(value: "")
    let isLoading = Observable<Bool>(value: false)
    let reloadPrefixTitleTB = Observable<Bool>(value: false)
    let reloadProfessionalTitleTB = Observable<Bool>(value: false)
    let reloadmainSpecialityTB = Observable<Bool>(value: false)
    let reloadMedicalServicesTB = Observable<Bool>(value: false)
    
    func getPrefixTitle() {
//        self.isLoading.value = true
        NetworkClient.performRequest(_type: PrefixtitleModel.self, router: .PrefixTitle) {[weak self] (result) in
            guard let self = self else {return}
            switch result {
            case.success(let data):
                self.getProfessionalTitle()
                if data.successtate == 200 {
                    self.prefixTitle = data
                    self.reloadPrefixTitleTB.value = true
                } else {
                    self.showError.value = data.errormessage ?? ""
                }
            case.failure(let err):
                self.showError.value = err.localizedDescription
            }
        }
    }
    func getProfessionalTitle() {
        NetworkClient.performRequest(_type: ProfessionalTitleModel.self, router: .professionalTitle) {[weak self] (result) in
            guard let self = self else {return}
            switch result {
            case.success(let data):
                if data.successtate == 200 {
                    self.professionaltitle = data
                    self.reloadProfessionalTitleTB.value = true
                } else {
                    self.showError.value = data.errormessage ?? ""
                }
                self.getMainSpeciality()
            case.failure(let err):
                self.showError.value = err.localizedDescription
            }
        }
    }
    func getMainSpeciality() {
        NetworkClient.performRequest(_type: MainSpecialityModel.self, router: .mainSpeciality) {[weak self] (result) in
            guard let self = self else {return}
            self.getMedicalServices(id: 6)
            switch result {
            case.success(let data):
                if data.successtate == 200 {
                    self.mainSpeciality = data
                    self.reloadmainSpecialityTB.value = true
                } else {
                    self.showError.value = data.errormessage ?? ""
                }
            case.failure(let err):
                self.showError.value = err.localizedDescription
            }
        }
    }
    func getMedicalServices(id: Int) {
        NetworkClient.performRequest(_type: MedicalServicesModel.self, router: .medicalServices(id: id)) {[weak self] (result) in
            guard let self = self else {return}
            self.isLoading.value = false
            switch result {
            case.success(let data):
                if data.successtate == 200 {
                    self.medicalServices = data
                    self.reloadMedicalServicesTB.value = true
                } else {
                    self.showError.value = data.errormessage ?? ""
                }
            case.failure(let err):
                self.showError.value = err.localizedDescription
            }
        }
    }
}
