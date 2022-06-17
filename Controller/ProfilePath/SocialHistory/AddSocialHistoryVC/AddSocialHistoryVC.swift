//
//  AddSocialHistoryVC.swift
//  E4 Patient
//
//  Created by mohab on 23/01/2021.
//

import UIKit
import TransitionButton
class AddSocialHistoryVC: UIViewController {
    @IBOutlet var mainView: UIView!
    @IBOutlet var yesSmokingImage: UIImageView!
    @IBOutlet var noSmokingImage: UIImageView!
    @IBOutlet var yesAlcoholImage: UIImageView!
    @IBOutlet var noAlcoholImage: UIImageView!
    @IBOutlet var jobTxt: TextField!
    @IBOutlet var educationTxt: UITextField!
    @IBOutlet var maritalStatusTxt: TextField!
    @IBOutlet var childrenTxt: UITextField!
    @IBOutlet var generalDietTxt: UITextField!
    @IBOutlet var exercideTxt: UITextField!
    @IBOutlet var saveBtn: TransitionButton!
    
    
    @IBOutlet weak var jobLBL: UILabel!
    @IBOutlet weak var educationLBL: UILabel!
    @IBOutlet weak var smookingLBL: UILabel!
    @IBOutlet weak var yesLBL: UILabel!
    @IBOutlet weak var noLBL: UILabel!
    @IBOutlet weak var alcoholLBL: UILabel!
    @IBOutlet weak var yesAlCoholLBL: UILabel!
    @IBOutlet weak var noAlcoholLBL: UILabel!
    @IBOutlet weak var childrenLBL: UILabel!
    @IBOutlet weak var statusLBL: UILabel!
    @IBOutlet weak var generalDietLBL: UILabel!
    @IBOutlet weak var exerciseLBL: UILabel!
    
    var model: UserDataModel?
    var isSmoking: Bool = false
    var isAlcohol: Bool = false
    var maritalModel : MaritalStatusModel?
    var maritalID: Int?
    let maritalPickerView = UIPickerView()
    override func viewWillAppear(_ animated: Bool) {
        setLocalization()
    }
    func setLocalization(){
        jobLBL.text = "Job".localized
        jobTxt.placeholder = "Job".localized
        educationLBL.text = "Education".localized
        educationTxt.placeholder = "Education".localized
        smookingLBL.text = "Smooking".localized
        alcoholLBL.text = "Alcohol Consumption".localized
        yesLBL.text = "Yes".localized
        noLBL.text = "No".localized
        noAlcoholLBL.text = "No".localized
        yesAlCoholLBL.text = "Yes".localized
        statusLBL.text = "Marital Status".localized
        maritalStatusTxt.placeholder = "Marital Status".localized
        childrenLBL.text = "Children".localized
        childrenTxt.placeholder = "Children".localized
        generalDietLBL.text = "General Diet".localized
        generalDietTxt.placeholder = "General Diet".localized
        exerciseLBL.text = "Exercise".localized
        exercideTxt.placeholder = "Exercise".localized
        saveBtn.setTitle("Save".localized, for: .normal)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.ShadowView(view: mainView, radius: 20, opacity: 0.4, shadowRadius: 4, color: UIColor.black.cgColor)
        self.navigationItem.title = "Edit Social History".localized
        setData()
        setUpPicker()
        getMarital()
    }
    func setUpPicker(){
        maritalPickerView.dataSource = self
        maritalPickerView.delegate = self
        maritalStatusTxt.inputView = maritalPickerView
        createDoneBtn(for: maritalStatusTxt)
    }
    func  setData(){
        if model?.message?.tblPatientSocialHistory?.count != 0 {
            if  model?.message?.tblPatientSocialHistory?[0] != nil{
                let data = model?.message?.tblPatientSocialHistory?[0]
                jobTxt.text = data?.job
                educationTxt.text = data?.education
                maritalStatusTxt.text = "\(data?.maritalStatusFk ?? 0)"
                maritalID = data?.maritalStatusFk
                childrenTxt.text = "\(data?.childerenNum ?? 0)"
                generalDietTxt.text = data?.generalDite
                exercideTxt.text = data?.exercise
                if  data?.isSmoke == true {
                    isSmoking = true
                    changeImage(selectedImage: yesSmokingImage, unSelectedImage: noSmokingImage)
                }else{
                    isSmoking = false
                    changeImage(selectedImage: noSmokingImage, unSelectedImage: yesSmokingImage)
                }
                if data?.alcoholConsumption == true {
                    isAlcohol = true
                    changeImage(selectedImage: yesAlcoholImage, unSelectedImage: noAlcoholImage)
                }else{
                    isAlcohol = false
                    changeImage(selectedImage: noAlcoholImage, unSelectedImage: yesAlcoholImage)
                }
            }
        }

    }
    
    @IBAction func yesSmoking_CLick(_ sender: Any) {
        isSmoking = true
        changeImage(selectedImage: yesSmokingImage, unSelectedImage: noSmokingImage)
    }
    @IBAction func noSmoking_CLick(_ sender: Any) {
        isSmoking = false
        changeImage(selectedImage: noSmokingImage, unSelectedImage: yesSmokingImage)
    }
    @IBAction func yesAlcohol_CLick(_ sender: Any) {
        isAlcohol = true
        changeImage(selectedImage: yesAlcoholImage, unSelectedImage: noAlcoholImage)
    }
    @IBAction func noAlcohol_Click(_ sender: Any) {
        isAlcohol = false
        changeImage(selectedImage: noAlcoholImage, unSelectedImage: yesAlcoholImage)
    }
    @IBAction func save_CLick(_ sender: Any) {
        validationinput()
    }
    func changeImage(selectedImage: UIImageView, unSelectedImage: UIImageView){
        UIView.animate(withDuration: 1) {
            selectedImage.image = #imageLiteral(resourceName: "ic_radiobtn_active")
            unSelectedImage.image = #imageLiteral(resourceName: "ic_radiobtn_unactive")
            self.view.layoutIfNeeded()
        }
    }
}
