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
//        datePicker.datePickerMode = .date
//        let toolbar = UIToolbar();
//        toolbar.sizeToFit()
//        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
//        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
//        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
//        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
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
        self.userImage.append(UploadDataa(data: (self.profileImage.image?.jpegData(compressionQuality: 0.1)!)!, Key: "personal_image"))
            AlamofireMultiPart.PostMultiWithModel(model: SuccessModelImage.self,
                                                  url: "\(Constants.baseURL)Common/FormDataUpload",
                                                  Images: self.userImage ,
                                                  header: self.headers,
                                                  parameters: nil,
                                                  completion: self.ProfileImageNetwork)
        
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
extension SignUpVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK:- imagePickerController
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let images = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            self.profileImage.image = images
            guard let file = images.jpegData(compressionQuality: 0.2) else { return  }
            uploadImage()
//            presenter.uploadImage(file: file)
         }
        
        picker.dismiss(animated: true, completion: nil)
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
