//
//  ForgetPasswordVC.swift
//  E4 Patient
//
//  Created by mohab on 24/01/2021.
//

import UIKit
import TransitionButton
class ForgetPasswordVC: UIViewController {
    @IBOutlet var mainView: UIView!
    @IBOutlet var passwordTxt: UITextField!
    @IBOutlet var newPasswordTxt: UITextField!
    @IBOutlet var confirmNewPasswordTxt: UITextField!
    @IBOutlet var saveBtn: TransitionButton!
    var Model: UserDataModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.ShadowView(view: mainView, radius: 20, opacity: 0.4, shadowRadius: 4, color: UIColor.black.cgColor)
        self.navigationItem.title = "Change Password".localized
    }
    override func viewWillAppear(_ animated: Bool) {
    }
    @IBAction func save_CLick(_ sender: Any) {
        if passwordTxt.text!.isEmpty || confirmNewPasswordTxt.text!.isEmpty || newPasswordTxt.text!.isEmpty {
            self.showMessage(title: "", sub: "password required", type: .error, layout: .messageView)
        }else  if newPasswordTxt.text != confirmNewPasswordTxt.text {
            self.showMessage(title: "", sub: "password and confirm password must be  identical", type: .error, layout: .messageView)
        }else if isPasswordValid(passwordTxt.text!) == false || isPasswordValid(newPasswordTxt.text!) == false{
            self.showMessage(title: "", sub: "old and new password must contain letters and numbers", type: .error, layout: .messageView)
        }else{
            self.saveBtn.startAnimation()
            callAPI()
        }
  
        
    }
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    @IBAction func ShowCurrentPass_Click(_ sender: Any) {
        if  passwordTxt.isSecureTextEntry == false {
            passwordTxt.isSecureTextEntry = true
        }else{
            passwordTxt.isSecureTextEntry = false
        }
        
    }
    @IBAction func ShowNewPass_Click(_ sender: Any) {
        if  newPasswordTxt.isSecureTextEntry == false {
            newPasswordTxt.isSecureTextEntry = true
        }else{
            newPasswordTxt.isSecureTextEntry = false
        }
        
    }
    @IBAction func ShowConfirmPass_Click(_ sender: Any) {
        if  confirmNewPasswordTxt.isSecureTextEntry == false {
            confirmNewPasswordTxt.isSecureTextEntry = true
        }else{
            confirmNewPasswordTxt.isSecureTextEntry = false
        }
        
    }
    func callAPI(){
        let parameters: [String: Any] = [
            "oldPassword": passwordTxt.text ?? "",
            "NewPassword": newPasswordTxt.text ?? "",
            "NewPasswordConfirm": confirmNewPasswordTxt.text ?? "",
            "id": Model?.message?.patientID ?? 0,
            "Type":2
        ]
        
            NetworkClient.performRequest(_type: SuccessModel.self, router: .changePassword(params: parameters)) {[weak self] (result) in
                guard let self = self else {return}
                switch result{
                
                
                case .success(let model):
                    if model.successtate == 200{
                        self.saveBtn.startAnimation()
                        self.showMessage(title: "", sub: model.message, type: .success, layout: .messageView)
                        self.showMessage(title: "", sub: "password changed succefully", type: .success, layout: .messageView)
                        Vibration.success.vibrate()
                        self.navigationController?.popViewController(animated: true)
                       
                    }else{
                        self.saveBtn.startAnimation()
                        self.showMessage(title: "", sub: model.errormessage, type: .error, layout: .messageView)
                        
                    }
                case .failure(let model):
                    self.saveBtn.startAnimation()
                    print("failure: \(model)")
                    
                }

            }
        
    }

  
    
}

