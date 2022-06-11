//
//  EmergencyContacts+TableView.swift
//  E4 Patient
//
//  Created by mohab on 19/01/2021.
//
import UIKit
extension AllEmergencyContactsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if model?.message?.tblPatientContact?.count == nil {
            return 0
        }else{
            return model?.message?.tblPatientContact?.count ?? 0
            
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmergencyCell") as! EmergencyContactsCell
        cell.selectionStyle = .none
        let contactData = model?.message?.tblPatientContact?[indexPath.row]
        cell.nameLbl.text = contactData?.contactName
        cell.relationLbl.text = contactData?.relationLocalizedName
        cell.locationLbl.text = contactData?.contactAddress
        cell.phonrLbl.text = contactData?.contactMobile
        cell.deleteHandelr = {
            self.callApiDelete(Id: contactData?.patientContactID ?? 0)
            self.model?.message?.tblPatientContact?.remove(at: indexPath.row)
            self.EmergencyTableView.deleteRows(at: [indexPath], with: .automatic)
        }
        cell.editHandelr  = {
            let vc = AddEmergencyVC()
            self.show(vc, sender: nil)
        }
        cell.editHandelr = {
            let vc = AddEmergencyVC()
            vc.model = self.model
            vc.Delegete = self
            vc.isUpdate = true
            vc.updateData = contactData
            self.show(vc, sender: nil)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AddEmergencyVC()
        vc.model = self.model
        vc.Delegete = self
        vc.isUpdate = true
        vc.updateData = model?.message?.tblPatientContact?[indexPath.row]
        show(vc, sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
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
