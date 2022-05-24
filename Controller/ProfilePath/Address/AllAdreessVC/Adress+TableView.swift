//
//  Adress+TableView.swift
//  E4 Patient
//
//  Created by mohab on 19/01/2021.
//

import UIKit
extension AllAdressVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if model?.message?.tblPatientAddress?.count != nil {
            return (model?.message?.tblPatientAddress?.count)!
        }else{
        return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allAdressCell") as! AllAddressCell
        cell.selectionStyle = .none
        let addressModel = model?.message?.tblPatientAddress?[indexPath.row]
        cell.adressLbl.text = "\(addressModel?.countryNameLocalized ?? ""), \(addressModel?.cityNameLocalized ?? "")\n \(addressModel?.areaNameLocalized ?? ""), \(addressModel?.patientAddressName ?? "")\n \(addressModel?.landMark ?? "")"
        
        cell.deleteHandelr = {
//            self.callApiDelete(id: self.model?.message?.tblPatientAddress?[indexPath.row].patientAddressID ?? 0)
            let vc = DeleteLocationVC()
            vc.id = self.model?.message?.tblPatientAddress?[indexPath.row].patientAddressID ?? 0
            vc.Delegete = self
             vc.modalPresentationStyle = .overCurrentContext
             vc.modalTransitionStyle = .crossDissolve
             self.present(vc, animated: true, completion: nil)
        }
        cell.defultHandelr = {
            let vc = DefultLocationVC()
            vc.id = addressModel?.patientAddressID ?? 0
            vc.isMain = addressModel?.isMain ?? false
            vc.Delegete = self
             vc.modalPresentationStyle = .overCurrentContext
             vc.modalTransitionStyle = .crossDissolve
             self.present(vc, animated: true, completion: nil)
        }
        cell.editHandelr = {
            let vc = AddAddressVC()
            vc.isUpdate = true
            vc.userModel = self.model
            vc.editAddress = self.model?.message?.tblPatientAddress?[indexPath.row]
            self.show(vc, sender: nil)
        }
        if addressModel?.isMain == true {
            cell.defultAdressBtn.setImage(UIImage(named: "isActive"), for: .normal)
        }else{
            cell.defultAdressBtn.setImage(UIImage(named: "ic_review_unactive"), for: .normal)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AddAddressVC()
        vc.isUpdate = true
        vc.userModel = self.model
        vc.editAddress = self.model?.message?.tblPatientAddress?[indexPath.row]
        self.show(vc, sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, -10, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0.0
        UIView.animate(withDuration: 0.75){
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1
        }
    }
   
   
}
