//
//  Profile+TableView.swift
//  E4 Patient
//
//  Created by mohab on 18/01/2021.
//

import UIKit
extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch buttonType {
        case 0:
            return patientInfoArr.count
        case 1:
            return healthInfoArr.count
        case 2:
            return userData?.message?.visitSummery?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell") as! ProfileCell
        cell.selectionStyle = .none
        cell.editHandelr = {
            switch self.buttonType {
            case 0:
                switch indexPath.row {
                case 0:
                    let vc = AllAdressVC()
                    vc.model = self.userData
                    self.show(vc, sender: nil)
                case 1:
                    print("")
                case 2:
                    let vc = AllEmergencyContactsVC()
                    vc.model = self.userData
                    self.show(vc, sender: nil)
                default:
                    break
                }
            case 1:
                switch indexPath.row {
                case 0:
                    let vc = AllDiseasesVC()
                    vc.model = self.userData
                    self.show(vc, sender: nil)
                case 1:
                    let vc = AllMedicationVC()
                    vc.model = self.userData
                    self.show(vc, sender: nil)
                case 2:
                    let vc = AllAllergiesVC()
                    vc.model = self.userData
                    self.show(vc, sender: nil)
                case 3:
                    let vc = AddSocialHistoryVC()
                    vc.model = self.userData
                    self.show(vc, sender: true)
                case 4:
                    let vc = FamilyHistoryVC()
                    vc.model = self.userData
                    self.show(vc, sender: nil)
                case 5 :
                    let vc = SurgeryVC()
                    vc.model = self.userData
                    self.show(vc, sender: nil)
                case 6:
                    let vc = MedicalReportsVC()
                    vc.model = self.userData
                    self.show(vc, sender: nil)
                default:
                    break
                }
            default:
                print("")
            }
        }
        switch buttonType {
        case 0:
            cell.titleLbl.text = patientInfoArr[indexPath.row]
            switch indexPath.row {
            case 0:
                if userData?.message?.tblPatientAddress?.count != 0{
                    let model = userData?.message?.tblPatientAddress?[0]
                    cell.detailsoneLbl.text = model?.countryNameLocalized
                    cell.detailsTwoLbl.text = model?.cityNameLocalized
                    cell.detailsThreeLbl.text = model?.areaNameLocalized
                    cell.countLbl.text = "+\(userData?.message?.tblPatientAddress?.count ?? 0)"
                    cell.countLbl.isHidden = false
                    cell.stackHeight.constant = 60
                    cell.lineView.isHidden = false
                    cell.stackView.isHidden = false
                    cell.countView.isHidden = false
                }else{
                    cell.countLbl.isHidden = true
                    cell.stackHeight.constant = 0
                    cell.lineView.isHidden = true
                    cell.stackView.isHidden = true
                    cell.countView.isHidden = true
                }
            case 1:
                cell.countLbl.isHidden = true
                cell.stackHeight.constant = 0
                cell.lineView.isHidden = true
                cell.stackView.isHidden = true
                cell.countView.isHidden = true
            case 2:
                if userData?.message?.tblPatientContact?.count != 0{
                    let model = userData?.message?.tblPatientContact?[0]
                    cell.detailsoneLbl.text = model?.contactName
                    cell.detailsTwoLbl.text = model?.relationLocalizedName
                    cell.detailsThreeLbl.text = model?.contactAddress
                    cell.countLbl.text = "+\(userData?.message?.tblPatientContact?.count ?? 0)"
                    cell.countLbl.isHidden = false
                    cell.stackHeight.constant = 60
                    cell.lineView.isHidden = false
                    cell.stackView.isHidden = false
                    cell.countView.isHidden = false
                }else{
                    cell.countLbl.isHidden = true
                    cell.stackHeight.constant = 0
                    cell.lineView.isHidden = true
                    cell.stackView.isHidden = true
                    cell.countView.isHidden = true
                }
            default:
                break
            }
        case 1:
            cell.titleLbl.text = healthInfoArr[indexPath.row]
            switch indexPath.row {
            case 0:
                cell.editBtn.isHidden = true
                cell.countLbl.isHidden = true
                cell.stackHeight.constant = 0
                cell.lineView.isHidden = true
                cell.stackView.isHidden = true
                cell.countView.isHidden = true
            case 1:
                cell.editBtn.isHidden = false
                if userData?.message?.tblPatientDisease?.count != 0{
                    let model = userData?.message?.tblPatientDisease?[0]
                    cell.detailsoneLbl.text = model?.notes
                    cell.detailsTwoLbl.text = self.GetFormatedDate(date_string: model?.diagonsedDate ?? "", dateFormat: "yyyy-MM-dd'T'HH:mm:ss")
                    cell.detailsThreeLbl.text = "By \(model?.doctorName ?? "")"
                    cell.countLbl.text = "+\(userData?.message?.tblPatientDisease?.count ?? 0)"
                    cell.countLbl.isHidden = false
                    cell.stackHeight.constant = 60
                    cell.lineView.isHidden = false
                    cell.stackView.isHidden = false
                    cell.countView.isHidden = false
                }else{
                    cell.countLbl.isHidden = true
                    cell.stackHeight.constant = 0
                    cell.lineView.isHidden = true
                    cell.stackView.isHidden = true
                    cell.countView.isHidden = true
                }
            case 2:
                cell.editBtn.isHidden = false
                if userData?.message?.tblPatientMedicine?.count != 0{
                    let model = userData?.message?.tblPatientMedicine?[0]
                    cell.detailsoneLbl.text = model?.medicationName
                    cell.detailsTwoLbl.text = model?.medicineStrenght
                   /* cell.detailsThreeLbl.text = "\(self.GetFormatedDate(date_string: model?.dateFrom ?? "", dateFormat: "yyyy-MM-dd'T'HH:mm:ss")) - \(self.GetFormatedDate(date_string: model?.dateTo ?? "", dateFormat: "yyyy-MM-dd'T'HH:mm:ss"))"*/
                    cell.countLbl.text = "+\(userData?.message?.tblPatientMedicine?.count ?? 0)"
                    cell.countLbl.isHidden = false
                    cell.stackHeight.constant = 60
                    cell.lineView.isHidden = false
                    cell.stackView.isHidden = false
                    cell.countView.isHidden = false
                }else{
                    cell.countLbl.isHidden = true
                    cell.stackHeight.constant = 0
                    cell.lineView.isHidden = true
                    cell.stackView.isHidden = true
                    cell.countView.isHidden = true
                }
            case 3:
                cell.editBtn.isHidden = false
                if userData?.message?.tblPatientAllergies?.count != 0{
                    let model = userData?.message?.tblPatientAllergies?[0]
                    cell.detailsoneLbl.text = "- \(model?.allergiesName ?? "")"
                    cell.detailsTwoLbl.text = "- \(model?.allergiesTriggeredBy ?? "")"
                    cell.detailsThreeLbl.text = ""
                    cell.countLbl.text = "+\(userData?.message?.tblPatientAllergies?.count ?? 0)"
                    cell.countLbl.isHidden = false
                    cell.stackHeight.constant = 60
                    cell.lineView.isHidden = false
                    cell.stackView.isHidden = false
                    cell.countView.isHidden = false
                }else{
                    cell.countLbl.isHidden = true
                    cell.stackHeight.constant = 0
                    cell.lineView.isHidden = true
                    cell.stackView.isHidden = true
                    cell.countView.isHidden = true
                }
            case 4:
                cell.editBtn.isHidden = false
                if userData?.message?.tblPatientSocialHistory?.count != 0{
                    let model = userData?.message?.tblPatientSocialHistory?[0]
                    cell.detailsoneLbl.text = model?.job
                    
                    if model?.isSmoke == true{
                        cell.detailsTwoLbl.text  = "Smoking".localized
                    }else{
                        cell.detailsTwoLbl.text = "No Smoking".localized
                    }
                    if model?.alcoholConsumption == true {
                        cell.detailsThreeLbl.text = "Alcohol".localized
                    }else{
                        cell.detailsThreeLbl.text = "No Alcohol".localized
                    }
                    cell.countLbl.text = "+\(userData?.message?.tblPatientSocialHistory?.count ?? 0)"
                    cell.countLbl.isHidden = false
                    cell.stackHeight.constant = 60
                    cell.lineView.isHidden = false
                    cell.stackView.isHidden = false
                    cell.countView.isHidden = false
                    
                }else{
                    cell.countLbl.isHidden = true
                    cell.stackHeight.constant = 0
                    cell.lineView.isHidden = true
                    cell.stackView.isHidden = true
                    cell.countView.isHidden = true
                }
            case 5:
                cell.editBtn.isHidden = false
                if userData?.message?.tblPatientSocialFamily?.count != 0{
                    let model = userData?.message?.tblPatientSocialFamily?[0]
                    cell.detailsoneLbl.text = model?.relationNameLocalized
                    cell.detailsTwoLbl.text = model?.notes
                    cell.detailsThreeLbl.text = ""
                    cell.countLbl.text = "+\(userData?.message?.tblPatientSocialFamily?.count ?? 0)"
                    cell.countLbl.isHidden = false
                    cell.stackHeight.constant = 60
                    cell.lineView.isHidden = false
                    cell.stackView.isHidden = false
                    cell.countView.isHidden = false
                }else{
                    cell.countLbl.isHidden = true
                    cell.stackHeight.constant = 0
                    cell.lineView.isHidden = true
                    cell.stackView.isHidden = true
                    cell.countView.isHidden = true
                }
            case 6:
                cell.editBtn.isHidden = false
                if userData?.message?.tblPatientSurgery?.count != 0{
                    let model = userData?.message?.tblPatientSurgery?[0]
                    cell.detailsoneLbl.text = model?.patientSurgeryName
                    cell.detailsTwoLbl.text = self.GetFormatedDate(date_string: model?.patientSurgeryDate ?? "", dateFormat: "yyyy-MM-dd'T'HH:mm:ss")
                    cell.detailsThreeLbl.text = "By \(model?.doctorName ?? "")"
                    cell.countLbl.text = "+\(userData?.message?.tblPatientSurgery?.count ?? 0)"
                    cell.countLbl.isHidden = false
                    cell.stackHeight.constant = 60
                    cell.lineView.isHidden = false
                    cell.stackView.isHidden = false
                    cell.countView.isHidden = false
                }else{
                    cell.countLbl.isHidden = true
                    cell.stackHeight.constant = 0
                    cell.lineView.isHidden = true
                    cell.stackView.isHidden = true
                    cell.countView.isHidden = true
                }
            case 7:
                cell.editBtn.isHidden = false
                if userData?.message?.tblPatientMedicalReport?.count != 0{
                    let model = userData?.message?.tblPatientMedicalReport?[0]
                    cell.detailsoneLbl.text = model?.medicalReportName
                    cell.detailsTwoLbl.text = self.GetFormatedDate(date_string: model?.medicalReportDate ?? "", dateFormat: "yyyy-MM-dd'T'HH:mm:ss")
                    cell.detailsThreeLbl.text = "By \(model?.doctorName ?? "")"
                    cell.countLbl.text = "+\(userData?.message?.tblPatientMedicalReport?.count ?? 0)"
                    cell.countLbl.isHidden = false
                    cell.stackHeight.constant = 60
                    cell.lineView.isHidden = false
                    cell.stackView.isHidden = false
                    cell.countView.isHidden = false
                }else{
                    cell.countLbl.isHidden = true
                    cell.stackHeight.constant = 0
                    cell.lineView.isHidden = true
                    cell.stackView.isHidden = true
                    cell.countView.isHidden = true
                }
            default:
                break
            }
        case 2:
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileSummaryCell") as! ProfileSummaryCell
        cell.selectionStyle = .none
        
        cell.doctorNameLbl.text = userData?.message?.visitSummery?[indexPath.row].doctorName ?? ""
        cell.descLbl.text = userData?.message?.visitSummery?[indexPath.row].summeryOrReport ?? ""
//  cell.dateLbl.text = self.GetFormatedDate(date_string:     userData?.message?.visitSummery?[indexPath.row].date ?? "", dateFormat: "yyyy-MM-dd'T'HH:mm:ss")
        cell.dateLbl.text = convertDateFormat(inputDate: userData?.message?.visitSummery?[indexPath.row].date ?? "")
        if userData?.message?.visitSummery?[indexPath.row].bookingSummaryFiles?.count ?? 0 != 0 {
            cell.attachmentBtn.isHidden = false
        } else {
            cell.attachmentBtn.isHidden = true
        }
        if cell.descLbl.numberOfLines > 1 {
            cell.moreBtn.isHidden = false
        } else {
            cell.moreBtn.isHidden = true
        }
        
        cell.attachmentBtn.tag = indexPath.row
        cell.attachmentBtn.addTarget(self, action: #selector(showAttachementFiles(sender:)), for: .touchUpInside)
            
        return cell
        default:
            break
        }
        return cell
    }
    @objc func showAttachementFiles(sender: UIButton) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "PatientAttachememntsVC") as! PatientAttachememntsVC
        vc.userData = self.userData?.message
        vc.indexPath = sender.tag
        navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch buttonType {
        case 0:
            switch indexPath.row {
            case 0:
                let vc = AllAdressVC()
                vc.model = userData
                show(vc, sender: nil)
            case 1:
                print("")
            case 2:
                let vc = AllEmergencyContactsVC()
                vc.model = userData
                show(vc, sender: nil)
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0:
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "FollowUpVC") as! FollowUpVC
                
                vc.followUpData = self.userData?.message?.followUpCardList
                
                navigationController?.pushViewController(vc, animated: true)
            case 1:
                let vc = AllDiseasesVC()
                vc.model = userData
                show(vc, sender: nil)
            case 2:
                let vc = AllMedicationVC()
                vc.model = userData
                show(vc, sender: nil)
            case 3:
                let vc = AllAllergiesVC()
                vc.model = userData
                show(vc, sender: nil)
            case 4:
                let vc = AddSocialHistoryVC()
                vc.model = userData
                show(vc, sender: true)
            case 5 :
                let vc = FamilyHistoryVC()
                vc.model = userData
                self.show(vc, sender: nil)
            case 6:
                let vc = SurgeryVC()
                vc.model = userData
                show(vc, sender: nil)
            case 7:
                let vc = MedicalReportsVC()
                vc.model = userData
                show(vc, sender: nil)
                
            default:
                break
            }
        default:
            print("")
        //self.showMessage(sub: "not available Now".localized)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell") as! ProfileCell
        switch buttonType {
        case 0:
            switch indexPath.row {
            case 0:
                if userData?.message?.tblPatientAddress?.count != 0{
                    return 140
                }else{
                    return 60
                }
            case 1:                
                return 60
            case 2:
                if userData?.message?.tblPatientContact?.count != 0{
                    return 140
                }else{
                    return 60
                }
            default:
                return 140
            }
        case 1:
            switch indexPath.row {
            case 0:
                return 60
            case 1:
                if userData?.message?.tblPatientDisease?.count != 0{
                    return 140
                }else{
                    cell.stackHeight.constant = 0
                    return 60
                }
            case 2:
                if userData?.message?.tblPatientMedicine?.count != 0{
                    return 140
                }else{
                    cell.stackHeight.constant = 0
                    return 60
                }
            case 3:
                if userData?.message?.tblPatientAllergies?.count != 0{
                    return 140
                }else{
                    cell.stackHeight.constant = 0
                    return 60
                }
            case 4:
                if userData?.message?.tblPatientSocialHistory?.count != 0{
                    return 140
                }else{
                    cell.stackHeight.constant = 0
                    return 60
                }
            case 5:
                if userData?.message?.tblPatientSocialFamily?.count != 0{
                    return 140
                }else{
                    cell.stackHeight.constant = 0
                    return 60
                }
            case 6:
                if userData?.message?.tblPatientSurgery?.count != 0{
                    return 140
                }else{
                    cell.stackHeight.constant = 0
                    return 60
                }
            case 7:
                if userData?.message?.tblPatientMedicalReport?.count != 0{
                    return 140
                }else{
                    cell.stackHeight.constant = 0
                    return 60
                }
            default:
                return 140
            }
        case 2:
            return 130
        default:
            break
        }
        return 140
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
