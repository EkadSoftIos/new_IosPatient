//
//  CountinueAddMedicationNetwork.swift
//  E4 Patient
//
//  Created by mohab on 09/03/2021.
//

import Foundation
import UIKit
extension CountinueAddMedicationVC{
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
    func ValidateionInput(){
        if quantityTxt.text!.isEmpty || whenTxt.text!.isEmpty || durationTxt.text!.isEmpty || FrequencyTxt.text!.isEmpty || searchBar.text!.isEmpty{
            self.showMessage(title: "", sub: "all data required".localized, type: .error, layout: .cardView)
        }else{
            self.saveBtn.startAnimation()
            callApi()
        }
    }
    func callApi(){
    var parameters: [String: Any]
        if isUpdate == true{
            parameters    = [
                "BusinessProviderEmployeeFk": doctorId,
                "DurationValue": Int(FrequencyTxt.text ?? "") ?? 0,
                "DurationType": duratiionId,
                "WhenMedicationTakenFk": whenId,
                "DoctorName": searchBar.text ?? "",
                "MedicationFk": updateData?.medicationFk ?? 0,
                "Notes": instractionsTxt.text ?? "",
                "PatientFk": model?.message?.patientID  ?? 0,
                "MedicationName": updateData?.medicationName ?? "",
                "MedicineForm": updateData?.medicineForm ?? "",
                "MedicineStrenght": updateData?.medicineStrenght ?? "",
                "PatientMedicineId": updateData?.patientMedicineID ?? 0,
                "PrescriptionFk": 0,
                "Quantity": Int(quantityTxt.text ?? "") ?? 0,
                "ShowInList": true,
                "WhenTake": whenTxt.text ?? "",
                "medicineImagePath": Medicationmodel?.medicineImagePath ?? "",
                "medicinAbout_Localized": Medicationmodel?.medicinAboutLocalized ?? "",
           ]
        }else{
           parameters = [
                "BusinessProviderEmployeeFk": doctorId,
                "DurationValue": duratiionId,
                "DurationType": duratiionId,
                "WhenMedicationTakenFk": whenId,
                "DoctorName": searchBar.text ?? "",
                "MedicationFk": Medicationmodel?.medicationID ?? 0,
                "Notes": instractionsTxt.text ?? "",
                "PatientFk": model?.message?.patientID  ?? 0,
                "MedicationName": Medicationmodel?.nameLocalized ?? "",
                "MedicineForm": Medicationmodel?.medicineForm ?? "",
                "MedicineStrenght": Medicationmodel?.strenghtValue ?? "",
                "PatientMedicineId": updateData?.patientMedicineID ?? 0,
                "PrescriptionFk": 0,
                "Quantity": Int(quantityTxt.text ?? "") ?? 0,
                "ShowInList": true,
                "WhenTake": whenTxt.text ?? "",
                "medicineImagePath": Medicationmodel?.medicineImagePath ?? "",
                "medicinAbout_Localized": Medicationmodel?.medicinAboutLocalized ?? "",
           ]
        }
        print("params:\(parameters)")
        NetworkClient.performRequest(_type: SuccessModel.self, router: .AddMedication(params: parameters)) { (result) in
        self.saveBtn.stopAnimation()
        switch result{
        case .success(let model):
            if model.successtate == 200{
                
                if self.isUpdate == false {
                    self.showMessage(title: "", sub: "New medication has been added successfully".localized, type: .success, layout: .messageView)
                }else{
                    self.showMessage(title: "", sub: "Medication has been edited successfully".localized, type: .success, layout: .messageView)
                }
                
                self.successLogin()
                print("params: \(parameters)")
            }else{
                self.showMessage(title: "", sub: model.errormessage, type: .error, layout: .messageView)
            }
        case .failure(let model):
            print("failure: \(model)")
        }
    }
}
func successLogin(){
    Delegete?.Data(isAdded: true, isupdate: self.isUpdate)
    self.navigationController?.popViewController(animated: true)
}

  
}
