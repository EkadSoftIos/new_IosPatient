//
//  AddFamilyHistoryVC.swift
//  E4 Patient
//
//  Created by mohab on 23/01/2021.
//

import UIKit
import TransitionButton
class AddFamilyHistoryVC: UIViewController,UITextViewDelegate {
    @IBOutlet var relationTxt: UITextField!
    @IBOutlet var notesTxt: UITextView!
    @IBOutlet var saveBtn: TransitionButton!
    @IBOutlet var mainView: UIView!
    var model: UserDataModel?
    var isUpdate: Bool?
    var SocialID: Int = 0
    var updateData: TblPatientSocialFamily?
    var Delegete: AddFamily?
    var RelationModel : getRelationsModel?
    var relationID: Int?
    let relationPickerView = UIPickerView()
    override func viewWillAppear(_ animated: Bool) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.ShadowView(view: mainView, radius: 20, opacity: 0.4, shadowRadius: 4, color: UIColor.black.cgColor)
        
        notesTxt.text = "notes"
        notesTxt.textColor = UIColor.lightGray
        notesTxt.delegate = self
        setUpPicker()
        getRlations()
        
        if isUpdate == true {
            setData()
            self.navigationItem.title = "Edit Family History".localized
        }else{
            print("New History")
            self.navigationItem.title = "Add Family History".localized
        }
    }
    func setUpPicker(){
        relationPickerView.dataSource = self
        relationPickerView.delegate = self
        relationTxt.inputView = relationPickerView
        createDoneBtn(for: relationTxt)
    
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
        relationTxt.text = updateData?.relationNameLocalized
        notesTxt.text = updateData?.notes
        relationID = updateData?.relationFk ?? 0
        if updateData?.notes != ""{
            notesTxt.textColor = .black
        }
    }
    
    @IBAction func save_Click(_ sender: Any) {
        validationinput()
        
    }
    

}
protocol AddFamily {
    func Data(isAdded: Bool)
}
