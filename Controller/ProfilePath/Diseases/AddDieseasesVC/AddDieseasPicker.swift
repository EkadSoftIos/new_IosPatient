//
//  AddDieseasPicker.swift
//  E4 Patient
//
//  Created by mohab on 27/02/2021.
//

import Foundation
import UIKit
extension AddDieseasesVC: UIPickerViewDataSource, UIPickerViewDelegate {
    //MARK:-date picker
    func showDatePicker(){
        //Formate Date
//        datePicker.datePickerMode = .date
//        //ToolBar
//        let toolbar = UIToolbar();
//        toolbar.sizeToFit()
//        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
//        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
//        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
//        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
//        diagnosedTxt.inputAccessoryView = toolbar
//        diagnosedTxt.inputView = datePicker
        
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .date
        diagnosedTxt.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)

    }
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: sender.date)
        diagnosedTxt.text = date
//        self.view.endEditing(true)
//        dateFrom = date
//        self.delegate?.sendDate(fDate: dateFrom ?? "", tDate: dateTo ?? "")
    }
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        diagnosedTxt.text = formatter.string(from: datePicker.date)
        dianosedDate = datePicker.date
        self.view.endEditing(true)
    }
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    //MARK:- gender Picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == diesesPickerView{
            return self.DieseasesModel?.message.count ?? 0
        }else if pickerView == statusPickerView{
            return self.statusModel?.message.count ?? 0
        } else{
            return medicationModel?.message?.count ?? 0
        }
}   
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == diesesPickerView{
            return self.DieseasesModel?.message[row].diseaseNameEn
        }else if pickerView == statusPickerView{
            return statusModel?.message[row].diseaseStatusNameEn ?? ""
        }else {
            return medicationModel?.message?[row].medicationName ?? ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == diesesPickerView {
            self.dieseasID = self.DieseasesModel?.message[row].diseaseID ?? 0
            self.dieseasNameTxt.text = self.DieseasesModel?.message[row].diseaseNameEn
        }else if pickerView == statusPickerView{
            statusID = statusModel?.message[row].diseaseStatusID
            statusTxt.text = statusModel?.message[row].diseaseStatusNameEn
        }
        else{
//            medicationID = medicationModel?.message?[row].medicationID
//            medicationTxt.text = medicationModel?.message?[row].medicationName
        }
    }
}

