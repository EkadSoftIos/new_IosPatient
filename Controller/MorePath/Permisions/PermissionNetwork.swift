//
//  PermissionNetwork.swift
//  E4 Patient
//
//  Created by mohab on 07/03/2021.
//

import Foundation
extension PermissionVC {
    
    func callApi(){
        savebtn.startAnimation()
        let parameters: [String: Any]

        if Model?.message?.tblPatientProfilePermition?.count != 0{
            parameters = [
                "PatientProfilePermitionId":Model?.message?.tblPatientProfilePermition?[0].patientProfilePermitionID ?? 0,
                "PatientFk": Model?.message?.patientID ?? 0,
                "ForAllDoctors": ForAllDoctors,
                "DoctorIds": healthCareTxt.text ?? "",
                "ShowPersonalDetails":  showpersonal ,
                //"ShowAddress": ShowAddress,
                "ShowEmergencyContact": ShowEmergencyContact,
                "ShowDisease": ShowDisease,
                "ShowMedication": ShowMedication,
                "ShowAllergies": ShowAllergies,
                "ShowSocialHistory": ShowSocialHistory,
                "ShowSocialFamily": ShowSocialFamily,
                "ShowSurgery": ShowSurgery,
                "ShowMedicalReport": ShowAddress
            ]
        }else{
            parameters  = [
                "PatientFk": Model?.message?.patientID ?? 0,
                "ForAllDoctors": ForAllDoctors,
                "DoctorIds": healthCareTxt.text ?? "",
                "ShowPersonalDetails":  showpersonal ,
               // "ShowAddress": ShowAddress,
                "ShowEmergencyContact": ShowEmergencyContact,
                "ShowDisease": ShowDisease,
                "ShowMedication": ShowMedication,
                "ShowAllergies": ShowAllergies,
                "ShowSocialHistory": ShowSocialHistory,
                "ShowSocialFamily": ShowSocialFamily,
                "ShowSurgery": ShowSurgery,
                "ShowMedicalReport": ShowAddress
            ]
        }
        
        NetworkClient.performRequest(_type: SuccessModel.self, router: .permission(params: parameters)) { (result) in
            self.savebtn.stopAnimation()
            switch result{
            case .success(let model):
                self.savebtn.stopAnimation()
                if model.successtate == 200{
                    Vibration.success.vibrate()
                    self.showMessage(title: "", sub: model.message, type: .success, layout: .messageView)
                    self.navigationController?.popViewController(animated: true)
                }else{
                    self.savebtn.stopAnimation()
                    self.showMessage(title: "", sub: model.errormessage, type: .error, layout: .messageView)
                }
            case .failure(let model):
                self.savebtn.stopAnimation()
                print("failure: \(model)")
            
            }
        }
    }
    func callApigetEntity(){
        showUniversalLoadingView(true)
        NetworkClient.performRequest(_type: BusinessProviderModel.self, router: .BusinessProvider) { (result) in
            showUniversalLoadingView(false)
            switch result{
            case .success(let model):
                if model.successtate == 200 {
                    print("\(model)")
                    self.entityModel = model
                    
                }else{
                    self.showMessage(sub: model.errormessage)
                }
            case .failure(let model):
                print(model)
                self.showMessage(title: "", sub: "error connecting to server. please try again", type: .error, layout: .messageView)
            }
        }
    }
    func callApispeciality(){
        showUniversalLoadingView(true)
        NetworkClient.performRequest(_type: GetspecialityModel.self, router: .speciality) { (result) in
            showUniversalLoadingView(false)
            switch result{
            case .success(let model):
                if model.successtate == 200 {
                    print("\(model)")
                    self.specialityModel = model
                    
                }else{
                    self.showMessage(sub: model.errormessage)
                }
            case .failure(let model):
                print(model)
                self.showMessage(title: "", sub: "error connecting to server. please try again", type: .error, layout: .messageView)
            }
        }
    }
    func callApisbussinesId(id: Int){
        showUniversalLoadingView(true)
        NetworkClient.performRequest(_type: BusinessProvideremployeModel.self, router: .employePermision(id: id)) { (result) in
            showUniversalLoadingView(false)
            switch result{
            case .success(let model):
                if model.successtate == 200 {
                    print("\(model)")
                    self.doctorModel = model
 
                }else{
                    self.showMessage(sub: model.errormessage)
                }
            case .failure(let model):
                print(model)
                self.showMessage(title: "", sub: "error connecting to server. please try again", type: .error, layout: .messageView)
            }
        }
    }
    func getDoctors() {
        NetworkClient.performRequest(_type: GetDoctorsModel.self, router: .getDoctors(params: ["": ""])) { [weak self] (result) in
            guard let self = self else {return}
            showUniversalLoadingView(false)
            
            switch result {
            case .success(let model) :
                if model.successtate == 200 {
                    self.allDoctorsModel = model
                   /* for healthId in self.helthArr {
                        for id in model.message {
                            if healthId == id.businessProviderEmployeeID{
                                self.healthCareTxt.text = "\(self.healthCareTxt.text ?? ""), \(id.employeeName)"
                            }
                        }
                    }*/
                    self.setUpText()
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
