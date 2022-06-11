//
//  AddFamilyHistoryPicker.swift
//  E4 Patient
//
//  Created by mohab on 13/03/2021.
//

import Foundation
import UIKit
extension AddFamilyHistoryVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return RelationModel?.message?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return RelationModel?.message?[row].relationNameEn ?? ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        relationID = RelationModel?.message?[row].relationID
        print("ID:\(RelationModel?.message?[row].relationID) ")
        relationTxt.text = RelationModel?.message?[row].relationNameEn
    }
}
