//
//  AddAddressVC.swift
//  E4 Patient
//
//  Created by mohab on 19/01/2021.
//

import UIKit
import TransitionButton
import CoreLocation
class AddAddressVC: UIViewController, UITextViewDelegate {
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var addressTypeTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var areaTextField: UITextField!
    @IBOutlet weak var streetNameTextField: UITextField!
    @IBOutlet weak var buildingTextField: UITextField!
    @IBOutlet weak var floorTextField: UITextField!
    @IBOutlet weak var landmarkTextView: UITextView!
    @IBOutlet weak var locationTextField: TextField!
    @IBOutlet weak var saveButton: TransitionButton!
    
    let countryPickerView = UIPickerView()
    let citiesPickerView = UIPickerView()
    let areaPickerView = UIPickerView()
    
    var editAddress: TblPatientAddress?
    var Delegete: isAddressAdded?
    var model: GetFullCitiesModel?
    var selectedCountryIndex: Int?
    var selectedCityIndex:Int?
    var selectedAreaIndex: Int?
    var lat: String = ""
    var Lang: String = ""
    var isUpdate: Bool = false
    var countryId: Int = 0
    var CityId: Int = 0
    var AreaID: Int = 0
    var userModel: UserDataModel?
    override func viewWillAppear(_ animated: Bool) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        landmarkTextView.text = "LandMark".localized
        landmarkTextView.textColor = UIColor.lightGray
        landmarkTextView.delegate = self
        mainView.ShadowView(view: mainView, radius: 20, opacity: 0.4, shadowRadius: 4, color: UIColor.black.cgColor)
        showUniversalLoadingView(true)
        setUpPickerView()
        getCountries()
        SetData()
       
    }
    func SetData(){
        if isUpdate == true {
            self.navigationItem.title = "Edit Address".localized
            addressTypeTextField.text = editAddress?.patientAddressName
            countryTextField.text = editAddress?.countryNameLocalized
            cityTextField.text = editAddress?.cityNameLocalized
            areaTextField.text = editAddress?.areaNameLocalized
            streetNameTextField.text = editAddress?.streetName
            buildingTextField.text = editAddress?.buldingNum
            floorTextField.text = editAddress?.floor
            landmarkTextView.text = editAddress?.landMark
            locationTextField.text = editAddress?.mapAddress
            AreaID = editAddress?.areaFk ?? 0
            CityId = editAddress?.cityFk ?? 0
            countryId = editAddress?.countryFk ?? 0
            if editAddress?.landMark != "LandMark".localized{
                landmarkTextView.textColor = UIColor.black
            }
        }else{
            self.navigationItem.title = "Add Address".localized
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "LandMark"
            textView.textColor = UIColor.lightGray
        }
    }
    @IBAction func getLocationMap_Click(_ sender: Any) {
        self.view.endEditing(true)
        let vc = MapVc()
        vc.delegate = self
        show(vc, sender: nil)
    }

    
    @IBAction func save_Click(_ sender: Any) {
        validate()
    }
    
    @IBAction func countryTextFieldBeginEditing(_ sender: Any) {
        selectedCountryIndex = 0
        countryId = model?.message?[0].countryID ?? 0
        countryTextField.text = model?.message?[0].countryNameEn ?? ""
    }
    
    @IBAction func cityTextFieldBeginEditing(_ sender: Any) {
        if countryTextField.text!.isEmpty {
            self.showMessage(title: "", sub: "choose country first", type: .error, layout: .messageView)
            self.countryTextField.resignFirstResponder()
        }else{
            setUpPickerView()
        selectedCityIndex = 0
        CityId = model?.message?[selectedCountryIndex ?? 0].lookupCity?[0].cityID ?? 0
            cityTextField.text = model?.message?[selectedCountryIndex ?? 0].lookupCity?[0].cityNameEn ?? ""
            
        }
    }
    
    @IBAction func areaTextFieldBeginEditing(_ sender: Any) {
        if cityTextField.text!.isEmpty {
            self.showMessage(title: "", sub: "choose city first", type: .error, layout: .messageView)
            self.cityTextField.resignFirstResponder()
        }else{
            setUpPickerView()
        selectedAreaIndex = 0
            if model?.message?[selectedCountryIndex ?? 0].lookupCity?[selectedCityIndex ?? 0].lookupArea?.count != 0{
            AreaID = model?.message?[selectedCountryIndex ?? 0].lookupCity?[selectedCityIndex ?? 0].lookupArea?[0].areaID ?? 0
            areaTextField.text = model?.message?[selectedCountryIndex ?? 0].lookupCity?[selectedCityIndex ?? 0].lookupArea?[0].areaNameEn ?? ""
            }
        }
    }
    
    func getCountries() {
        NetworkClient.performRequest(_type: GetFullCitiesModel.self, router: .getAllCountries) { [weak self] (result) in
            guard let self = self else {return}
            showUniversalLoadingView(false)
            
            switch result {
            case .success(let model) :
                if model.successtate == 200 {
                    self.model = model
                    self.updateUI()
                }
                else{
                    self.showAlertWith(msg: model.errormessage ?? "")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    func updateUI() {
        countryPickerView.reloadComponent(0)
        areaPickerView.reloadComponent(0)
        citiesPickerView.reloadComponent(0)
    }
    
    func setUpPickerView(){
       
        if countryTextField.text!.isEmpty {
            
        }else{
            citiesPickerView.dataSource = self
            citiesPickerView.delegate = self
            cityTextField.inputView = citiesPickerView
            createDoneBtn(for: cityTextField)
        }
        if cityTextField.text!.isEmpty {
      
            
        }else{
            areaPickerView.dataSource = self
            areaPickerView.delegate = self
            areaTextField.inputView = areaPickerView
            createDoneBtn(for: areaTextField)
        }
        
        countryPickerView.dataSource = self
        countryPickerView.delegate = self
        countryTextField.inputView = countryPickerView
        createDoneBtn(for: countryTextField)

    }
    func createDoneBtn (for textField : UITextField)
    {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action:#selector(donePressedOfPickerView))
        toolbar.setItems([done], animated: true)
        textField.inputAccessoryView = toolbar
    }
    @objc func donePressedOfPickerView()
    {
        self.view.endEditing(true)
    }
    func validate() {
        if addressTypeTextField.text!.isEmpty
        || countryTextField.text!.isEmpty ||
        cityTextField.text!.isEmpty ||
        areaTextField.text!.isEmpty ||
        streetNameTextField.text!.isEmpty ||
        buildingTextField.text!.isEmpty ||
        floorTextField.text!.isEmpty ||
        landmarkTextView.text.isEmpty  {
            self.showMessage(title: "", sub: "all data required".localized, type: .error, layout: .messageView)
        }
        else {
            self.saveButton.startAnimation()
            self.callAPI()
        }
    }
    func callAPI(){
   
        let parameters: [String: Any] = [
            "PatientAddressId": editAddress?.patientAddressID ?? 0,
            "PatientFk": userModel?.message?.patientID ?? 0,
            "PatientAddressName": addressTypeTextField.text ?? "",
            "CountryFk": countryId,
            "CityFk": CityId,
            "AreaFk": AreaID ,
            "StreetName": streetNameTextField.text ?? "",
            "BuldingNum": buildingTextField.text ?? "",
            "Floor": floorTextField.text ?? "",
            "LandMark": landmarkTextView.text ?? "",
            "AddressLang": Lang,
            "AddressLat": lat,
            "mapAddress": locationTextField.text ?? ""
        ]
        print("params: \(parameters)")
            NetworkClient.performRequest(_type: SuccessModel.self, router: .addNewAddress(params: parameters)) {[weak self] (result) in
                guard let self = self else {return}
                switch result{
                
                
                case .success(let model):
                    if model.successtate == 200{
                        self.showMessage(title: "", sub: model.message, type: .success, layout: .messageView)
                        self.saveButton.stopAnimation()
                        Vibration.success.vibrate()
                        self.Delegete?.Data(isAdded: true)
                        self.navigationController?.popViewController(animated: true)
                    }else{
                        self.showMessage(title: "", sub: model.errormessage, type: .error, layout: .messageView)
                        
                        self.saveButton.stopAnimation()
                    }
                case .failure(let model):
                    print("failure: \(model)")
                    self.saveButton.stopAnimation()
                }

            }
        
    }
}
extension UIView{
    func ShadowView(view: UIView, radius: CGFloat, opacity: Float, shadowRadius: CGFloat, color: CGColor){
        
        view.layer.cornerRadius = radius
        view.layer.shadowColor = color
        view.layer.shadowOpacity = opacity
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = shadowRadius

    }
    
}

extension AddAddressVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == countryPickerView {
            return model?.message?.count ?? 0
        }
        else if pickerView == citiesPickerView {
            return model?.message?[selectedCountryIndex ?? 0].lookupCity?.count ?? 0
        }
        else {
            return model?.message?[selectedCountryIndex ?? 0].lookupCity?[selectedCityIndex ?? 0].lookupArea?.count ?? 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == countryPickerView {
            return model?.message?[row].countryNameEn ?? ""
        }
        else if pickerView == citiesPickerView {
            
            return model?.message?[selectedCountryIndex ?? 0].lookupCity?[row].cityNameEn ?? ""
        }
        else {
            return model?.message?[selectedCountryIndex ?? 0].lookupCity?[selectedCityIndex ?? 0].lookupArea?[row].areaNameEn ?? ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == countryPickerView {
            selectedCountryIndex = row
            countryId = model?.message?[selectedCountryIndex ?? 0].countryID ?? 0
            countryTextField.text = model?.message?[selectedCountryIndex ?? 0].countryNameEn ?? ""
            cityTextField.text = ""
            areaTextField.text = ""
        }
        else if pickerView == citiesPickerView {
            selectedCityIndex = row
            CityId = model?.message?[selectedCountryIndex ?? 0].lookupCity?[selectedCityIndex ?? 0].cityID ?? 0
            cityTextField.text = model?.message?[selectedCountryIndex ?? 0].lookupCity?[selectedCityIndex ?? 0].cityNameEn ?? ""
            areaTextField.text = ""
        }
        else {
            selectedAreaIndex = row
            if model?.message?[selectedCountryIndex ?? 0].lookupCity?[selectedCityIndex ?? 0].lookupArea?.count != 0{
            AreaID = model?.message?[selectedCountryIndex ?? 0].lookupCity?[selectedCityIndex ?? 0].lookupArea?[selectedAreaIndex ?? 0].areaID ?? 0
                areaTextField.text = model?.message?[selectedCountryIndex ?? 0].lookupCity?[selectedCityIndex ?? 0].lookupArea?[selectedAreaIndex ?? 0].areaNameEn ?? ""
                
            }

        }
    }
}
extension AddAddressVC:chooseLocation{
    func chooseLocation(deliverylocation: CLLocationCoordinate2D, name: String) {
        lat = "\(deliverylocation.latitude)"
        Lang = "\(deliverylocation.longitude)"
        print("lat: \(lat), lang:\(Lang)")
        locationTextField.text = name
        
    }
    
}
protocol isAddressAdded {
    func Data(isAdded: Bool)
}
