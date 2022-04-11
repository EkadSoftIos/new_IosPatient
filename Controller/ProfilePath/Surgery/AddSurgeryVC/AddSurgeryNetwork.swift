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
        let parameters: [String: Any]  = [
            "PatientSurgeryId": SurgeryData?.patientSurgeryID ?? 0,
            "PatientFk": model?.message?.patientID ?? 0,
            "PatientSurgeryName": nameTxt.text ?? "",
            "AddingData": implantsTxt.text ?? "",
            "PatientSurgeryDate": dateTxt.text ?? "",
            "DoctorName": searchBar.text ?? "",
            "Notes": notesTxt.text ?? ""
       ]
     //   print(parameters)
        NetworkClient.performRequest(_type: SuccessModel.self, router: .addSurgery(params: parameters)) { (result) in
            self.saveBtn.stopAnimation()
            switch result{
            case .success(let model):
                if model.successtate == 200{
                    self.Delegete?.Data(isAdded: true)
                    self.showMessage(title: "", sub: model.message, type: .success, layout: .messageView)
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
