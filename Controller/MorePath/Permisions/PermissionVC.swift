//
//  PermissionVC.swift
//  E4 Patient
//
//  Created by mohab on 23/01/2021.
//

import UIKit
import TransitionButton
class PermissionVC: UIViewController, UITextFieldDelegate {
    @IBOutlet var mainView: UIView!
    @IBOutlet var allowDoctorImage: UIImageView!
    @IBOutlet var chooseDoctorImage: UIImageView!
    //personal data
    @IBOutlet var personalDetailsImage: UIImageView!
    @IBOutlet var addressImage: UIImageView!
    @IBOutlet var allPersonalBtn: UIButton!
    
    @IBOutlet var emergencyImage: UIImageView!
    //basic profile
    @IBOutlet var diesesImage: UIImageView!
    @IBOutlet var medicationsImage: UIImageView!
    @IBOutlet var allergiesImage: UIImageView!
    @IBOutlet var socialImage: UIImageView!
    @IBOutlet var familyImage: UIImageView!
    @IBOutlet var surgeryImage: UIImageView!
    @IBOutlet var allBasicBtn: UIButton!
    @IBOutlet var savebtn: TransitionButton!
    @IBOutlet var entityTxt: UITextField!
    @IBOutlet var mainSpecialityTxt: UITextField!
    @IBOutlet var healthCareTxt: UITextField!
    @IBOutlet var chooseDoctorsView: UIView!
    @IBOutlet var chooseViewHEight: NSLayoutConstraint!
    @IBOutlet weak var allowForLBL: UILabel!
    @IBOutlet weak var allowAllDoctorLBL: UILabel!
    @IBOutlet weak var chooseSomeLBL: UILabel!
    @IBOutlet weak var filterProviderByLBL: UILabel!
    @IBOutlet weak var entityLBL: UILabel!
    @IBOutlet weak var mainSpecLBL: UILabel!
    @IBOutlet weak var healthCareProvLBL: UILabel!
    @IBOutlet weak var basicProfLBL: UILabel!
    @IBOutlet weak var medicalReportsLBL: UILabel!
    @IBOutlet weak var emergencyContactLBL: UILabel!
    @IBOutlet weak var healthProfLBL: UILabel!
    @IBOutlet weak var diseasesLBL: UILabel!
    @IBOutlet weak var medicationLBL: UILabel!
    @IBOutlet weak var allerqiesLBL: UILabel!
    @IBOutlet weak var socialHistoryLBL: UILabel!
    @IBOutlet weak var familyHistoryLBL: UILabel!
    @IBOutlet weak var surgeyLBL: UILabel!
    var Model: UserDataModel?
    var showpersonal: Bool = false
    var ForAllDoctors: Bool = false
    var ShowAddress: Bool = false
    var ShowEmergencyContact: Bool = false
    var ShowDisease: Bool = false
    var ShowMedication: Bool = false
    var ShowAllergies: Bool = false
    var ShowSocialHistory: Bool = false
    var ShowSocialFamily: Bool = false
    var ShowSurgery: Bool = false
    var selectedentityIndex: Int?
    var selecteddoctorIndex: Int?
    var selectedspecialtyIndex:Int?
    var selectedAreaIndex: Int?
    let entityPickerView = UIPickerView()
    let MainSpecialityPickerView = UIPickerView()
    let HealthcareProvidersPickerView = UIPickerView()
    var entityModel: BusinessProviderModel?
    var Delegete: addPermission?
    var specialityModel: GetspecialityModel?
    var doctorModel: BusinessProvideremployeModel?
    // var isallBasic: Bool = false
    var allClick: Bool = false
    var Ids: String = ""
    var isallPersonal: Bool = false
    var isallBasic: Bool = false
    var helthArr = [Int]()
    var allDoctorsModel: GetDoctorsModel?
    var healthText: String = ""
    var helthID: String = ""
    var isHealthPicker: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        Ids = Model?.message?.tblPatientProfilePermition?[0].doctorIDS ?? ""
        callApigetEntity()
        callApispeciality()
        self.navigationItem.title = "Profile Permission".localized
        mainView.ShadowView(view: mainView, radius: 20, opacity: 0.4, shadowRadius: 4, color: UIColor.black.cgColor)
        setdata()
        setUpPickerView()
        getDoctors()
        setUpText()
        healthCareTxt.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        setLocaization()
    }
    func setLocaization(){
        allowForLBL.text = "Allow For".localized
        allowAllDoctorLBL.text = "Allow All Doctors".localized
        chooseSomeLBL.text = "Choose some Doctors".localized
        filterProviderByLBL.text = "Filter Provider By".localized
        entityLBL.text = "Entity".localized
        mainSpecLBL.text = "Main Speciality".localized
        entityTxt.placeholder = "Entity".localized
        mainSpecialityTxt.placeholder = "Main Speciality".localized
        healthCareTxt.placeholder = "Healthcare Providers".localized
        healthCareProvLBL.text = "Healthcare Providers".localized
        basicProfLBL.text = "Basic Profile".localized
        medicalReportsLBL.text = "Medical Reports".localized
        emergencyContactLBL.text = "Emergency Contacts".localized
        healthProfLBL.text = "Health Profile".localized
        diseasesLBL.text = "Diseases / Conditions".localized
        medicationLBL.text = "Medications".localized
        allerqiesLBL.text = "Allergies".localized
        socialHistoryLBL.text = "Social History".localized
        familyHistoryLBL.text = "Family History".localized
        surgeyLBL.text = "Surgery / Implants".localized
        allPersonalBtn.setTitle("All".localized, for: .normal)
        allBasicBtn.setTitle("All".localized, for: .normal)
        savebtn.setTitle("Save".localized, for: .normal)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
           if textField == healthCareTxt {
            isHealthPicker = true
           }
       }
    func setdata(){
        
        if Model?.message?.tblPatientProfilePermition?.count != 0{
            let Permition = Model?.message?.tblPatientProfilePermition?[0]
            healthCareTxt.text = Permition?.doctorIDS ?? ""
            
            setUpText()
            let stringNumbers = Permition?.doctorIDS ?? ""
            let array = stringNumbers.components(separatedBy: ",")
            helthArr = array.map { Int($0) ?? 0}
            print("arr: \(helthArr)")
            if Permition?.forAllDoctors == true{
                ForAllDoctors = true
                allowAllDoctorLBL.textColor = UIColor (named: "Blue")
                chooseSomeLBL.textColor = UIColor (named: "darkGray")

                UIView.animate(withDuration: 1) {
                    self.chooseDoctorsView.alpha = 0
                    self.chooseViewHEight.constant = 0
                    self.view.layoutIfNeeded()
                }
                radioButton(selected: allowDoctorImage, unselected: chooseDoctorImage)
            }else{
                ForAllDoctors = false
                allowAllDoctorLBL.textColor = UIColor (named: "darkGray")
                chooseSomeLBL.textColor = UIColor (named: "Blue")

                chooseDoctorsView.alpha = 0
                chooseViewHEight.constant = 0
                radioButton(selected: chooseDoctorImage, unselected: allowDoctorImage)
                UIView.animate(withDuration: 1) {
                    self.chooseDoctorsView.alpha = 1
                    self.chooseViewHEight.constant = 210
                    self.view.layoutIfNeeded()
                }
            }
            if Permition?.showMedicalReport == true && Permition?.showEmergencyContact == true{
                isallPersonal = true
                emergencyContactLBL.textColor = UIColor (named: "Blue")
                medicalReportsLBL.textColor = UIColor (named: "Blue")
                allPersonalBtn.setImage(#imageLiteral(resourceName: "ic_check_active"), for: .normal)
            }
            if Permition?.showDisease == true && Permition?.showMedication == true && Permition?.showAllergies == true && Permition?.showSocialHistory == true && Permition?.showSocialFamily == true && Permition?.showSurgery == true {
                isallBasic = true
                surgeyLBL.textColor = UIColor (named: "Blue")
                familyHistoryLBL.textColor = UIColor (named: "Blue")
                socialHistoryLBL.textColor = UIColor (named: "Blue")
                allerqiesLBL.textColor = UIColor (named: "Blue")
                medicationLBL.textColor = UIColor (named: "Blue")
                diseasesLBL.textColor = UIColor (named: "Blue")
                allBasicBtn.setImage(#imageLiteral(resourceName: "ic_check_active"), for: .normal)
            }
            if Permition?.showMedicalReport == true{
               ShowAddress = true
                medicalReportsLBL.textColor = UIColor (named: "Blue")
               checkBox(selectedImage: addressImage)
           }
            if Permition?.showPersonalDetails == true {
                checkBox(selectedImage: personalDetailsImage)
                showpersonal = true
            }
            if Permition?.showAddress == true {
                checkBox(selectedImage: addressImage)
                ShowAddress = true
            }
            if Permition?.showEmergencyContact == true {
                checkBox(selectedImage: emergencyImage)
                emergencyContactLBL.textColor = UIColor (named: "Blue")
                ShowEmergencyContact = true
            }
            if Permition?.showDisease == true{
                diseasesLBL.textColor = UIColor (named: "Blue")
                checkBox(selectedImage: diesesImage)
                ShowDisease = true
            }
            if Permition?.showMedication == true {
                medicationLBL.textColor = UIColor (named: "Blue")
                ShowMedication = true
                checkBox(selectedImage: medicationsImage)
            }
            if Permition?.showAllergies == true {
                allerqiesLBL.textColor = UIColor (named: "Blue")
                ShowAllergies = true
                checkBox(selectedImage: allergiesImage)
            }
            if Permition?.showSocialHistory == true {
                socialHistoryLBL.textColor = UIColor (named: "Blue")
                ShowSocialHistory = true
                checkBox(selectedImage: socialImage)
            }
            if Permition?.showSocialFamily == true{
                familyHistoryLBL.textColor = UIColor (named: "Blue")
                checkBox(selectedImage: familyImage)
                ShowSocialFamily = true
            }
            if Permition?.showSurgery == true {
                surgeyLBL.textColor = UIColor (named: "Blue")
                ShowSurgery = true
                checkBox(selectedImage: surgeryImage)
            }
            
        }
        
    }
    func setUpText(){
        if healthCareTxt.text!.prefix(1) == "," || healthCareTxt.text == "" || healthCareTxt.text!.isEmpty{
            healthCareTxt.text!.remove(at: healthCareTxt.text!.startIndex)
        }
      
    }
    func radioButton(selected: UIImageView, unselected: UIImageView){
        selected.image = #imageLiteral(resourceName: "ic_radiobtn_active")
        unselected.image = #imageLiteral(resourceName: "ic_radiobtn_unactive")
    }
    func checkBox(selectedImage: UIImageView){
        
        if selectedImage.image == #imageLiteral(resourceName: "ic_check_active"){
            selectedImage.image = #imageLiteral(resourceName: "ic_check_unactive")
            allBasicBtn.setImage(#imageLiteral(resourceName: "ic_check_unactive"), for: .normal)
            allPersonalBtn.setImage(#imageLiteral(resourceName: "ic_check_unactive"), for: .normal)
        }else
        {
            selectedImage.image = #imageLiteral(resourceName: "ic_check_active")
        }
        
        
    }
    @IBAction func allowDoctors_CLick(_ sender: Any) {
        ForAllDoctors = true
        allowAllDoctorLBL.textColor = UIColor (named: "Blue")
        chooseSomeLBL.textColor = UIColor (named: "darkGray")
        UIView.animate(withDuration: 1) {
            self.chooseDoctorsView.alpha = 0
            self.chooseViewHEight.constant = 0
            self.view.layoutIfNeeded()
        }
        radioButton(selected: allowDoctorImage, unselected: chooseDoctorImage)
    }
    
    @IBAction func save_CLick(_ sender: Any) {
        callApi()
    }
    @IBAction func chooseDoctors_CLick(_ sender: Any) {
        ForAllDoctors = false
        allowAllDoctorLBL.textColor = UIColor (named: "darkGray")
        chooseSomeLBL.textColor = UIColor (named: "Blue")

        UIView.animate(withDuration: 1) {
            self.chooseDoctorsView.alpha = 1
            self.chooseViewHEight.constant = 210
            self.view.layoutIfNeeded()
        }
        radioButton(selected: chooseDoctorImage, unselected: allowDoctorImage)
    }
    
    
    //MARK:-basic profile
    @IBAction func personalDetails_CLick(_ sender: Any) {
        checkBox(selectedImage: personalDetailsImage)
        if showpersonal == false{
            showpersonal = true
        }else{
            showpersonal = false
        }
        
    }
    @IBAction func medReports_CLick(_ sender: Any) {
        if ShowAddress == false{
            ShowAddress = true
        }else{
            ShowAddress = false
        }
        ShowAddress = true
        if addressImage.image == #imageLiteral(resourceName: "ic_check_active"){
            medicalReportsLBL.textColor = UIColor (named: "darkGray")
        }else{
            medicalReportsLBL.textColor = UIColor (named: "Blue")
        }
        checkBox(selectedImage: addressImage)
        
    }
    @IBAction func emergency_CLick(_ sender: Any) {
        if ShowEmergencyContact == false {
            ShowEmergencyContact = true
        }else{
            ShowEmergencyContact = false
        }
        if emergencyImage.image == #imageLiteral(resourceName: "ic_check_active"){
            emergencyContactLBL.textColor = UIColor (named: "darkGray")

        }else{
            emergencyContactLBL.textColor = UIColor (named: "Blue")

        }
        checkBox(selectedImage: emergencyImage)
    }
    @IBAction func allPersonal_Click(_ sender: Any) {

        if isallPersonal == false {
            allPersonalBtn.setImage(#imageLiteral(resourceName: "ic_check_active"), for: .normal)
            addressImage.image = #imageLiteral(resourceName: "ic_check_active")
            emergencyImage.image = #imageLiteral(resourceName: "ic_check_active")
            isallPersonal = true
            ShowAddress = true
            ShowEmergencyContact = true
            emergencyContactLBL.textColor = UIColor (named: "Blue")
            medicalReportsLBL.textColor = UIColor (named: "Blue")

        }else{
            allPersonalBtn.setImage(#imageLiteral(resourceName: "ic_check_unactive"), for: .normal)
            addressImage.image = #imageLiteral(resourceName: "ic_check_unactive")
            emergencyImage.image = #imageLiteral(resourceName: "ic_check_unactive")
            isallPersonal = false
            ShowAddress = false
            ShowEmergencyContact = false
            emergencyContactLBL.textColor = UIColor (named: "darkGray")
            medicalReportsLBL.textColor = UIColor (named: "darkGray")
        }
    }
    //MARK:-basic
    @IBAction func dieseses_Click(_ sender: Any) {
        if diesesImage.image == #imageLiteral(resourceName: "ic_check_active"){
            diseasesLBL.textColor = UIColor (named: "darkGray")
        }else{
            diseasesLBL.textColor = UIColor (named: "Blue")
        }
        checkBox(selectedImage: diesesImage)
        if ShowDisease == false{
            ShowDisease = true
        }else{
            ShowDisease = false
            
        }
    }
    @IBAction func medications_Click(_ sender: Any) {
        if ShowMedication == false{
            ShowMedication = true
        }else{
            ShowMedication = false
        }
        if medicationsImage.image == #imageLiteral(resourceName: "ic_check_active"){
            medicationLBL.textColor = UIColor (named: "darkGray")
        }else{
            medicationLBL.textColor = UIColor (named: "Blue")
        }
        checkBox(selectedImage: medicationsImage)
    }
    @IBAction func allergies_Click(_ sender: Any) {
        if ShowAllergies == false{
            ShowAllergies = true
        }else{
            ShowAllergies = false
        }
        if allergiesImage.image == #imageLiteral(resourceName: "ic_check_active"){
            allerqiesLBL.textColor = UIColor (named: "darkGray")
        }else{
            allerqiesLBL.textColor = UIColor (named: "Blue")
        }
        checkBox(selectedImage: allergiesImage)
    }
    @IBAction func social_CLick(_ sender: Any) {
        if ShowSocialFamily == false{
            ShowSocialHistory = true
        }else{
            ShowSocialHistory = false
        }
        if socialImage.image == #imageLiteral(resourceName: "ic_check_active"){
            socialHistoryLBL.textColor = UIColor (named: "darkGray")
        }else{
            socialHistoryLBL.textColor = UIColor (named: "Blue")
        }
        checkBox(selectedImage: socialImage)
    }
    @IBAction func familyHistory_CLick(_ sender: Any) {
        if familyImage.image == #imageLiteral(resourceName: "ic_check_active"){
            familyHistoryLBL.textColor = UIColor (named: "darkGray")
        }else{
            familyHistoryLBL.textColor = UIColor (named: "Blue")
        }
        checkBox(selectedImage: familyImage)
        if ShowSocialHistory == false{
            ShowSocialFamily = true
        }else{
            ShowSocialFamily = false
        }
    }
    @IBAction func surgery_Click(_ sender: Any) {
        if ShowSurgery == false{
            ShowSurgery = true
        }else{
            ShowSurgery = false
        }
        if surgeryImage.image == #imageLiteral(resourceName: "ic_check_active"){
            surgeyLBL.textColor = UIColor (named: "darkGray")
        }else{
            surgeyLBL.textColor = UIColor (named: "Blue")
        }
        checkBox(selectedImage: surgeryImage)
    }
    @IBAction func allBasic_CLick(_ sender: Any) {
        allClick = true
        if isallBasic == false{
            ShowDisease = true
            ShowMedication = true
            ShowAllergies = true
            ShowSocialHistory = true
            ShowSocialFamily = true
            ShowSurgery = true
            allBasicBtn.setImage(#imageLiteral(resourceName: "ic_check_active"), for: .normal)
            diesesImage.image = #imageLiteral(resourceName: "ic_check_active")
            medicationsImage.image = #imageLiteral(resourceName: "ic_check_active")
            allergiesImage.image = #imageLiteral(resourceName: "ic_check_active")
            socialImage.image = #imageLiteral(resourceName: "ic_check_active")
            familyImage.image = #imageLiteral(resourceName: "ic_check_active")
            surgeryImage.image = #imageLiteral(resourceName: "ic_check_active")
            isallBasic = true
            surgeyLBL.textColor = UIColor (named: "Blue")
            familyHistoryLBL.textColor = UIColor (named: "Blue")
            socialHistoryLBL.textColor = UIColor (named: "Blue")
            allerqiesLBL.textColor = UIColor (named: "Blue")
            medicationLBL.textColor = UIColor (named: "Blue")
            diseasesLBL.textColor = UIColor (named: "Blue")
        }else{
            allBasicBtn.setImage(#imageLiteral(resourceName: "ic_check_unactive"), for: .normal)
            diesesImage.image = #imageLiteral(resourceName: "ic_check_unactive")
            medicationsImage.image = #imageLiteral(resourceName: "ic_check_unactive")
            allergiesImage.image = #imageLiteral(resourceName: "ic_check_unactive")
            socialImage.image = #imageLiteral(resourceName: "ic_check_unactive")
            familyImage.image = #imageLiteral(resourceName: "ic_check_unactive")
            surgeryImage.image = #imageLiteral(resourceName: "ic_check_unactive")
            isallBasic = false
            ShowDisease = false
            ShowMedication = false
            ShowAllergies = false
            ShowSocialHistory = false
            ShowSocialFamily = false
            ShowSurgery = false
            surgeyLBL.textColor = UIColor (named: "darkGray")
            familyHistoryLBL.textColor = UIColor (named: "darkGray")
            socialHistoryLBL.textColor = UIColor (named: "darkGray")
            allerqiesLBL.textColor = UIColor (named: "darkGray")
            medicationLBL.textColor = UIColor (named: "darkGray")
            diseasesLBL.textColor = UIColor (named: "darkGray")

        }
    }
    func setUpPickerView(){
        entityPickerView.dataSource = self
        entityPickerView.delegate = self
        entityTxt.inputView = entityPickerView
        if Languagee.language == .arabic {
            entityTxt.textAlignment = .right
        }else{
            entityTxt.textAlignment = .left
        }
        createDoneBtn(for: entityTxt)
        
        HealthcareProvidersPickerView.dataSource = self
        HealthcareProvidersPickerView.delegate = self
        healthCareTxt.inputView = HealthcareProvidersPickerView
        if Languagee.language == .arabic {
            healthCareTxt.textAlignment = .right
        }else{
            healthCareTxt.textAlignment = .left
        }
        createDoneBtn(for: healthCareTxt)
        
        MainSpecialityPickerView.dataSource = self
        MainSpecialityPickerView.delegate = self
        mainSpecialityTxt.inputView = MainSpecialityPickerView
        if Languagee.language == .arabic {
            mainSpecialityTxt.textAlignment = .right
        }else{
            mainSpecialityTxt.textAlignment = .left
        }
        createDoneBtn(for: mainSpecialityTxt)
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
        if isHealthPicker == true{
            healthCareTxt.text = "\(healthCareTxt.text ?? ""), \(healthText)"
            self.view.endEditing(true)
            Ids = "\(Ids),\(helthID)"
            setUpText()
        }else{
            self.view.endEditing(true)
        }
    }
    
    
}
protocol addPermission {
    func Data(isAdded: Bool)
}
