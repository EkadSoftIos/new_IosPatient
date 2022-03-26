//
//  AddDieseasesVC.swift
//  E4 Patient
//
//  Created by mohab on 19/01/2021.
//

import UIKit
import TransitionButton
class AddDieseasesVC: UIViewController,UITextViewDelegate, UISearchBarDelegate {
    @IBOutlet var mainView: UIView!
    @IBOutlet var dieseasNameTxt: UITextField!
    @IBOutlet var diagnosedTxt: TextField!
    @IBOutlet var statusTxt: UITextField!
  //  @IBOutlet var treatedTxt: UITextField!
    @IBOutlet var medicationTxt: UITextField!
    @IBOutlet var notesTxt: UITextView!
    @IBOutlet var saveBtn: TransitionButton!
    @IBOutlet var doctorsTableView: UITableView!
    @IBOutlet var doctorsView: UIView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var doctorsViewHeight: NSLayoutConstraint!
    @IBOutlet var mainViewHeight: NSLayoutConstraint!
    
    var model: UserDataModel?
    var Delegete: AddDieseases?
    var isUpdate: Bool = false
    var updateData: TblPatientDisease?
    let diesesPickerView = UIPickerView()
    let datePicker = UIDatePicker()
    var DieseasesModel: getDieseasesModel?
    var dieseasID: Int = 0
    var medicationID: Int?
    let medicationPickerView = UIPickerView()
    var medicationModel : getAllMedicineModel?
    let statusPickerView = UIPickerView()
    var statusModel : DiseaseStatusModel?
    var statusID: Int?
    var dianosedDate: Date?
    var searchArr = [GetDoctorsMessage]()
    var doctorId: Int = 0
    var doctorsModel: GetDoctorsModel?
    override func viewWillAppear(_ animated: Bool) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.compatibleSearchTextField.textColor = UIColor.black
        searchBar.compatibleSearchTextField.backgroundColor = UIColor.white
        mainView.ShadowView(view: mainView, radius: 20, opacity: 0.4, shadowRadius: 4, color: UIColor.black.cgColor)
        doctorsView.ShadowView(view: doctorsView, radius: 10, opacity: 0.4, shadowRadius: 4, color: UIColor.lightGray.cgColor)
        notesTxt.text = "notes"
        notesTxt.textColor = UIColor.lightGray
        notesTxt.delegate = self
        setData()
        setUppicker()
        showDatePicker()
        getDieseases()
        getMedication()
        getstatus()
        setDoctorsView()
        SetUpTableView()
        getDoctors()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.setDoctorsView()
        }else{
        searchArr = searchText.isEmpty ? doctorsModel?.message ?? []: doctorsModel?.message.filter { (item: (GetDoctorsMessage)) -> Bool in
            return item.employeeName.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            
        } ?? []
            self.setDoctorsView(isShow: false, height: 550, ViewHeight: 150)
            self.doctorsTableView.reloadData()
            self.view.layoutIfNeeded()
            doctorsTableView.reloadData()
        }
        
    }
    func setUppicker(){
//        if #available(iOS 14.0, *)
//        {
//            datePicker.preferredDatePickerStyle = .wheels
//        }
        diesesPickerView.dataSource = self
        diesesPickerView.delegate = self
        dieseasNameTxt.inputView = diesesPickerView
        createDoneBtn(for: dieseasNameTxt)
        medicationPickerView.dataSource = self
        medicationPickerView.delegate = self
        medicationTxt.inputView = medicationPickerView
        createDoneBtn(for: medicationTxt)
        statusPickerView.dataSource = self
        statusPickerView.delegate = self
        statusTxt.inputView = statusPickerView
        createDoneBtn(for: statusTxt)
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
    func setDoctorsView(isShow: Bool = true, height: CGFloat = 400, ViewHeight: CGFloat = 0){
        UIView.animate(withDuration: 1) {
            self.doctorsView.isHidden = isShow
            self.doctorsTableView.isHidden = isShow
            self.mainViewHeight.constant = height
            self.doctorsViewHeight.constant = ViewHeight
            self.view.layoutIfNeeded()
        }
  
}
    func setData(){
        if isUpdate == true{
            dieseasID = updateData?.diseaseFk ?? 0
            statusID = updateData?.diseaseStatusFk ?? 0
            dieseasNameTxt.text = String(updateData?.diseaseFk ?? 0)
            diagnosedTxt.text = self.GetFormatedDate(date_string: updateData?.diagonsedDate ?? "", dateFormat: "yyyy-MM-dd'T'HH:mm:ss")
            statusTxt.text = String(updateData?.diseaseStatusFk ?? 0)
            searchBar.text = updateData?.doctorName
            medicationTxt.text = updateData?.medicationIDS
            notesTxt.text = updateData?.notes
            notesTxt.textColor = UIColor.black
            self.navigationItem.title = "Edit Diseases".localized
            

        }else{
            self.navigationItem.title = "Add Diseases".localized
        }
    }
    
    func SetUpTableView(){
        doctorsTableView.register(DoctorsSearchCell.nib, forCellReuseIdentifier: "doctorsCell")
        doctorsTableView.separatorStyle = .none
        doctorsTableView.delegate = self
        doctorsTableView.dataSource = self
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
    
}
protocol AddDieseases {
    func Data(isAdded: Bool)
}
