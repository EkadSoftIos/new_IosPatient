//
//  AddSurgeryVC.swift
//  E4 Patient
//
//  Created by mohab on 23/01/2021.
//

import UIKit
import TransitionButton
class AddSurgeryVC: UIViewController,UITextViewDelegate, UISearchBarDelegate {
    @IBOutlet var mainView: UIView!
    @IBOutlet var nameTxt: UITextField!
    @IBOutlet var implantsTxt: UITextField!
    @IBOutlet var dateTxt: UITextField!
   // @IBOutlet var byTxt: UITextField!
    @IBOutlet var searchViewHeight: NSLayoutConstraint!
    @IBOutlet var searchView: UIView!
    @IBOutlet var searchTable: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var notesTxt: UITextView!
    @IBOutlet var saveBtn: TransitionButton!
    @IBOutlet var mainViewHeight: NSLayoutConstraint!
    var Delegete: AddSurgery?
    var model: UserDataModel?
    var isUpdate: Bool?
    var searchArr = [GetDoctorsMessage]()
    var SurgeryData: TblPatientSurgery?
    var doctorsModel: GetDoctorsModel?
    let datePicker = UIDatePicker()
    override func viewWillAppear(_ animated: Bool) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.ShadowView(view: mainView, radius: 20, opacity: 0.4, shadowRadius: 4, color: UIColor.black.cgColor)
        searchBar.delegate = self
        searchBar.backgroundColor = .white
        searchBar.layer.borderColor = UIColor.lightGray.cgColor
        searchBar.compatibleSearchTextField.textColor = UIColor.black
        searchBar.compatibleSearchTextField.backgroundColor = UIColor.white
        notesTxt.text = "notes"
        notesTxt.textColor = UIColor.lightGray
        notesTxt.delegate = self
        searchView.ShadowView(view: searchView, radius: 10, opacity: 0.4, shadowRadius: 4, color: UIColor.lightGray.cgColor)
        showDatePicker()
        setData()
        SetUpTableView()
        setDoctorsView()
        getDoctors()
    }
   
    func SetUpTableView(){
        searchTable.register(DoctorsSearchCell.nib, forCellReuseIdentifier: "doctorsCell")
        searchTable.separatorStyle = .none
        searchTable.delegate = self
        searchTable.dataSource = self
    }
    func setDoctorsView(isShow: Bool = true, height: CGFloat = 400, ViewHeight: CGFloat = 0){
        UIView.animate(withDuration: 1) {
            self.searchView.isHidden = isShow
            self.searchTable.isHidden = isShow
            self.mainViewHeight.constant = height
            self.searchViewHeight.constant = ViewHeight
            self.view.layoutIfNeeded()
        }
  
}
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.setDoctorsView()
        }else{
        searchArr = searchText.isEmpty ? doctorsModel?.message ?? []: doctorsModel?.message.filter { (item: (GetDoctorsMessage)) -> Bool in
            return item.employeeName.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            
        } ?? []
            if searchArr.count != 0{
            self.setDoctorsView(isShow: false, height: 550, ViewHeight: 150)
            self.searchTable.reloadData()
            self.view.layoutIfNeeded()
            searchTable.reloadData()
            }else{
                self.setDoctorsView()
            }
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
            textView.text = "notes"
            textView.textColor = UIColor.lightGray
        }
    }
    func setData(){
        if isUpdate == true {
            self.navigationItem.title = "Edit Surgery".localized
            nameTxt.text = SurgeryData?.patientSurgeryName
            implantsTxt.text = SurgeryData?.addingData ?? ""
            dateTxt.text = self.GetFormatedDate(date_string: SurgeryData?.patientSurgeryDate ?? "", dateFormat: "yyyy-MM-dd'T'HH:mm:ss")
            searchBar.text = SurgeryData?.doctorName
            notesTxt.text = SurgeryData?.notes
            if SurgeryData?.notes != ""{
                notesTxt.textColor = .black
            }
        }else{
            self.navigationItem.title = "Add Surgery".localized
        }
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
    @IBAction func save_Click(_ sender: Any) {
        validationinput()
    }
    


}
protocol AddSurgery {
    func Data(isAdded: Bool)
}
