//
//  AllDiseasesVC+TableView.swift
//  E4 Patient
//
//  Created by mohab on 19/01/2021.
//

import UIKit
extension AllDiseasesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if model?.message?.tblPatientDisease?.count != nil {
            return (model?.message?.tblPatientDisease?.count)!
        }else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DieseasesCell") as! DieseasesCell
        cell.selectionStyle = .none
        let dieses = model?.message?.tblPatientDisease?[indexPath.row]
        cell.detailsOneLbl.text = dieses?.notes
        cell.detailsTwoLbl.text =  self.GetFormatedDate(date_string: dieses?.createDate ?? "", dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SS")
        cell.detailsThreLbl.text = "By  \(dieses?.doctorName ?? "")"
        cell.deleteHandelr = {
            self.callApiDelete(Id: dieses?.patientDiseaseID ?? 0)
            self.model?.message?.tblPatientDisease?.remove(at: indexPath.row)
            self.dieseasesTableView.deleteRows(at: [indexPath], with: .automatic)
        }
        cell.editHandelr = {
            let vc = AddDieseasesVC()
            vc.isUpdate = true
            vc.updateData = dieses
            vc.Delegete = self
            vc.model = self.model
            self.show(vc, sender: nil)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AddDieseasesVC()
        vc.isUpdate = true
        vc.updateData = model?.message?.tblPatientDisease?[indexPath.row]
        vc.Delegete = self
        vc.model = model
        self.show(vc, sender: nil)
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
