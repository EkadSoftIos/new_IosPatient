//
//  CountinueAddMedicationPicker.swift
//  E4 Patient
//
//  Created by mohab on 09/03/2021.
//

import Foundation
import UIKit
extension CountinueAddMedicationVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == whenPickerView {
            return whenModel?.message?.count ?? 0
        }
        else {
            return durationArr.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == whenPickerView {
            return whenModel?.message?[row].whenMedicationTakenNameEn ?? ""
        }else {
            return durationArr[row].0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == whenPickerView {
            whenId = whenModel?.message?[row].whenMedicationTakenID ?? 0
            whenTxt.text = whenModel?.message?[row].whenMedicationTakenNameEn ?? ""
        }else {
            duratiionId = durationArr[row].1
            durantionType = durationArr[row].2
            durationTxt.text = durationArr[row].0

        }
    }
}

