//
//  AddSocialHistoryPicker.swift
//  E4 Patient
//
//  Created by mohab on 13/03/2021.
//

import Foundation
import UIKit
extension AddSocialHistoryVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return maritalModel?.message.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return maritalModel?.message[row].maritalStatusNameEn ?? ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        maritalID = maritalModel?.message[row].maritalStatusID
        maritalStatusTxt.text = maritalModel?.message[row].maritalStatusNameEn
    }
}
