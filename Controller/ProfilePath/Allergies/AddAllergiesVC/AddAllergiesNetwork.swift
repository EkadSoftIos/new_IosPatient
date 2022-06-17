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
            self.showMessage(title: "", sub: "Name required".localized, type: .error, layout: .messageView
            )
        }else{
            saveBtn.startAnimation()
            callApi()
        }
    }
    func callApi(){
        let patientId = UserDefaults.standard.string(forKey: "patientId")
//        "PatientAllergiesId": 0,
        let parameters: [String: Any]
        if isUpdate == true {
            parameters  = [
                "PatientAllergiesId": updateData?.patientAllergiesID ?? 0,
                "PatientFk":patientId ?? 0,
                "AllergiesName": nameTxt.text ?? "",
                "AllergiesTriggeredBy": triggeredTxt.text ?? "",
                "AllergiesOccuered": howTxt.text ?? "",
                "AllergiesFiristDiagonsed": firstTxt.text ?? "",
                "MedicationIds": medicationIDsString,
                "Notes": addtionalTxt.text ?? "",
                "CreateDate": "",
                "IsActive": true,
                "Deleted": true
            ]
        }else{
            parameters  = [
                "PatientFk": patientId ?? 0,
                "AllergiesName": nameTxt.text ?? "",
                "AllergiesTriggeredBy": triggeredTxt.text ?? "",
                "AllergiesOccuered": howTxt.text ?? "",
                "AllergiesFiristDiagonsed": firstTxt.text ?? "",
                "MedicationIds": medicationIDsString,
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
                    if self.isUpdate == false {
                        self.showMessage(title: "", sub: "New allergies have been added successfully".localized, type: .success, layout: .messageView)
                    }else{
                        self.showMessage(title: "", sub: "Allergies have been edited successfully".localized, type: .success, layout: .messageView)
                    }
                    UserDefaults.standard.set(true, forKey: "AddedAllergies")
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
                    let idString = self.updateData?.medicationIDS
                    let idArray = idString?.components(separatedBy: ",")
//                    let id = Int(self.updateData?.medicationIDS ?? "0")
                    for i in model.message ?? []{
                        for x in idArray ?? [] {
                            if Int(x) == i.medicationID {
                                if self.medicationTxt.text == "" {
                                    self.medicationTxt.text = i.medicationName
                                }else{
                                    self.medicationTxt.text = "\(self.medicationTxt.text ?? "")\(",")\(i.medicationName ?? "")"
                                }
                            }
                        }
//                        if id == i.medicationID{
//                        if idArray?.contains(i.medicationID){
//                            self.medicationTxt.text = i.medicationName
//                        }
                        
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
