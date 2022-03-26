//
//  AddAllergiesVC.swift
//  E4 Patient
//
//  Created by mohab on 23/01/2021.
//

import UIKit
import TransitionButton
class AddAllergiesVC: UIViewController,UITextViewDelegate {
    @IBOutlet var mainView: UIView!
    @IBOutlet var nameTxt: UITextField!
    @IBOutlet var triggeredTxt: UITextField!
    @IBOutlet var howTxt: UITextField!
    @IBOutlet var firstTxt: TextField!
    @IBOutlet var medicationTxt: UITextField!
    @IBOutlet var addtionalTxt: UITextView!
    @IBOutlet var saveBtn: TransitionButton!
    var Delegete: addAllergies?
    var medicationModel : getAllMedicineModel?
    var medicationID: Int?
    let medicationPickerView = UIPickerView()
    let datePicker = UIDatePicker()
    var isUpdate: Bool?
    var updateData: TblPatientAllergy?
    override func viewWillAppear(_ animated: Bool) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addtionalTxt.text = "notes"
        addtionalTxt.textColor = UIColor.lightGray
        addtionalTxt.delegate = self
        SetData()
        getMedication()
        setUpPicker()
        showDatePicker()
        mainView.ShadowView(view: mainView, radius: 20, opacity: 0.4, shadowRadius: 4, color: UIColor.black.cgColor)
      
    }
    func SetData(){
        if isUpdate == true {
            medicationID = updateData?.patientAllergiesID
        nameTxt.text = updateData?.allergiesName
        triggeredTxt.text = updateData?.allergiesTriggeredBy
        howTxt.text = updateData?.allergiesOccuered
        firstTxt.text = self.GetFormatedDate(date_string: updateData?.allergiesFiristDiagonsed ?? "", dateFormat: "yyyy-MM-dd'T'HH:mm:ss")
        medicationTxt.text = updateData?.medicationIDS
        addtionalTxt.text = updateData?.notes
        self.navigationItem.title = "Edit Allergies".localized
            if updateData?.notes != "" {
                addtionalTxt.textColor = .black
            }
        }else{
            self.navigationItem.title = "Add Allergies".localized
        }
    }
    
    func setUpPicker(){
        medicationPickerView.dataSource = self
        medicationPickerView.delegate = self
        medicationTxt.inputView = medicationPickerView
        createDoneBtn(for: medicationTxt)
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "notes"
            textView.textColor = UIColor.lightGray
        }
    }

    @IBAction func save_Click(_ sender: Any) {
      validationinput()
    }
    func GetFormatedDate(date_string:String,dateFormat:String)-> String{

       let dateFormatter = DateFormatter()
       dateFormatter.locale = Locale(identifier: "en_US_POSIX")
       dateFormatter.dateFormat = dateFormat

       let dateFromInputString = dateFormatter.date(from: date_string)
       dateFormatter.dateFormat = "yyyy-MM-dd"
       if(dateFromInputString != nil){
           return dateFormatter.string(from: dateFromInputString!)
       }
       else{
           debugPrint("could not convert date")
           return ""
       }
   }
}
protocol addAllergies {
    func Data(isAdded: Bool)
}
