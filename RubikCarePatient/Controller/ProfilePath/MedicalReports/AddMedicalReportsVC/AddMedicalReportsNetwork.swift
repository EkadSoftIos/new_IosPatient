//
//  AddMedicalReportsNetwork.swift
//  E4 Patient
//
//  Created by mohab on 06/03/2021.
//

import Foundation
extension AddMedicalReportsVC{
    //"PatientMedicalReportId": -78681696,
    func validationinput(){
        if nameTxt.text!.isEmpty || dateTxt.text!.isEmpty || resultTxt.text.isEmpty || notesTxt.text.isEmpty {
            self.showMessage(title: "", sub: "all data with * are required".localized, type: .error, layout: .messageView)
//        }else if attachImage == "" {
//            self.showMessage(title: "", sub: "attachment required".localized, type: .error, layout: .messageView)
        }
        else{
            saveBtn.startAnimation()
            callApi()
        }
    }

    func callApi(){
        // "MedicalReportResultFile": "string",
        let parameters: [String: Any] = [
            "PatientMedicalReportId": updateData?.patientMedicalReportID ?? 0,
            "PatientFk": model?.message?.patientID ?? 0,
            "MedicalReportName": nameTxt.text ?? "",
            "MedicalReportDate": dateTxt.text ?? "",
            "MedicalReportResult": resultTxt.text ?? "",
            "DoctorName": searchBar.text ?? "",
            "Notes": notesTxt.text ?? "",
            "MedicalReportResultFile": attachImage
          ]
        NetworkClient.performRequest(_type: SuccessModel.self, router: .addMedicalReport(params: parameters)) { (result) in
            self.saveBtn.stopAnimation()
            switch result{
            case .success(let model):
                if model.successtate == 200{
                    if self.isUpdate == false {
                        self.showMessage(title: "", sub: " New medical report has been added successfully".localized, type: .success, layout: .messageView)
                    }else{
                        self.showMessage(title: "", sub: "Medical report  has been edited successfully".localized, type: .success, layout: .messageView)
                    }
                   
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
    func ProfileImageNetwork(result : ServerResponse<SuccessModelImage>){
        switch result {
        case .success(let model):
            if model.successtate == 200 {
                print("model: \(model)")
                    self.attachImage = model.message ?? ""
            }else{
                print("model: \(model)")
                self.showMessage(title: "", sub: model.errormessage, type: .error, layout: .messageView)
            }
            break
        case .failure(let err):
            guard let err = err else {return}
            print("err: \(err)")
        }
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
