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
//        //Formate Date
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
        birthDate = datePicker.date
        self.view.endEditing(true)
//        dateFrom = date
//        self.delegate?.sendDate(fDate: dateFrom ?? "", tDate: dateTo ?? "")
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

extension EditProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK:- imagePickerController
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let images = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            self.profileImage.image = images
            guard let file = images.jpegData(compressionQuality: 0.2) else { return  }
            
            uploadImage(file: file)
//            presenter.uploadImage(file: Data)(file: Data)(file: Data)
         }
        
        picker.dismiss(animated: true, completion: nil)
    }
    func uploadImage(file: Data){
        isProfileImage = true
        imageInstance.presentImagePicker()
//        imageInstance.imageSelected = {[weak self] selectedImage in
//            guard let self = self else {return}
            
        self.userImage.append(UploadDataa(data: (self.profileImage.image?.jpegData(compressionQuality: 0.1)!)!, Key: "PatientProfileImage"))
//            self.profileImage.image = selectedImage

            if let token = self.token as? String {
                self.headers["Authorization"] = "Bearer \(token)"
            }
            showUniversalLoadingView(true)
            AlamofireMultiPart.PostMultiWithModel(model: SuccessModelImage.self,
                                                  url: "\(Constants.baseURL)Common/FormDataUpload",
                                                  Images: self.userImage ,
                                                  header: self.headers,
                                                  parameters: nil,
                                                  completion: self.ProfileImageNetwork)
        }
    
    //MARK: Choose Photo Actions
    
     func choosePhoto() {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source".localized, message: "Choose Source".localized, preferredStyle: .actionSheet)
        let cameraAction = (UIAlertAction(title: "Camera".localized, style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }else{
                print("Camera not available")
            }
            
        }))
//        let image = UIImage(named: "ic_Error")
//        cameraAction.setValue(image, forKey: "image")
        actionSheet.addAction(cameraAction)
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library".localized, style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
                let image = UIImagePickerController()
                image.delegate = self
                
                image.sourceType = UIImagePickerController.SourceType.photoLibrary
                
                image.allowsEditing = false
                
                self.present(image, animated: true)
            
        })
        actionSheet.addAction(photoLibraryAction)
        actionSheet.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}
