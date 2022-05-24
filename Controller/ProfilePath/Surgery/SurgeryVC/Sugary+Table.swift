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
//        cell.titleLBl.text = "Surgery".localized
        
        let  data = model?.message?.tblPatientSurgery?[indexPath.row]
        if let createVisitDate = data?.createDate?.components(separatedBy: "T") {
            cell.titleLBl.text = GetFormatedDate(date_string: createVisitDate[0], dateFormat: "yyyy-MM-dd")
        }
//        cell.titleLBl.text = data?.createDate
        cell.detailsOneLbl.text = data?.patientSurgeryName
        var surgeyDate = ""
        if let surgeyVisitDate = data?.patientSurgeryDate?.components(separatedBy: "T") {
            surgeyDate = GetFormatedDate(date_string: surgeyVisitDate[0], dateFormat: "yyyy-MM-dd")
        }
        cell.detailsTwoLbl.text = "\("DiagnosedOn".localized)\(": ")\(surgeyDate)"
        let range = (cell.detailsTwoLbl.text! as NSString).range(of: "DiagnosedOn".localized)
        let mutableAttributedString = NSMutableAttributedString.init(string: cell.detailsTwoLbl.text ?? "")
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor (named: "Blue")! , range: range)
        cell.detailsTwoLbl.attributedText = mutableAttributedString
        cell.detailsThreLbl.text = "\("TratedByDr.")\(": ")\(data?.doctorName ?? "")"
        let range2 = (cell.detailsThreLbl.text! as NSString).range(of: "TratedByDr.".localized)
        let mutableAttributedString2 = NSMutableAttributedString.init(string: cell.detailsThreLbl.text ?? "")
        mutableAttributedString2.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor (named: "Blue")!, range: range2)
        cell.detailsThreLbl.attributedText = mutableAttributedString2
        cell.deleteHandelr = {
            
            let vc = DeleteSurgeyVC()
            vc.id = data?.patientSurgeryID ?? 0
            vc.Delegete = self
             vc.modalPresentationStyle = .overCurrentContext
             vc.modalTransitionStyle = .crossDissolve
             self.present(vc, animated: true, completion: nil)
            
            
//            self.callApiDelete(Id: data?.patientSurgeryID ?? 0)
//            self.model?.message?.tblPatientSurgery?.remove(at: indexPath.row)
//            self.sugaryTable.deleteRows(at: [indexPath], with: .automatic)
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
    func GetFormatedDate(date_string:String,dateFormat:String)-> String{

       let dateFormatter = DateFormatter()
       dateFormatter.locale = Locale(identifier: "en_US_POSIX")
       dateFormatter.dateFormat = dateFormat

       let dateFromInputString = dateFormatter.date(from: date_string)
       dateFormatter.dateFormat = "dd-mm-yyyy"
       if(dateFromInputString != nil){
           return dateFormatter.string(from: dateFromInputString!)
       }
       else{
           debugPrint("could not convert date")
           return ""
       }
   }
}
