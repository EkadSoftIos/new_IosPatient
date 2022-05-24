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
    
    @IBOutlet weak var allerNameLBL: UILabel!
    @IBOutlet weak var triggeredLBL: UILabel!
    @IBOutlet weak var howOftenLBL: UILabel!
    @IBOutlet weak var firstDiagLBL: UILabel!
    @IBOutlet weak var medicationLBL: UILabel!
    @IBOutlet weak var additionLBL: UILabel!
    let regularFont = UIFont.systemFont(ofSize: 16)
    let boldFont = UIFont.boldSystemFont(ofSize: 16)

    
    var Delegete: addAllergies?
    var medicationModel : getAllMedicineModel?
    var medicationID = [String]()
    var medicationIDsString = ""

    let medicationPickerView = UIPickerView()
    let datePicker = UIDatePicker()
    var isUpdate: Bool?
    var updateData: TblPatientAllergy?
    override func viewWillAppear(_ animated: Bool) {
        setLocalization()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addtionalTxt.text = "Notes".localized
        addtionalTxt.textColor = UIColor.lightGray
        addtionalTxt.delegate = self
        SetData()
        getMedication()
        setUpPicker()
        showDatePicker()
        mainView.ShadowView(view: mainView, radius: 20, opacity: 0.4, shadowRadius: 4, color: UIColor.black.cgColor)
      
    }
    func setLocalization(){
        allerNameLBL.text = "Allergies Name *".localized
        nameTxt.placeholder = "Allergies Name *".localized
        triggeredLBL.text = "Triggered by".localized
        triggeredTxt.placeholder = "Triggered by".localized
        howOftenLBL.text = "How often does it occur?".localized
        howTxt.placeholder = "How often does it occur?".localized
        firstDiagLBL.text = "First diagnosed on".localized
        firstTxt.placeholder = "First diagnosed on".localized
        medicationLBL.text = "Medication".localized
        medicationTxt.placeholder = "Medication".localized
        additionLBL.text = "Additional Notes".localized
        saveBtn.setTitle("Save".localized, for: .normal)
        
    }
    func SetData(){
        if isUpdate == true {
//            medicationID = updateData?.patientAllergiesID
        nameTxt.text = updateData?.allergiesName
        triggeredTxt.text = updateData?.allergiesTriggeredBy
        howTxt.text = updateData?.allergiesOccuered
        firstTxt.text = self.GetFormatedDate(date_string: updateData?.allergiesFiristDiagonsed ?? "", dateFormat: "yyyy-MM-dd'T'HH:mm:ss")
//        medicationTxt.text = updateData?.medicationIDS
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
            textView.text = "Notes".localized
            textView.textColor = UIColor.lightGray
        }
    }

    @IBAction func save_Click(_ sender: Any) {
      validationinput()
    }
    @IBAction func openFruitsPickerAction(_ sender:UIButton) {
        let blueColor = sender.backgroundColor
        
        let blueAppearance = YBTextPickerAppearanceManager.init(
            pickerTitle         : "Medication".localized,
            titleFont           : boldFont,
            titleTextColor      : .black,
            titleBackground     : .clear,
            searchBarFont       : regularFont,
            searchBarPlaceholder: "Select Medication",
            closeButtonTitle    : "Cancel",
            closeButtonColor    : .darkGray,
            closeButtonFont     : regularFont,
            doneButtonTitle     : "Done",
            doneButtonColor     : blueColor,
            doneButtonFont      : boldFont,
            checkMarkPosition   : .Right,
            itemCheckedImage    : UIImage(named:"blue_ic_checked"),
            itemUncheckedImage  : UIImage(),
            itemColor           : .black,
            itemFont            : regularFont
        )
        var nameArray : [String] = []
        var idArray : [Int] = []
        for i in medicationModel?.message ?? []{
            nameArray.append(i.medicationName ?? "")
            idArray.append(i.medicationID ?? 0)
        }
        let fruits = nameArray
        let picker = YBTextPicker.init(with: fruits, appearance: blueAppearance,
                                       onCompletion: { (selectedIndexes, selectedValues) in
                                        if selectedValues.count > 0{
                                            
                                            var values = [String]()
                                            for index in selectedIndexes{
                                                values.append(fruits[index])
                                                self.medicationID.append("\(idArray[index])")
                                            }
                                            
//                                            self.btnFruitsPicker.setTitle(values.joined(separator: ", "), for: .normal)
                                            self.medicationTxt.text = values.joined(separator: ",")
                                            self.medicationIDsString = self.medicationID.joined(separator: ",")
                                        }else{
//                                            self.btnFruitsPicker.setTitle("Select Fruits", for: .normal)
                                            self.medicationTxt.placeholder = "Medication".localized
                                        }
        },
                                       onCancel: {
                                        print("Cancelled")
        }
        )
        
//        if let title = btnFruitsPicker.title(for: .normal){
        if let title = self.medicationTxt.text {
            if title.contains(","){
                picker.preSelectedValues = title.components(separatedBy: ",")
            }
        }
        picker.allowMultipleSelection = true
        
        picker.show(withAnimation: .Fade)
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
