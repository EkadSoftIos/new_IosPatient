//
//  Sugary+Table.swift
//  E4 Patient
//
//  Created by mohab on 23/01/2021.
//

import UIKit
extension SurgeryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if model?.message?.tblPatientSurgery?.count  == nil {
            return 0
        }else{
            return model?.message?.tblPatientSurgery?.count ?? 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DieseasesCell") as! DieseasesCell
        cell.selectionStyle = .none
        cell.titleLBl.text = "Surgery".localized
        let  data = model?.message?.tblPatientSurgery?[indexPath.row]
        cell.detailsOneLbl.text = data?.patientSurgeryName
        cell.detailsTwoLbl.text = data?.addingData
        cell.detailsThreLbl.text = data?.doctorName
        cell.deleteHandelr = {
            self.callApiDelete(Id: data?.patientSurgeryID ?? 0)
            self.model?.message?.tblPatientSurgery?.remove(at: indexPath.row)
            self.sugaryTable.deleteRows(at: [indexPath], with: .automatic)
        }
        cell.editHandelr = {
            let vc = AddSurgeryVC()
            vc.isUpdate = true
            vc.SurgeryData = data
            vc.model = self.model
            vc.Delegete = self
            self.show(vc, sender: nil)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AddSurgeryVC()
        vc.isUpdate = true
        vc.SurgeryData = model?.message?.tblPatientSurgery?[indexPath.row]
        vc.model = self.model
        vc.Delegete = self
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
