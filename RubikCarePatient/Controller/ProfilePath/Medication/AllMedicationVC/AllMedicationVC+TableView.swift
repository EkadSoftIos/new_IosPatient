//
//  AllMedicationVC+TableView.swift
//  E4 Patient
//
//  Created by mohab on 19/01/2021.
//


import UIKit
//"PatientMedicineId": -68742356,
extension AllMedicationVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if model?.message?.tblPatientMedicine?.count == nil {
            return 0
        }else{
            return model?.message?.tblPatientMedicine?.count ?? 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedicationCell") as! MedicationCell
        cell.selectionStyle = .none
        let medicationData = model?.message?.tblPatientMedicine?[indexPath.row]
        
        cell.repeatLbl.text = "\(medicationData?.durationValue ?? 0)\(" ")\(medicationData?.durationTypetNameLocalized ?? "")"
        cell.detailsOneLbl.text = "\(medicationData?.quantity ?? 0)\(" ")\(medicationData?.whenMedicationTakenNameLocalized ?? "")"

        cell.dateLbl.text = ""
        cell.nameLbl.text = medicationData?.medicationName
        cell.quantityLbl.text = "\(medicationData?.medicineForm ?? "")\("-")\(medicationData?.medicineStrenght ?? "")"
//        cell.repeatLbl.text = medicationData?.durationTypetNameLocalized ?? ""
        let image = "\(Constants.baseURLImage)\(medicationData?.medicineImagePath ?? "")"
        cell.medImage.kf.setImage(with: URL(string: image),placeholder: UIImage(named: "BarLogo"))
//        if medicationData?.createdByDoctorFk != nil {
//            cell.deleteBtn.isHidden = true
//            cell.editBtn.isHidden = true
//        }else{
//            cell.deleteBtn.isHidden = false
//            cell.editBtn.isHidden = false
//        }
        if medicationData?.prescriptionFk ?? 0 > 0 {
            cell.editBtn.isHidden = true
        }else{
            cell.editBtn.isHidden = false
        }
        cell.deleteHandelr = {
            self.deleteCell(Id: medicationData?.patientMedicineID ?? 0)
//            self.callApiDelete(Id: medicationData?.patientMedicineID ?? 0)
            self.model?.message?.tblPatientMedicine?.remove(at: indexPath.row)
            self.medicationTableView.deleteRows(at: [indexPath], with: .automatic)
        }
        cell.editHandelr = {
            let vc = CountinueAddMedicationVC()
            vc.Delegete = self
            vc.isUpdate = true
            vc.model = self.model
            vc.updateData = medicationData
            self.show(vc, sender: nil)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("")
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
extension AllMedicationVC: addmedication{
    func Data(isAdded: Bool, isupdate: Bool) {
        callApiAdd()
    }
    func deleteCell(Id: Int){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "DeletePopUp")
//      vc.cellId = Id
        self.present(vc, animated: true, completion: nil)
    }
    
}
