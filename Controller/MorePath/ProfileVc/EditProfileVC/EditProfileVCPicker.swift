//
//  EditProfileVCPicker.swift
//  E4 Patient
//
//  Created by Zyad Galal on 27/02/2021.
//

import UIKit


extension EditProfileVC: UIPickerViewDataSource, UIPickerViewDelegate {
    //MARK:-date picker
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        dateTxt.inputAccessoryView = toolbar
        dateTxt.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dateTxt.text = formatter.string(from: datePicker.date)
        birthDate = datePicker.date
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }    
    //MARK:- gender Picker
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if isBlodPicker == true{
            return self.blodModel?.message.count ?? 0
        }else{
            return self.genderArr.count
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if isBlodPicker == true{
            return self.blodModel?.message[row].blodGroupNameEn
        }else{
            return self.genderArr[row].0
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if isBlodPicker == true {
            self.bloodTxt.text = self.blodModel?.message[row].blodGroupNameEn
            self.BlodID = self.blodModel?.message[row].blodGroupID ?? 0
        }else{
            self.genderTxt.text = self.genderArr[row].0
            self.genderType = self.genderArr[row].1
        }
    }
}
extension EditProfileVC: ToolbarPickerViewDelegate {
    func didTapDone() {
        if isBlodPicker == true {
            let row = self.pickerView.selectedRow(inComponent: 0)
            self.pickerView.selectRow(row, inComponent: 0, animated: true)
            if blodModel?.message.count == 0 {
                self.genderTxt.resignFirstResponder()
            }else{
                self.bloodTxt.text = self.blodModel?.message[row].blodGroupNameEn
                self.BlodID = self.blodModel?.message[row].blodGroupID ?? 0
                self.bloodTxt.resignFirstResponder()
            }
        }else{
            let row = self.pickerView.selectedRow(inComponent: 0)
            self.pickerView.selectRow(row, inComponent: 0, animated: true)
            if genderArr.isEmpty {
                self.genderTxt.resignFirstResponder()
            }else{
                self.genderTxt.text = self.genderArr[row].0
                self.genderType = self.genderArr[row].1
                self.genderTxt.resignFirstResponder()
            }
        }
    }
    func didTapCancel() {
        self.genderTxt.text = nil
        self.genderTxt.resignFirstResponder()
    }
}

