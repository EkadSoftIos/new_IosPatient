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
//        if agree == false {
//            self.showMessage(title: "", sub: "You should agree on terms and conditions.", type: .error, layout: .messageView)
//            return
//        }
        if phoneTxt.text!.isEmpty || passwordTxt.text!.isEmpty {
            self.showMessage(title: "", sub: "phone and passworrd are required".localized, type: .error, layout: .messageView)
        }else{
            self.loginBtn.startAnimation()
            callApi()
        }
    }
    func callApi(){
        let deviceId = UIDevice.current.identifierForVendor!.uuidString
        let parameters: [String: Any] = [
            "Username": phoneTxt.text ?? "",
            "Password": passwordTxt.text ?? "",
            "RememberMe": true,
            "PatientMobileCode": "002",
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
}
