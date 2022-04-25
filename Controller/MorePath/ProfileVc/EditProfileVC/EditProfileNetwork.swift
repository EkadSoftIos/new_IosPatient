//
//  EditProfileNetwork.swift
//  E4 Patient
//
//  Created by mohab on 07/03/2021.
//

import Foundation
extension EditProfileVC{
    
    func validationinput(){
        if fNameTxt.text!.isEmpty || lNameTxt.text!.isEmpty || phoneTxt.text!.isEmpty || emailTxt.text!.isEmpty || genderTxt.text!.isEmpty || dateTxt.text!.isEmpty{
            self.showMessage(title: "", sub: "all data required", type: .error, layout: .messageView)
        }else if !identityTxt.text!.isEmpty && identityTxt.text!.count < 14 || identityTxt.text!.count > 14{
            self.showMessage(title: "", sub: "Identification must be 14 number".localized, type: .error, layout: .messageView)
        }else if isEmailValid(emailTxt.text ?? "") == false{
            self.showMessage(title: "", sub: "enter valid email".localized, type: .error, layout: .cardView)
        }else if birthDate?.timeIntervalSinceNow.sign == .plus {
            self.showMessage(title: "", sub: "selected date must be in past".localized, type: .error, layout: .messageView)
        }else{
            saveBtn.startAnimation()
            callApi()
        }
    }
    func ProfileImageNetwork(result : ServerResponse<SuccessModelImage>){
        switch result {
        case .success(let model):
            showUniversalLoadingView(false)
            if model.successtate == 200 {
              //  self.profileImagePath = model.message ?? ""
                print("model: \(model)")
                if isProfileImage == true {
                    self.profileImagePath = model.message ?? ""
                print("imagePath: \(model.message ?? "")")
                }else{
                    self.attachmentImagePath = model.message ?? ""
                }
            }else{
                print("model: \(model)")
                showUniversalLoadingView(false)
                self.showMessage(title: "", sub: model.errormessage, type: .error, layout: .messageView)
            }
            break
        case .failure(let err):
            showUniversalLoadingView(false)
            guard let err = err else {return}
            print("err: \(err)")
        }
    }
    func callApi(){
        var parameters: [String: Any] = [
            "PatientId": model?.message?.patientID ?? 0,
            "PatientFirstName": fNameTxt.text ?? "",
            "PatientLastName": lNameTxt.text ?? "",
            "PatientEmail": emailTxt.text ?? "",
            "PatientMobileCode": "+20",
            "PatientMobile": phoneTxt.text ?? "",
            "PatientBirthDate": dateTxt.text ?? "",
            "PatientGender": genderType ?? 1,
            "AttachedIdPath": attachmentImagePath,
            "PatientProfileImage": profileImagePath,
            "Countryid": model?.message?.countryid ?? 0
            ]
        if weightTxt.text != "" {
            parameters["PatientWeight"] = weightTxt.text ?? ""
        }
        if heightTxt.text != "" {
            parameters["PatientHeight"] = heightTxt.text ?? ""
        }
        if BlodID != 0 {
            parameters["BlodGroupFk"] = BlodID
        }
        if identityTxt.text != "" {
            parameters["PatientIdentification"] = identityTxt.text
        }
        NetworkClient.performRequest(_type: SuccessModel.self, router: .editProfile(params: parameters)) { (result) in
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
        self.Delegete?.Data(isAdded: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- get blod groub
    func getBlodGroub(){
        NetworkClient.performRequest(_type: getBloodGroubModel.self, router: .getBlodGroub) { (result) in
            switch result{
            case .success(let model):
                if model.successtate == 200{
                    self.blodModel = model
                }else{
                    self.showMessage(title: "", sub: model.errormessage, type: .error, layout: .messageView)
                }
            case .failure(let model):
                print("failure: \(model)")
            }
        }
    }
    
    
}
