//
//  PermissionPickerView.swift
//  E4 Patient
//
//  Created by mohab on 15/03/2021.
//

import UIKit
extension PermissionVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == entityPickerView {
            return entityModel?.message?.count ?? 0
        }
        else if pickerView == MainSpecialityPickerView {
            return specialityModel?.message?.count ?? 0
        }else {
            if selectedentityIndex != nil{
                return doctorModel?.message?.count ?? 0
            }else{
                return allDoctorsModel?.message.count ?? 0
            }
            
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == entityPickerView {
            return entityModel?.message?[row].entityNameLocalized ?? ""
        }
        else if pickerView == MainSpecialityPickerView {
            return specialityModel?.message?[row].specialityNameEn ?? ""
        }else {
            if selectedentityIndex != nil{
                return doctorModel?.message?[row].employeeName ?? ""
            }else{
                return allDoctorsModel?.message[row].employeeName ?? ""
            }
           
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == entityPickerView {
            selectedentityIndex = entityModel?.message?[row].businessProviderID
            entityTxt.text = entityModel?.message?[row].entityNameLocalized
            self.callApisbussinesId(id: entityModel?.message?[row].businessProviderID ?? 0)
        }
        else if pickerView == MainSpecialityPickerView {
            selectedspecialtyIndex = specialityModel?.message?[row].specialityID
            mainSpecialityTxt.text = specialityModel?.message?[row].specialityNameEn
        }
        else {
            
            if selectedentityIndex != nil{
        selecteddoctorIndex = doctorModel?.message?[row].businessProviderEmployeeID ?? 0
                healthText = doctorModel?.message?[row].employeeName ?? ""
            print("nameeee\(healthText)")
               ///     "\(healthCareTxt.text ?? ""), \()"
                self.helthID = "\(doctorModel?.message?[row].businessProviderEmployeeID ?? 0)"
                  ///  "\(Ids),\(doctorModel?.message?[row].businessProviderEmployeeID ?? 0)"
             //   setUpText()
              }else{
                selecteddoctorIndex = allDoctorsModel?.message[row].businessProviderEmployeeID ?? 0
                healthText = "\(allDoctorsModel?.message[row].employeeName ?? "")"
                //\(healthCareTxt.text ?? ""),
                self.Ids = "\(Ids),\(allDoctorsModel?.message[row].businessProviderEmployeeID ?? 0)"
                //setUpText()
            }
        }
    }
}

