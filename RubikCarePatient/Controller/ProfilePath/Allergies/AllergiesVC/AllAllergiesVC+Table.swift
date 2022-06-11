//
//  AllAllergiesVC+Table.swift
//  E4 Patient
//
//  Created by mohab on 20/01/2021.
//

import UIKit
extension AllAllergiesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if model?.message?.tblPatientAllergies?.count != nil{
            return (model?.message?.tblPatientAllergies?.count)!
        }else{
            return 0
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllAllergiesCell") as! AllAllergiesCell
        cell.selectionStyle = .none
        let allergies = model?.message?.tblPatientAllergies?[indexPath.row]
        cell.detailsOneLBl.text = "- \(allergies?.allergiesName ?? "")"
        cell.detailsTwoLbl.text = "- \(allergies?.allergiesTriggeredBy ?? "")"
        cell.deleteHandelr = {
//            self.callApiDelete(Id: allergies?.patientAllergiesID ?? 0)
//            self.model?.message?.tblPatientAllergies?.remove(at: indexPath.row)
//            self.allergiesTableView.deleteRows(at: [indexPath], with: .automatic)
            let vc = DeleteAllergiesVC()
            vc.id = allergies?.patientAllergiesID ?? 0
            vc.Delegete = self
             vc.modalPresentationStyle = .overCurrentContext
             vc.modalTransitionStyle = .crossDissolve
             self.present(vc, animated: true, completion: nil)

        }
        cell.editHandelr = {
            let vc = AddAllergiesVC()
             vc.Delegete = self
             vc.isUpdate = true
             vc.updateData = allergies
             self.show(vc, sender: nil)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let vc = AddAllergiesVC()
        vc.Delegete = self
        vc.isUpdate = true
        vc.updateData = model?.message?.tblPatientAllergies?[indexPath.row]
        self.show(vc, sender: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
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
