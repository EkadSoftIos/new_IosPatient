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
        cell.detailsOneLbl.text = dieses?.diseaseNamelocalized ?? ""
        
        var diseaseDate = ""
        if let diseaseVisitDate = dieses?.diagonsedDate?.components(separatedBy: "T") {
            diseaseDate = GetFormatedDate(date_string: diseaseVisitDate[0], dateFormat: "yyyy-MM-dd")
        }
        cell.detailsTwoLbl.text = "\("DiagnosedOn".localized)\(": ")\(diseaseDate)"
        let range = (cell.detailsTwoLbl.text! as NSString).range(of: "DiagnosedOn".localized)
        let mutableAttributedString = NSMutableAttributedString.init(string: cell.detailsTwoLbl.text ?? "")
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor (named: "Blue")! , range: range)
        cell.detailsTwoLbl.attributedText = mutableAttributedString
        
        cell.detailsThreLbl.text = "\("TratedByDr.".localized)\(": ")\(dieses?.doctorName ?? "")"
        let range2 = (cell.detailsThreLbl.text! as NSString).range(of: "TratedByDr.".localized)
        let mutableAttributedString2 = NSMutableAttributedString.init(string: cell.detailsThreLbl.text ?? "")
        mutableAttributedString2.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor (named: "Blue")!, range: range2)
        cell.detailsThreLbl.attributedText = mutableAttributedString2

        
        
        
        
        
//        cell.detailsTwoLbl.text =  self.GetFormatedDate(date_string: dieses?.createDate ?? "", dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SS")
//        cell.detailsThreLbl.text = "By  \(dieses?.doctorName ?? "")"
        cell.deleteHandelr = {
//            self.callApiDelete(Id: dieses?.patientDiseaseID ?? 0)
//            self.model?.message?.tblPatientDisease?.remove(at: indexPath.row)
//            self.dieseasesTableView.deleteRows(at: [indexPath], with: .automatic)
            let vc = DeleteDiseasesVC()
            vc.id = dieses?.patientDiseaseID ?? 0
            vc.Delegete = self
             vc.modalPresentationStyle = .overCurrentContext
             vc.modalTransitionStyle = .crossDissolve
             self.present(vc, animated: true, completion: nil)

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
