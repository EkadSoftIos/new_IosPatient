//
//  AddEmergencyNetwork.swift
//  E4 Patient
//
//  Created by mohab on 06/03/2021.
//

import Foundation
import UIKit
extension AddEmergencyVC{
    func validationinput(){
        if nameTxt.text!.isEmpty || relationTxt.text!.isEmpty  || phoneTxt.text!.isEmpty {
            self.showMessage(title: "", sub: "all data required", type: .error, layout: .messageView)
        }else{
            saveBtn.startAnimation()
            callApi()
        }
    }
    func callApi(){
       // "PatientContactId": 19,
        let parameters: [String: Any] = [
            "PatientContactId": updateData?.patientContactID ?? 0,
            "PatientFk": model?.message?.patientID ?? 0,
            "ContactName": nameTxt.text ?? "",
            "RelationFk": relationID ?? 0,
            "ContactMobileCode": "+20",
            "ContactMobile": phoneTxt.text ?? "",
            "ContactEmail": emailTxt.text ?? "",
            "ContactAddress": addressTxt.text ?? "",
            "ContactCountryFk": countryId,
            "ContactCityFk": CityId,
            "ContactAreaFk": AreaID
       ]
        
         print("params: \(parameters)")
          
        NetworkClient.performRequest(_type: SuccessModel.self, router: .AddEmergency(params: parameters)) { (result) in
            self.saveBtn.stopAnimation()
            switch result{
            case .success(let model):
                if model.successtate == 200{
                    self.showMessage(title: "", sub: model.message, type: .success, layout: .messageView)
                    self.successLogin()
                    Vibration.success.vibrate()
                }else{
                    self.showMessage(title: "", sub: model.errormessage, type: .error, layout: .messageView)
                }
            case .failure(let model):
                print("failure: \(model)")
            
            }
        }
    }
    func successLogin(){
        Delegete?.Data(isAdded: true)
        self.navigationController?.popViewController(animated: true)
    }
    func getRlations() {
        NetworkClient.performRequest(_type: getRelationsModel.self, router: .getRelations) { [weak self] (result) in
            guard let self = self else {return}
            showUniversalLoadingView(false)
            
            switch result {
            case .success(let model) :
                if model.successtate == 200 {
                    self.RelationModel = model
                    self.updateRelationUI()
                }
                else{
                    self.showAlertWith(msg: model.errormessage ?? "")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    func updateRelationUI() {
        relationPickerView.reloadComponent(0)
     
    }
    func getCountries() {
        NetworkClient.performRequest(_type: GetFullCitiesModel.self, router: .getAllCountries) { [weak self] (result) in
            guard let self = self else {return}
            showUniversalLoadingView(false)
            
            switch result {
            case .success(let model) :
                if model.successtate == 200 {
                    let countryID = self.updateData?.contactCountryFk ?? 0
                    let cityId = self.updateData?.contactCityFk ?? 0
                    let areaId = self.updateData?.contactAreaFk ?? 0
                    for i in model.message ?? []{
                        if countryID == i.countryID{
                            self.countryTxt.text = i.countryNameEn
                        }
                        for city in i.lookupCity ?? []{
                            if cityId == city.cityID{
                                self.cityTxt.text = city.cityNameEn
                            }
                            for area in city.lookupArea ?? [] {
                                if areaId == area.areaID{
                                    self.areaTxt.text = area.areaNameEn
                                }
                            }
                        }
                    }
                    self.citysmodel = model
                    self.updateUI()
                }
                else{
                    self.showAlertWith(msg: model.errormessage ?? "")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    func updateUI() {
        countryPickerView.reloadComponent(0)
        areaPickerView.reloadComponent(0)
        citiesPickerView.reloadComponent(0)
    }
    
    func setUpPickerView(){
       
        if countryTxt.text!.isEmpty {
            
        }else{
            citiesPickerView.dataSource = self
            citiesPickerView.delegate = self
            cityTxt.inputView = citiesPickerView
            createDoneBtn(for: cityTxt)
        }
        if cityTxt.text!.isEmpty {
      
            
        }else{
            areaPickerView.dataSource = self
            areaPickerView.delegate = self
            areaTxt.inputView = areaPickerView
            createDoneBtn(for: areaTxt)
        }
        
        countryPickerView.dataSource = self
        countryPickerView.delegate = self
        countryTxt.inputView = countryPickerView
        createDoneBtn(for: countryTxt)
        relationPickerView.dataSource = self
        relationPickerView.delegate = self
        relationTxt.inputView = relationPickerView
        createDoneBtn(for: relationTxt)
    }
    func createDoneBtn (for textField : UITextField)
    {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action:#selector(donePressedOfPickerView))
        toolbar.setItems([done], animated: true)
        textField.inputAccessoryView = toolbar
    }
    @objc func donePressedOfPickerView()
    {
        self.view.endEditing(true)
    }
}
