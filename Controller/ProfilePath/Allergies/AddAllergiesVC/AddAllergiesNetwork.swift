//
//  AddAllergiesNetwork.swift
//  E4 Patient
//
//  Created by mohab on 27/02/2021.
//

import UIKit
extension AddAllergiesVC{
    func validationinput(){
        if nameTxt.text!.isEmpty  {
            self.showMessage(title: "", sub: "allergies required", type: .error, layout: .messageView
            )
        }else{
            saveBtn.startAnimation()
            callApi()
        }
    }
    func callApi(){
//        "PatientAllergiesId": 0,
        let parameters: [String: Any]
        if isUpdate == true {
            parameters  = [
                "PatientAllergiesId": updateData?.patientAllergiesID ?? 0,
                "PatientFk": updateData?.patientFk ?? 0,
                "AllergiesName": nameTxt.text ?? "",
                "AllergiesTriggeredBy": triggeredTxt.text ?? "",
                "AllergiesOccuered": howTxt.text ?? "",
                "AllergiesFiristDiagonsed": firstTxt.text ?? "",
                "MedicationIds": medicationID ?? 0,
                "Notes": addtionalTxt.text ?? "",
                "CreateDate": "",
                "IsActive": true,
                "Deleted": true
            ]
        }else{
            parameters  = [
                "PatientFk": updateData?.patientFk ?? 0,
                "AllergiesName": nameTxt.text ?? "",
                "AllergiesTriggeredBy": triggeredTxt.text ?? "",
                "AllergiesOccuered": howTxt.text ?? "",
                "AllergiesFiristDiagonsed": firstTxt.text ?? "",
                "MedicationIds": medicationID ?? 0,
                "Notes": addtionalTxt.text ?? "",
                "CreateDate": "",
                "IsActive": true,
                "Deleted": true
            ]
        }
        
        NetworkClient.performRequest(_type: SuccessModel.self, router: .addAllergies(params: parameters)) { (result) in
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
    func getMedication() {
        showUniversalLoadingView(true)
        NetworkClient.performRequest(_type: getAllMedicineModel.self, router: .getAllMedicine) { [weak self] (result) in
            guard let self = self else {return}
            showUniversalLoadingView(false)
            
            switch result {
            case .success(let model) :
                if model.successtate == 200 {
                    self.medicationModel = model
                    self.updateRelationUI()
                    for i in model.message ?? [] {
                        if Int(self.updateData?.medicationIDS ?? "0") == i.medicationID{
                            self.medicationTxt.text = i.medicationName
                        }
                    }
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
    func createDoneBtn (for textField : UITextField)
    {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action:#selector(donePressedOfPickerView))
        toolbar.setItems([done], animated: true)
        textField.inputAccessoryView = toolbar
    }
    @objc func donePressedOfPickerView()
    {
        self.view.endEditing(true)
    }
}
