//
//  AddFamilyHistoryNetwork.swift
//  E4 Patient
//
//  Created by mohab on 06/03/2021.
//

import UIKit
extension AddFamilyHistoryVC{
    func validationinput(){
        if relationTxt.text!.isEmpty  {
            self.showMessage(title: "", sub: "relation required", type: .error, layout: .messageView)
        }else{
            saveBtn.startAnimation()
            callApi()
        }
    }

    func callApi(){
        let parameters: [String: Any] = [
            "PatientSocialFamilyId": updateData?.patientSocialFamilyID ?? 0,
            "PatientFk": model?.message?.patientID ?? 0,
            "RelationFk": relationID ?? 0,
            "Notes": notesTxt.text ?? "",
          ]
        
        NetworkClient.performRequest(_type: SuccessModel.self, router: .addFamily(params: parameters)) { (result) in
            self.saveBtn.stopAnimation()
            switch result{
            case .success(let model):
                if model.successtate == 200{
                    self.Delegete?.Data(isAdded: true)
                    self.showMessage(title: "", sub: model.message, type: .success, layout: .messageView)
                    self.successLogin()
                    Vibration.success.vibrate()
                    print(parameters)
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
    func getRlations() {
        showUniversalLoadingView(true)
        NetworkClient.performRequest(_type: getRelationsModel.self, router: .getRelations) { [weak self] (result) in
            guard let self = self else {return}
            showUniversalLoadingView(false)
            
            switch result {
            case .success(let model) :
                if model.successtate == 200 {
                    self.RelationModel = model
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
        relationPickerView.reloadComponent(0)
     
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
