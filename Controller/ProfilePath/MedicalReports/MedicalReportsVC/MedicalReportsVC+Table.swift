//
//  MedicalReportsVC+Table.swift
//  E4 Patient
//
//  Created by mohab on 23/01/2021.
//

import UIKit
extension MedicalReportsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if model?.message?.tblPatientMedicalReport?.count == nil {
            return 0
        }else{
            return model?.message?.tblPatientMedicalReport?.count ?? 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllAllergiesCell") as! AllAllergiesCell
        cell.selectionStyle = .none
        cell.titleLbl.text = "Medical Reports"
        let data = model?.message?.tblPatientMedicalReport?[indexPath.row]
        cell.detailsOneLBl.text = "- \(data?.medicalReportName ?? "")"
        cell.detailsTwoLbl.text = "- By  \(data?.doctorName ?? "")"
        cell.deleteHandelr = {
            self.callApiDelete(Id: data?.patientMedicalReportID ?? 0)
//            self.model?.message?.tblPatientMedicalReport?.remove(at: indexPath.row)
            self.model?.message?.tblPatientMedicalReport?.remove(at: indexPath.row)
            self.medicalTable.deleteRows(at: [indexPath], with: .automatic)
        }
        cell.editHandelr = {
            let vc = AddMedicalReportsVC()
            vc.Delegete = self
            vc.updateData = data
            vc.isUpdate = true
            vc.model = self.model
             self.show(vc, sender: nil)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AddMedicalReportsVC()
        vc.Delegete = self
        vc.updateData = model?.message?.tblPatientMedicalReport?[indexPath.row]
        vc.isUpdate = true
        vc.model = self.model
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
