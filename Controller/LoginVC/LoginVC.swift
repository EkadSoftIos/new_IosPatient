//
//  LoginVC.swift
//  E4 Patient
//
//  Created by mohab on 16/01/2021.
//

import UIKit
import SKCountryPicker
import TransitionButton
class LoginVC: UIViewController {
    
    var agree = false
    
    @IBOutlet weak var agreeBtn: UIButton!
    @IBOutlet var mainView: UIView!
    @IBOutlet var countryImage: UIImageView!
    @IBOutlet var countryNameLbl: UILabel!
    @IBOutlet var phoneTxt: UITextField!
    @IBOutlet var passwordTxt: UITextField!
    @IBOutlet var loginBtn: TransitionButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.ShadowView(view: mainView, radius: 20, opacity: 0.4, shadowRadius: 4, color: UIColor.black.cgColor)
        agreeBtn.layer.cornerRadius = 7
        agreeBtn.layer.borderColor = #colorLiteral(red: 0.07058823529, green: 0.4666666667, blue: 0.8196078431, alpha: 1)
        agreeBtn.layer.borderWidth = 1
    }
    @IBAction func agreeBtnPressed(_ sender: Any) {
        agree = !agree
        if agree {
            agreeBtn.layer.cornerRadius = 7
            agreeBtn.layer.borderColor = #colorLiteral(red: 0.07058823529, green: 0.4666666667, blue: 0.8196078431, alpha: 1)
            agreeBtn.layer.borderWidth = 1
            agreeBtn.backgroundColor = #colorLiteral(red: 0.07058823529, green: 0.4666666667, blue: 0.8196078431, alpha: 1)
        } else {
            agreeBtn.layer.cornerRadius = 7
            agreeBtn.layer.borderColor = #colorLiteral(red: 0.07058823529, green: 0.4666666667, blue: 0.8196078431, alpha: 1)
            agreeBtn.layer.borderWidth = 1
            agreeBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    @IBAction func chooseCountry_Click(_ sender: Any) {
        let countryController = CountryPickerWithSectionViewController.presentController(on: self) { [weak self] (country: Country) in
            guard let self = self else { return }
            self.countryImage.image = country.flag
            self.countryNameLbl.text = country.countryCode
            self.phoneTxt.placeholder = "\("+")\(country.digitCountrycode)"
        }
//        countryController.detailColor = UIColor.blue
    }
    @IBAction func login_Click(_ sender: Any) {
        validationinput()
    }
    @IBAction func register_Click(_ sender: Any) {
            registerClick()
        }
    @IBAction func ForgetPass_Click(_ sender: Any) {
            forgetPassClick()
        }
    @IBAction func ShowPass_Click(_ sender: Any) {
        if passwordTxt.isSecureTextEntry == false {
            passwordTxt.isSecureTextEntry = true
        }else{
            passwordTxt.isSecureTextEntry = false
        }
        
    }
}
