//
//  AddEmergencyPicker.swift
//  E4 Patient
//
//  Created by mohab on 07/03/2021.
//

import Foundation
import UIKit
extension AddEmergencyVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == countryPickerView {
            return citysmodel?.message?.count ?? 0
        }
        else if pickerView == citiesPickerView {
            return citysmodel?.message?[selectedCountryIndex ?? 0].lookupCity?.count ?? 0
        }else if pickerView == relationPickerView{
            return RelationModel?.message?.count ?? 0
        }
        else {
            return citysmodel?.message?[selectedCountryIndex ?? 0].lookupCity?[selectedCityIndex ?? 0].lookupArea?.count ?? 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == countryPickerView {
            return citysmodel?.message?[row].countryNameEn ?? ""
        }
        else if pickerView == citiesPickerView {
            return citysmodel?.message?[selectedCountryIndex ?? 0].lookupCity?[row].cityNameEn ?? ""
        }else if pickerView == relationPickerView{
            return RelationModel?.message?[row].relationNameEn ?? ""
        }
        else {
            return citysmodel?.message?[selectedCountryIndex ?? 0].lookupCity?[selectedCityIndex ?? 0].lookupArea?[row].areaNameEn ?? ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == countryPickerView {
            selectedCountryIndex = row
            countryImage.isHidden = false
            countryId = citysmodel?.message?[selectedCountryIndex ?? 0].countryID ?? 0
            countryTxt.text = citysmodel?.message?[selectedCountryIndex ?? 0].countryNameEn ?? ""
            cityTxt.text = ""
            areaTxt.text = ""
        }
        else if pickerView == citiesPickerView {
            selectedCityIndex = row
            CityId = citysmodel?.message?[selectedCountryIndex ?? 0].lookupCity?[selectedCityIndex ?? 0].cityID ?? 0
            cityTxt.text = citysmodel?.message?[selectedCountryIndex ?? 0].lookupCity?[selectedCityIndex ?? 0].cityNameEn ?? ""
            areaTxt.text = ""
        }else if pickerView == relationPickerView{
            relationID = RelationModel?.message?[row].relationID
            relationTxt.text = RelationModel?.message?[row].relationNameEn
        }
        else {
            selectedAreaIndex = row
            if citysmodel?.message?[selectedCountryIndex ?? 0].lookupCity?[selectedCityIndex ?? 0].lookupArea?.count != 0{
            AreaID = citysmodel?.message?[selectedCountryIndex ?? 0].lookupCity?[selectedCityIndex ?? 0].lookupArea?[selectedAreaIndex ?? 0].areaID ?? 0
            areaTxt.text = citysmodel?.message?[selectedCountryIndex ?? 0].lookupCity?[selectedCityIndex ?? 0].lookupArea?[selectedAreaIndex ?? 0].areaNameEn ?? ""
            }
        }
    }
}
