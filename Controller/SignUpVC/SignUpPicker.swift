//
//  SignUpPicker.swift
//  E4 Patient
//
//  Created by mohab on 25/02/2021.
//

import UIKit
extension SignUpVC: UIPickerViewDataSource, UIPickerViewDelegate {
    //MARK:-date picker
    func showDatePicker(){
        datePicker.datePickerMode = .date
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
        self.view.endEditing(true)
    }
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    func uploadImage(){
        imageInstance.presentImagePicker()
        imageInstance.imageSelected = {[weak self] selectedImage in
            guard let self = self else {return}
            self.profileImage.image = selectedImage
            self.userImage.append(UploadDataa(data: selectedImage.jpegData(compressionQuality: 0.1)!, Key: "personal_image"))
            AlamofireMultiPart.PostMultiWithModel(model: SuccessModelImage.self,
                                                  url: "\(Constants.baseURL)Common/FormDataUpload",
                                                  Images: self.userImage ,
                                                  header: self.headers,
                                                  parameters: nil,
                                                  completion: self.ProfileImageNetwork)
        }
    }
    //MARK:- gender Picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.genderArr.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return self.genderArr[row].0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.genderTxt.text = self.genderArr[row].0
    }
}
extension SignUpVC: ToolbarPickerViewDelegate {
    func didTapDone() {
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
    func didTapCancel() {
        self.genderTxt.text = nil
        self.genderTxt.resignFirstResponder()
    }
}
