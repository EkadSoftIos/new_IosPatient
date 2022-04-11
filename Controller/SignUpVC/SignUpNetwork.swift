//
//  SignUpNetwork.swift
//  E4 Patient
//
//  Created by mohab on 25/02/2021.
//

import UIKit

extension SignUpVC{
    func setUppicker(){
//        if #available(iOS 14.0, *)
//        {
//            datePicker.preferredDatePickerStyle = .wheels
//        }
        self.genderTxt.inputView = self.pickerView
        self.genderTxt.inputAccessoryView = self.pickerView.toolbar
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        self.pickerView.toolbarDelegate = self
        self.pickerView.reloadAllComponents()
    }
    func validationinput(){
        if phoneTxt.text!.isEmpty || lastNameTxt.text!.isEmpty || fNameTxt.text!.isEmpty || passwordTxt.text!.isEmpty || genderTxt.text!.isEmpty || dateTxt.text!.isEmpty  {
            self.showMessage(title: "", sub: "all data are required".localized, type: .error, layout: .messageView)
        }else if isEmailValid(emailTxt.text!) == false{

        }else if passwordTxt.text!.count < 8{
            self.showMessage(title: "", sub: "password must  be atleast 8 numbers".localized, type: .error, layout: .messageView)
        }else if isPasswordValid(passwordTxt.text!) == false{
            self.showMessage(title: "", sub: "Password must contain letters and numbers", type: .error, layout: .messageView)
        }else if passwordTxt.text != confPasswordTxt.text{
            self.showMessage(title: "", sub: "Password don't match", type: .error, layout: .messageView)
        }else{
            self.createAccountBtn.startAnimation()
            callApi()
        }
    }
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    func callApi(){
        let parameters: [String: Any] = [
            "PhoneCode": "+2",
            "BirthDate": dateTxt.text ?? "",
            "countryID": 1,
            "email": emailTxt.text ?? "",
            "firstName": fNameTxt.text ?? "",
            "Gender": genderType ?? 0,
            "lastName": lastNameTxt.text ?? "",
            "mobile": phoneTxt.text ?? "",
            "password": passwordTxt.text ?? "",
            "personal_image": profileImagePath
          ]
        print("params: \(parameters)")
        NetworkClient.performRequest(_type: RegisterModel.self, router: .register(params: parameters)) {[weak self] (result) in
            guard let self = self else {return}
            switch result{
            case .success(let model):
                print("\(model)")
                self.createAccountBtn.stopAnimation()
                if let error = model.errormessage {
                    self.showAlertWith(msg: error)
                }
                else {
                    let vc = ConfirmAccountVC()
                    vc.modalPresentationStyle = .fullScreen
                    vc.codeMessage = model.message
                    vc.email = self.emailTxt.text!
                    vc.phone = self.phoneTxt.text!
                    self.present(vc, animated: true, completion: nil)
                }
            case .failure(let model):
                self.createAccountBtn.stopAnimation()
                self.showMessage(title: "", sub: "error connecting to server. please try again", type: .error, layout: .messageView)
                print("failure: \(model)")
            }
        }
    }
    func ProfileImageNetwork(result : ServerResponse<SuccessModelImage>){
        switch result {
        case .success(let model):
            if model.successtate == 200 {
                self.profileImagePath = model.message ?? ""
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
}
