//
//  AddMedicalReportsPicker.swift
//  E4 Patient
//
//  Created by mohab on 13/03/2021.
//

import UIKit
extension AddMedicalReportsVC {
    
    //MARK:-date picker
    func showDatePicker(){
//        if #available(iOS 14.0, *)
//        {
//            datePicker.preferredDatePickerStyle = .wheels
//        }
        //Formate Date
//        datePicker.datePickerMode = .date
//
//        //ToolBar
//        let toolbar = UIToolbar();
//        toolbar.sizeToFit()
//        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
//        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
//        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
//
//        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
//
//        dateTxt.inputAccessoryView = toolbar
//        dateTxt.inputView = datePicker
        
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .date
        dateTxt.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)

        
    }
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: sender.date)
        dateTxt.text = date
//        self.view.endEditing(true)
//        dateFrom = date
//        self.delegate?.sendDate(fDate: dateFrom ?? "", tDate: dateTo ?? "")
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
//        imageInstance.presentImagePicker()
//        imageInstance.imageSelected = {[weak self] selectedImage in
//            guard let self = self else {return}
//            self.profileImage.image = selectedImage
        self.userImage.append(UploadDataa(data: (self.resultImage.image?.jpegData(compressionQuality: 0.1)!)!, Key: "personal_image"))
            AlamofireMultiPart.PostMultiWithModel(model: SuccessModelImage.self,
                                                  url: "\(Constants.baseURL)Common/FormDataUpload",
                                                  Images: self.userImage ,
                                                  header: self.headers,
                                                  parameters: nil,
                                                  completion: self.ProfileImageNetwork)
        
    }
}
