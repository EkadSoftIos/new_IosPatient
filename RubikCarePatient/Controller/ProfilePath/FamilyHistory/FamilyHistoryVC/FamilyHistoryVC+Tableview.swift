//
//  FamilyHistoryVC+Tableview.swift
//  E4 Patient
//
//  Created by mohab on 23/01/2021.
//

import UIKit
extension FamilyHistoryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if model?.message?.tblPatientSocialFamily?.count == nil {
            return  0
        }else{
            return model?.message?.tblPatientSocialFamily?.count ?? 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DieseasesCell") as! DieseasesCell
        cell.selectionStyle = .none
        cell.titleLBl.text = "Family History"
        let data = model?.message?.tblPatientSocialFamily?[indexPath.row]
        cell.detailsOneLbl.text = data?.relationNameLocalized
        cell.detailsTwoLbl.text = data?.notes
        cell.detailsThreLbl.text = ""
        cell.deleteHandelr = {
//            self.callApiDelete(Id: data?.patientSocialFamilyID ?? 0)
//            self.model?.message?.tblPatientSocialFamily?.remove(at: indexPath.row)
//            self.familyTable.deleteRows(at: [indexPath], with: .automatic)
            
            let vc = DeleteFamilyHistoryVC()
            vc.id = data?.patientSocialFamilyID ?? 0
            vc.Delegete = self
             vc.modalPresentationStyle = .overCurrentContext
             vc.modalTransitionStyle = .crossDissolve
             self.present(vc, animated: true, completion: nil)

        }
        cell.editHandelr = {
            let vc = AddFamilyHistoryVC()
            vc.isUpdate = true
            vc.updateData = data
            vc.model = self.model
            vc.Delegete = self
            self.show(vc, sender: nil)
        }
        return cell
    }
    func GetFormatedDate(date_string:String,dateFormat:String)-> String{

       let dateFormatter = DateFormatter()
       dateFormatter.locale = Locale(identifier: "en_US_POSIX")
       dateFormatter.dateFormat = dateFormat

       let dateFromInputString = dateFormatter.date(from: date_string)
       dateFormatter.dateFormat = "yyyy-MM-dd"
       if(dateFromInputString != nil){
           return dateFormatter.string(from: dateFromInputString!)
       }
       else{
           debugPrint("could not convert date")
           return ""
       }
   }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AddFamilyHistoryVC()
        vc.isUpdate = true
        vc.updateData = model?.message?.tblPatientSocialFamily?[indexPath.row]
        vc.Delegete = self
        vc.model = self.model
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
