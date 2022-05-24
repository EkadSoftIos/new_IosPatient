//
//  AddSurgeryNetwork.swift
//  E4 Patient
//
//  Created by mohab on 06/03/2021.
//

import Foundation
extension AddSurgeryVC{
    func validationinput(){
        if nameTxt.text!.isEmpty || dateTxt.text!.isEmpty {
            self.showMessage(title: "", sub: "Name and Date Required", type: .error, layout: .messageView)
        }else{
            saveBtn.startAnimation()
            callApi()
        }
    }

    func callApi(){
        var parameters = [String: Any]()
        if isUpdate == false{
             parameters = [
    //            "PatientSurgeryId": SurgeryData?.patientSurgeryID ?? 0,
                "PatientFk": UserDefaults.standard.integer(forKey: "patientId") ,
                "PatientSurgeryName": nameTxt.text ?? "",
                "AddingData": implantsTxt.text ?? "",
                "PatientSurgeryDate": dateTxt.text ?? "",
                "DoctorName": searchBar.text ?? "",
                "Notes": notesTxt.text ?? ""
           ]
        }else {
            parameters = [
               "PatientSurgeryId": SurgeryData?.patientSurgeryID ?? 0,
               "PatientFk": UserDefaults.standard.integer(forKey: "patientId"),
               "PatientSurgeryName": nameTxt.text ?? "",
               "AddingData": implantsTxt.text ?? "",
               "PatientSurgeryDate": dateTxt.text ?? "",
               "DoctorName": searchBar.text ?? "",
               "Notes": notesTxt.text ?? ""
          ]
        }
        
        print(parameters)
        NetworkClient.performRequest(_type: SuccessModel.self, router: .addSurgery(params: parameters)) { (result) in
            self.saveBtn.stopAnimation()
            switch result{
            case .success(let model):
                if model.successtate == 200{
                    self.Delegete?.Data(isAdded: true)
                    if self.isUpdate == false {
                        self.showMessage(title: "", sub: "New surgery has been added successfully ".localized, type: .success, layout: .messageView)

                    }else{
                        self.showMessage(title: "", sub: "Surgery has been edited successfully".localized, type: .success, layout: .messageView)

                    }
//                    self.showMessage(title: "", sub: model.message, type: .success, layout: .messageView)
                    self.successLogin()
                    Vibration.success.vibrate()
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
        Delegete?.Data(isAdded: true)
        self.navigationController?.popViewController(animated: true)
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
