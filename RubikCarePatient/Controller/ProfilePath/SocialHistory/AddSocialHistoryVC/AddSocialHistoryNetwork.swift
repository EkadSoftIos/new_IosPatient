//
//  AddSocialHistoryNetwork.swift
//  E4 Patient
//
//  Created by mohab on 06/03/2021.
//

import UIKit

extension AddSocialHistoryVC{
    func validationinput(){
        if jobTxt.text!.isEmpty || educationTxt.text!.isEmpty || maritalStatusTxt.text!.isEmpty || childrenTxt.text!.isEmpty  || generalDietTxt.text!.isEmpty || exercideTxt.text!.isEmpty  {
            self.showMessage(title: "", sub: "all data required", type: .error, layout: .messageView)
        }else{
            saveBtn.startAnimation()
            callApi()
        }
    }
    func callApi(){

        let parameters: [String: Any]
        if model?.message?.tblPatientSocialHistory?.count != 0{
            parameters = [
                "PatientSocialHistoryId": model?.message?.tblPatientSocialHistory?[0].patientSocialHistoryID ?? 0,
                "PatientFk": model?.message?.patientID ?? 0,
                "Job": jobTxt.text ?? "",
                "Education": educationTxt.text ?? "",
                  "IsSmoke": isSmoking,
                  "AlcoholConsumption": isAlcohol,
                  "MaritalStatusFk": maritalID ?? 0,
                "ChilderenNum": childrenTxt.text ?? "",
                "GeneralDite": generalDietTxt.text ?? "",
                "Exercise": exercideTxt.text ?? ""
            ]
        }else{
            parameters = [
                "PatientFk": model?.message?.patientID ?? 0,
                "Job": jobTxt.text ?? "",
                "Education": educationTxt.text ?? "",
                  "IsSmoke": isSmoking,
                  "AlcoholConsumption": isAlcohol,
                  "MaritalStatusFk": maritalID ?? 0,
                "ChilderenNum": childrenTxt.text ?? "",
                "GeneralDite": generalDietTxt.text ?? "",
                "Exercise": exercideTxt.text ?? ""
            ]
            
        }

        NetworkClient.performRequest(_type: SuccessModel.self, router: .addSocialHistory(params: parameters)) { (result) in
            self.saveBtn.stopAnimation()
            switch result{
            case .success(let model):
                if model.successtate == 200{
                    self.showMessage(title: "", sub: model.message, type: .success, layout: .messageView)
                    self.successAdd()
                    Vibration.success.vibrate()
                }else{
                    self.showMessage(title: "", sub: model.errormessage, type: .error, layout: .messageView)
                }
            case .failure(let model):
                print("failure: \(model)")
            
            }
        }
    }
    func successAdd(){
        self.navigationController?.popViewController(animated: true)
    }
    func getMarital() {
        showUniversalLoadingView(true)
        NetworkClient.performRequest(_type: MaritalStatusModel.self, router: .MaritalStatus) { [weak self] (result) in
            guard let self = self else {return}
            showUniversalLoadingView(false)
            
            switch result {
            case .success(let model) :
                if model.successtate == 200 {
                    self.maritalModel = model
                    for i in model.message {
                        if self.maritalID == i.maritalStatusID{
                            self.maritalStatusTxt.text = i.nameLocalized
                        }
                    }
                    self.updateRelationUI()
                }
                else{
                    self.showAlertWith(msg: model.errormessage )
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    func updateRelationUI() {
        maritalPickerView.reloadComponent(0)
     
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

