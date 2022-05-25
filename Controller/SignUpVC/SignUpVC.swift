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
    @IBOutlet var createAccountBtn: TransitionButton!
    @IBOutlet var flagImage: UIImageView!
    @IBOutlet var counntryNameLbl: UILabel!
    let pickerView = ToolbarPickerView()
    let datePicker = UIDatePicker()
    var textType: Int = 0
    var userImage = [UploadDataa]()
    var profileImagePath: String = ""
    let genderArr = [("male".localized, 1), ("female".localized, 0)]
    var genderType: Int?
    lazy var imageInstance = imagePickerHelper(viewController: self)
    var headers: [String: String] = ["Content-Type": "multipart/form-data","lang": "2"]
    override func viewDidLoad() {
        super.viewDidLoad()
        setUppicker()
        showDatePicker()
        mainView.ShadowView(view: mainView, radius: 20, opacity: 0.4, shadowRadius: 4, color: UIColor.black.cgColor)
    }

    @IBAction func chooseCountry_Click(_ sender: Any) {
        CountryPickerWithSectionViewController.presentController(on: self) { [weak self] (country: Country) in
          guard let self = self else { return }
          self.flagImage.image = country.flag
            self.counntryNameLbl.text = country.countryCode
        }
        //countryController.detailColor = UIColor.blue
    }
    @IBAction func login_CLick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func chooseImage_CLick(_ sender: Any) {
        uploadImage()
    }
    @IBAction func createAccount_CLick(_ sender: Any) {
        validationinput()
    }
    
}
