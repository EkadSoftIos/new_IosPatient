//
//  SignUpVC.swift
//  E4 Patient
//
//  Created by mohab on 17/01/2021.
//

import UIKit
import TransitionButton
import SKCountryPicker

class SignUpVC: UIViewController {
    @IBOutlet var mainView: UIView!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var fNameTxt: UITextField!
    @IBOutlet var lastNameTxt: UITextField!
    @IBOutlet var phoneTxt: UITextField!
    @IBOutlet var emailTxt: UITextField!
    @IBOutlet var dateTxt: UITextField!
    @IBOutlet var genderTxt: UITextField!
    @IBOutlet var passwordTxt: UITextField!
    @IBOutlet var confPasswordTxt: UITextField!
    @IBOutlet var createAccountBtn: TransitionButton!
    @IBOutlet var flagImage: UIImageView!
    @IBOutlet var counntryNameLbl: UILabel!
    @IBOutlet weak var agreeBtn: UIButton!

    @IBOutlet weak var signUpTitleLBL: UILabel!
    @IBOutlet weak var accountInfoLBL: UILabel!
    @IBOutlet weak var firstNameLBL: UILabel!
    @IBOutlet weak var lastNameLBL: UILabel!
    @IBOutlet weak var mobileLBL: UILabel!
    @IBOutlet weak var emailLBL: UILabel!
    @IBOutlet weak var dateOfBirthLBL: UILabel!
    @IBOutlet weak var genderLBL: UILabel!
    @IBOutlet weak var passLBL: UILabel!
    @IBOutlet weak var termsBTN: UIButton!
    @IBOutlet weak var bySigningUpLBL: UILabel!
    @IBOutlet weak var confirmPassLBL: UILabel!
    @IBOutlet weak var alreadyHaveAccountLBL: UILabel!
    @IBOutlet weak var loginBTN: UIButton!

    let pickerView = ToolbarPickerView()
    let datePicker = UIDatePicker()
    var textType: Int = 0
    var userImage = [UploadDataa]()
    var profileImagePath: String = ""
    let genderArr = [("male".localized, 1), ("female".localized, 0)]
    var genderType: Int?
    var agree = false
    
    lazy var imageInstance = imagePickerHelper(viewController: self)
    var headers: [String: String] = ["Content-Type": "multipart/form-data","lang": "2"]
    override func viewDidLoad() {
        super.viewDidLoad()
        setUppicker()
        showDatePicker()
        mainView.ShadowView(view: mainView, radius: 20, opacity: 0.4, shadowRadius: 4, color: UIColor.black.cgColor)
        agreeBtn.layer.cornerRadius = 7
        agreeBtn.layer.borderColor = #colorLiteral(red: 0.07058823529, green: 0.4666666667, blue: 0.8196078431, alpha: 1)
        agreeBtn.layer.borderWidth = 1

    }
    func setLocalization(){
        signUpTitleLBL.text = "SignUp".localized
        accountInfoLBL.text = "AccountInfo".localized
        firstNameLBL.text = "FirstName".localized
        fNameTxt.placeholder = "FirstName".localized
        lastNameLBL.text = "LastName".localized
        lastNameTxt.placeholder = "LastName".localized
        mobileLBL.text = "Mobile".localized
        phoneTxt.placeholder = "Mobile".localized
        emailLBL.text = "Email".localized
        emailTxt.placeholder = "Email".localized
        dateOfBirthLBL.text = "DateOfBirth".localized
        dateTxt.placeholder = "DateOfBirth".localized
        genderLBL.text = "Gender".localized
        genderTxt.placeholder = "Gender".localized
        passLBL.text = "Password".localized
        passwordTxt.placeholder = "Password".localized
        confirmPassLBL.text = "ConfirmPassword".localized
        confPasswordTxt.placeholder = "ConfirmPassword".localized
        termsBTN.setTitle("TermsOfUse".localized, for: .normal)
        bySigningUpLBL.text = "BySigningUpYouAgreeToOur"
        createAccountBtn.setTitle("CreateAccount".localized, for: .normal)
        alreadyHaveAccountLBL.text = "AlreadyHaveAccount".localized
        loginBTN.setTitle("Login".localized, for: .normal)
    }
    override func viewWillAppear(_ animated: Bool) {
        setLocalization()
        self.phoneTxt.placeholder = "+2 000 00000 000"
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
          self.flagImage.image = country.flag
            self.counntryNameLbl.text = country.countryCode
            self.phoneTxt.placeholder = "\(country.dialingCode ?? "")\(" 000 00000 000")"
        }
//        countryController.detailColor = UIColor.blue
    }
    @IBAction func login_CLick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func chooseImage_CLick(_ sender: Any) {
//        uploadImage()
        choosePhoto()
    }
    @IBAction func createAccount_CLick(_ sender: Any) {
        validationinput()
    }
    @IBAction func ShowPass_Click(_ sender: Any) {
        if passwordTxt.isSecureTextEntry == false {
            passwordTxt.isSecureTextEntry = true
        }else{
            passwordTxt.isSecureTextEntry = false
        }
        
    }
    @IBAction func ShowConfPass_Click(_ sender: Any) {
        if confPasswordTxt.isSecureTextEntry == false {
            confPasswordTxt.isSecureTextEntry = true
        }else{
            confPasswordTxt.isSecureTextEntry = false
        }
        
    }
}
