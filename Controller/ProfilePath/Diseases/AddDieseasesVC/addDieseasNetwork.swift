//
//  addDieseasNetwork.swift
//  E4 Patient
//
//  Created by mohab on 27/02/2021.
//

import UIKit
extension AddDieseasesVC{
    func validationinput(){
        if dieseasNameTxt.text!.isEmpty || diagnosedTxt.text!.isEmpty || statusTxt.text!.isEmpty || searchBar.text!.isEmpty {
            self.showMessage(title: "", sub: "all data with * required", type: .error, layout: .messageView)
        }else if dianosedDate?.timeIntervalSinceNow.sign == .plus {
            self.showMessage(title: "", sub: "selected date must be in past".localized, type: .error, layout: .messageView)
        }else{
            saveBtn.startAnimation()
            callApi()
        }
    }

    func callApi(){
   
        let parameters: [String: Any] = [
            "PatientDiseaseId": updateData?.patientDiseaseID ?? 0,
            "PatientFk": model?.message?.patientID ?? 0,
            "DiseaseFk": dieseasID,
            "DiseaseStatusFk": statusID ?? 0,
            "MedicationIds": medicationTxt.text ?? "",
            "DiagonsedDate": diagnosedTxt.text ?? "",
            "Notes": notesTxt.text ?? "",
            "DoctorName": searchBar.text ?? ""
        ]
        
          
         print("params: \(parameters)")
        NetworkClient.performRequest(_type: SuccessModel.self, router: .addDieseas(params: parameters)) { (result) in
            self.saveBtn.stopAnimation()
            switch result{
            case .success(let model):
                if model.successtate == 200{
                    self.showMessage(title: "", sub: model.message, type: .success, layout: .messageView)
                    self.successLogin()
                    Vibration.success.vibrate()
                }else{
                    self.showMessage(title: "", sub: model.errormessage, type: .error, layout: .messageView)
                }
            case .failure(let model):
                print("failure: \(model)")
            
            }
        }
    }
    func successLogin(){
        Delegete?.Data(isAdded: true)
        self.navigationController?.popViewController(animated: true)
    }
    func getDieseases(){
        NetworkClient.performRequest(_type: getDieseasesModel.self, router: .getDieseases) { (result) in
            switch result{
            case .success(let model):
                if model.successtate == 200{
                    self.DieseasesModel = model
                    let id = self.updateData?.diseaseFk ?? 0
                    for i in model.message {
                        if id == i.diseaseID{
                            self.dieseasNameTxt.text = i.diseaseNameEn
                        }
                    }
                }else{
                    self.showMessage(title: "", sub: model.errormessage, type: .error, layout: .messageView)
                }
            case .failure(let model):
                print("failure: \(model)")
            }
        }
    }
    func getMedication() {
        showUniversalLoadingView(true)
        NetworkClient.performRequest(_type: getAllMedicineModel.self, router: .getAllMedicine) { [weak self] (result) in
            guard let self = self else {return}
            showUniversalLoadingView(false)
            
            switch result {
            case .success(let model) :
                if model.successtate == 200 {
                    self.medicationModel = model
                    let id = Int(self.updateData?.medicationIDS ?? "0")
                    for i in model.message ?? []{
                        if id == i.medicationID{
                            self.medicationTxt.text = i.medicationName
                        }
                    }
                    self.updateRelationUI()
                }
                else{
                    self.showAlertWith(msg: model.errormessage ?? "")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    func updateRelationUI() {
        medicationPickerView.reloadComponent(0)

    }
    func getstatus() {
        showUniversalLoadingView(true)
        NetworkClient.performRequest(_type: DiseaseStatusModel.self, router: .diesesStatus) { [weak self] (result) in
            guard let self = self else {return}
            showUniversalLoadingView(false)
            
            switch result {
            case .success(let model) :
                if model.successtate == 200 {
                    self.statusModel = model
                    self.updateUI()
                    let id = self.updateData?.diseaseStatusFk
                    for i in model.message{
                        if id == i.diseaseStatusID{
                            self.statusTxt.text = i.nameLocalized
                        }
                    }
                }
                else{
                    self.showAlertWith(msg: model.errormessage)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    func updateUI() {
        statusPickerView.reloadComponent(0)
    }
    func getDoctors() {
        NetworkClient.performRequest(_type: GetDoctorsModel.self, router: .getDoctors(params: ["": ""])) { [weak self] (result) in
            guard let self = self else {return}
            showUniversalLoadingView(false)
            
            switch result {
            case .success(let model) :
                if model.successtate == 200 {
                    self.doctorsModel = model
                }
                else{
                    self.showAlertWith(msg: model.errormessage ?? "")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
}
