//
//  loginNetwork.swift
//  E4 Patient
//
//  Created by mohab on 25/02/2021.
//

import Foundation
import UIKit
extension LoginVC{
    func validationinput(){
        let phoneString = phoneTxt.text ?? ""
        let phoneArray = Array(phoneString)
        
//        if agree == false {
//            self.showMessage(title: "", sub: "You should agree on terms and conditions.", type: .error, layout: .messageView)
//            return
//        }
        if phoneTxt.text!.isEmpty || passwordTxt.text!.isEmpty {
            self.showMessage(title: "", sub: "phone and passworrd are required".localized, type: .error, layout: .messageView)
        }else if phoneArray.count > 15 {
            self.showMessage(title: "", sub: "phone accept 15 number max".localized, type: .error, layout: .messageView)
        }else{
            self.loginBtn.startAnimation()
            callApi()
        }
    }
    func callApi(){
        let deviceId = UIDevice.current.identifierForVendor!.uuidString
        let prefix = "+20"
                guard phoneTxt.text!.hasPrefix(prefix) else { return }
                let phoneWithoutPref  = String(phoneTxt.text!.dropFirst(prefix.count).trimmingCharacters(in: .whitespacesAndNewlines))
        let parameters: [String: Any] = [
            "Username": phoneWithoutPref,
            "Password": passwordTxt.text ?? "",
            "RememberMe": true,
            "PatientMobileCode": self.digitalCountryCode,
            "Decvice_id": deviceId,
            "Device_type": 0,
            "Device_token": deviceId,
            "UserType": 2
          ]
        
        NetworkClient.performRequest(_type: User.self, router: .login(params: parameters)) { (result) in
            switch result{
            case .success(let model):
                print(model)
                if model.apiresponseresult.successtate == 200{
                    let defaults = UserDefaults.standard
                    defaults.set(model.token, forKey: "token")
                    defaults.set(model.apiresponseresult.message.patientID, forKey: "patientId")
                    defaults.synchronize()
                    self.successLogin()
                }else{
                    self.showMessage(title: "", sub: model.apiresponseresult.errormessage, type: .error, layout: .messageView)
                    self.loginBtn.stopAnimation()
                }
            case .failure(let model):
                self.loginBtn.stopAnimation()
                self.showMessage(title: "", sub: "error connecting to server. please try again", type: .error, layout: .messageView)
                print("failure: \(model)")
            
            }
        }
    }
    func successLogin(){
        self.loginBtn.stopAnimation()
        let vc = TabbarManager()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    func registerClick(){
        let vc = SignUpVC()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.show(vc, sender: nil)
    }
    func forgetPassClick(){
        let vc = ForgetPassVC()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.show(vc, sender: nil)
    }
    func checkEmailApi(){
        self.loginBtn.startAnimation()
        NetworkClient.performRequest(_type: SuccessBoolModel.self, router: .checkEmail(email: socialEmail)) { (result) in
            switch result{
            case .success(let model):
                print(model)
                if model.message == true{
                    self.callExternalApi()
                }else{
                    self.loginBtn.stopAnimation()
                    let vc = SocialPhoneVC()
                    vc.socialName = self.socialName
                    vc.socialImage = self.socialImage
                    vc.socialEmail = self.socialEmail
                    vc.socialPhone = self.socialPhone
                    vc.socialUserName = self.socialUserName
                    vc.social_id = self.social_id
                    
                     vc.modalPresentationStyle = .overCurrentContext
                     vc.modalTransitionStyle = .crossDissolve
                     self.present(vc, animated: true, completion: nil)
                }
            case .failure(let model):
                self.loginBtn.stopAnimation()
                self.showMessage(title: "", sub: "error connecting to server. please try again", type: .error, layout: .messageView)
                print("failure: \(model)")
            
            }
        }
    }
    func callExternalApi(){
        let prefix = "+20"
//                guard phoneTxt.text!.hasPrefix(prefix) else { return }
//                let phoneWithoutPref  = String(phoneTxt.text!.dropFirst(prefix.count).trimmingCharacters(in: .whitespacesAndNewlines))
        let parameters: [String: Any] = [
            "Email": socialEmail,
//            "mobile": passwordTxt.text ?? "",
//            "patientMobileCode": self.digitalCountryCode,
            "LoginProvider": social_id,
            "ProviderKey": socialName,
//            "PatientName": socialUserName,
//            "UserType": 2
          ]
        
        NetworkClient.performRequest(_type: User.self, router: .externallogin(params: parameters)) { (result) in
            switch result{
            case .success(let model):
                print(model)
                if model.apiresponseresult.successtate == 200{
                    let defaults = UserDefaults.standard
                    defaults.set(model.token, forKey: "token")
                    defaults.set(model.apiresponseresult.message.patientID, forKey: "patientId")
                    defaults.synchronize()
                    self.successLogin()
                }else{
                    self.showMessage(title: "", sub: model.apiresponseresult.errormessage, type: .error, layout: .messageView)
                    self.loginBtn.stopAnimation()
                }
            case .failure(let model):
                self.loginBtn.stopAnimation()
                self.showMessage(title: "", sub: "error connecting to server. please try again", type: .error, layout: .messageView)
                print("failure: \(model)")
            
            }
        }
    }
    
    func getPolicyData() {
        NetworkClient.performRequest(_type: WebPagesModel.self, router: .getFullWebPages) {[weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let model) :
                if model.successtate == 200 {
                    self.webPagesData = model.message
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
