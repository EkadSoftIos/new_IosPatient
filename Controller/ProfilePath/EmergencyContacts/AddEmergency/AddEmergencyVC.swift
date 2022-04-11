//
//  AddEmergencyVC.swift
//  E4 Patient
//
//  Created by mohab on 19/01/2021.
//

import UIKit
import TransitionButton
class AddEmergencyVC: UIViewController,UITextFieldDelegate {
    @IBOutlet var mainView: UIView!
    @IBOutlet var nameTxt: UITextField!
    @IBOutlet var relationTxt: UITextField!
    @IBOutlet var phoneTxt: UITextField!
    @IBOutlet var emailTxt: UITextField!
    @IBOutlet var addressTxt: UITextField!
    @IBOutlet var countryTxt: UITextField!
    @IBOutlet var cityTxt: UITextField!
    @IBOutlet var areaTxt: UITextField!
    @IBOutlet var saveBtn: TransitionButton!
    @IBOutlet var countryImage: UIImageView!
    var model: UserDataModel?
    var Delegete: AddEmergency?
    var isUpdate: Bool = false
    var updateData: TblPatientContact?
    
    var selectedCountryIndex: Int?
    var selectedCityIndex:Int?
    var selectedAreaIndex: Int?
    let countryPickerView = UIPickerView()
    let citiesPickerView = UIPickerView()
    let areaPickerView = UIPickerView()
    let relationPickerView = UIPickerView()
    var citysmodel: GetFullCitiesModel?
    var RelationModel : getRelationsModel?
    var relationID: Int?
    var countryId: Int = 0
    var CityId: Int = 0
    var AreaID: Int = 0
    override func viewWillAppear(_ animated: Bool) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        countryTxt.delegate = self
        cityTxt.delegate = self
        areaTxt.delegate = self
        mainView.ShadowView(view: mainView, radius: 20, opacity: 0.4, shadowRadius: 4, color: UIColor.black.cgColor)
        self.navigationItem.title = "Add Emergency".localized
        setUpPickerView()
        getCountries()
        setData()
        getRlations()
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == countryTxt {
            selectedCountryIndex = 0
            countryId = citysmodel?.message?[0].countryID ?? 0
            countryTxt.text = citysmodel?.message?[0].countryNameEn ?? ""
        }else if textField == cityTxt{
            if countryTxt.text!.isEmpty {
                self.showMessage(title: "", sub: "choose country first", type: .error, layout: .messageView)
                self.countryTxt.resignFirstResponder()
            }else{
                setUpPickerView()
                selectedCityIndex = 0
                CityId = citysmodel?.message?[selectedCountryIndex ?? 0].lookupCity?[0].cityID ?? 0
                cityTxt.text = citysmodel?.message?[selectedCountryIndex ?? 0].lookupCity?[0].cityNameEn ?? ""
            }
        }else if textField == areaTxt{
            if cityTxt.text!.isEmpty {
                self.showMessage(title: "", sub: "choose city first", type: .error, layout: .messageView)
                self.cityTxt.resignFirstResponder()
            }else{
                setUpPickerView()
                selectedAreaIndex = 0
                if citysmodel?.message?[selectedCountryIndex ?? 0].lookupCity?[selectedCityIndex ?? 0].lookupArea?.count != 0{
                AreaID = citysmodel?.message?[selectedCountryIndex ?? 0].lookupCity?[selectedCityIndex ?? 0].lookupArea?[0].areaID ?? 0
                areaTxt.text = citysmodel?.message?[selectedCountryIndex ?? 0].lookupCity?[selectedCityIndex ?? 0].lookupArea?[0].areaNameEn ?? ""
                }
            }
        }
    }
    func setData(){
        if isUpdate == true {
        self.navigationItem.title = "Edit Emergency".localized
            nameTxt.text = updateData?.contactName
            relationTxt.text = updateData?.relationLocalizedName
            phoneTxt.text = updateData?.contactMobile
            emailTxt.text = updateData?.contactEmail
            addressTxt.text = updateData?.contactAddress
            countryId = updateData?.contactCountryFk ?? 0
            CityId = updateData?.contactCityFk ?? 0
            AreaID = updateData?.contactAreaFk ?? 0
            relationID = updateData?.relationFk
            countryImage.isHidden = false
        }else{
            countryImage.isHidden = true
            self.navigationItem.title = "Add Emergency".localized
        }
    }
    @IBAction func save_Click(_ sender: Any) {
        callApi()
    }
}
protocol AddEmergency {
    func Data(isAdded: Bool)
}
