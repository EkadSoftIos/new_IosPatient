//
//  ConfirmAccountVC.swift
//  E4 Patient
//
//  Created by mohab on 17/01/2021.
//

import UIKit
import TransitionButton
import SKCountryPicker


class SocialPhoneVC: UIViewController ,UITextFieldDelegate {
    @IBOutlet var mainView: UIView!
    @IBOutlet var flagImage: UIImageView!
    @IBOutlet var counntryNameLbl: UILabel!
    @IBOutlet var phoneTxt: UITextField!
    @IBOutlet var titleLB: UILabel!
    @IBOutlet var bodyLB: UILabel!
    @IBOutlet var sendBT: TransitionButton!

    var codeMessage: String?
    var phone: String?
    
    var socialName = ""
    var socialUserName = ""
    var socialEmail = ""
    var socialPassword = ""
    var social_id = ""
    var socialImage = ""
    var socialPhone = ""
    var digitalCountryCode = "+20"

    override func viewDidLoad() {
        super.viewDidLoad()
        phoneTxt.delegate = self
        mainView.ShadowView(view: mainView, radius: 20, opacity: 0.4, shadowRadius: 4, color: UIColor.black.cgColor)
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.phoneTxt.text = self.digitalCountryCode
        return true
    }

    @IBAction func goHome_CLick(_ sender: Any) {
        if phoneTxt.text == "" {
            self.showMessage(title: "", sub: "all data are required".localized, type: .error, layout: .messageView)
        }else{
            self.sendBT.startAnimation()
            callRegisterExternalApi()
        }
    }
    @IBAction func chooseCountry_Click(_ sender: Any) {
        let countryController = CountryPickerWithSectionViewController.presentController(on: self) { [weak self] (country: Country) in
          guard let self = self else { return }
          self.flagImage.image = country.flag
            self.counntryNameLbl.text = country.countryCode
            self.phoneTxt.placeholder = "\(country.dialingCode ?? "")\(" 000 00000 000")"
        }
//        countryController.detailColor = UIColor.blue
    }
    func callRegisterExternalApi(){
        let prefix = "+20"
//                guard phoneTxt.text!.hasPrefix(prefix) else { return }
//                let phoneWithoutPref  = String(phoneTxt.text!.dropFirst(prefix.count).trimmingCharacters(in: .whitespacesAndNewlines))
        let parameters: [String: Any] = [
            "Email": socialEmail,
            "mobile": phoneTxt.text ?? "",
            "patientMobileCode": "+20",
            "LoginProvider": social_id,
            "ProviderKey": socialName,
            "PatientName": socialUserName
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
                    self.sendBT.stopAnimation()
                }
            case .failure(let model):
                self.sendBT.stopAnimation()
                self.showMessage(title: "", sub: "error connecting to server. please try again", type: .error, layout: .messageView)
                print("failure: \(model)")
            
            }
        }
    }
    func successLogin(){
        self.sendBT.stopAnimation()
        let vc = TabbarManager()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
}
