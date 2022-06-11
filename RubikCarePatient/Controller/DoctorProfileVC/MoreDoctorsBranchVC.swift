//
//  MoreDoctorsBranchVC.swift
//  E4 Patient
//
//  Created by Nada on 12/13/21.
//

import UIKit

class MoreDoctorsBranchVC: UIViewController {
    
    var type: String?
    var doctorName: String?
    var doctorId: Int?
    var doctorImg: String?
    
    var acadimicList: [TblEmployeeAcademicQualification]?
    var moreVisit = [ServiceList]()

    @IBOutlet weak var clinicTB: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        clinicTB.separatorColor = .none
        clinicTB.rowHeight = 44
        clinicTB.estimatedRowHeight = UITableView.automaticDimension
        clinicTB.delegate = self
        clinicTB.dataSource = self
        
        clinicTB.register(UINib(nibName: "AcadimicQualificationCell", bundle: nil), forCellReuseIdentifier: "AcadimicQualificationCell")
        clinicTB.register(UINib(nibName: "ClinicCell", bundle: nil), forCellReuseIdentifier: "ClinicCell")
    }

}

extension MoreDoctorsBranchVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if type != "acadimic" {
            return moreVisit.count
        } else {
            return acadimicList?.count ?? 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if type != "acadimic" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ClinicCell", for: indexPath) as! ClinicCell
            
            cell.selectionStyle = .none
            cell.moreBtn.isHidden = true
            
            cell.bookingBtn.tag = indexPath.row
            cell.bookingBtn.addTarget(self, action: #selector(bookingBranch(sender:)), for: .touchUpInside)
            cell.detailsImg.isHidden = false
            
            let branchname = (moreVisit[indexPath.row].entityName_Localized ?? "") + "("+(moreVisit[indexPath.row].branchName_Localized ?? "") + ")"
            
            let fees = String(moreVisit[indexPath.row].consultationServiceFees ?? 0)
            cell.feesLbl.text = "Fees \(fees) EGP"
            cell.availableTimeLbl.text = moreVisit[indexPath.row].availableText ?? ""
            let imgURL = URL(string: "\(Constants.baseURLImage)\(moreVisit[indexPath.row].imagepath ?? "")")
            
            if type == "branch" {
                cell.branchName.text = branchname
                cell.branchName.text = "Home Visit"
                if imgURL != nil {
                    cell.branchImg?.kf.indicatorType = .activity
                    cell.branchImg?.kf.setImage(with: imgURL)
                } else {
                    cell.branchImg.image = nil
                }
            } else if type == "home" {
                cell.branchImg.image = (UIImage (named: "ic_home visit"))
            } else if type == "video"{
                cell.branchName.text = "Video Call Consultations"
                cell.branchImg.image = (UIImage (named: "ic_video call"))
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AcadimicQualificationCell", for: indexPath) as! AcadimicQualificationCell
            
            cell.selectionStyle = .none
            cell.moreBtn.isHidden = true
            cell.graduationName.text = acadimicList?[indexPath.row].graduationType_Localized ?? ""
            cell.acadimicQualification.text = acadimicList?[indexPath.row].qualificationFromname_Localized ?? ""
            cell.dateLbl.text = String(acadimicList?[indexPath.row].yearOfComplete ?? 0000)
            return cell
        }
    }
    @objc func bookingBranch(sender: UIButton) {
        if type == "branch" {
            let vc = AddAppointmentVC()
            vc.branchList = moreVisit[sender.tag]
            vc.consultationService = 1
            vc.doctorId = self.doctorId
            vc.branchId = moreVisit[sender.tag].businessProviderBranchFk ?? 0
            vc.doctorName = self.doctorName
            vc.doctorImg = self.doctorImg
            vc.medicalServiceList = moreVisit[sender.tag].medicalServiceList
            self.show(vc, sender: nil)
        } else if type == "home" {
            let vc = AddAppointmentVC()
            vc.branchList = moreVisit[sender.tag]
            vc.consultationService = 3
            vc.doctorId = self.doctorId
            self.show(vc, sender: nil)
        } else if type == "video" {
            let vc = AddAppointmentVC()
            if sender.tag > moreVisit.count {
                return
            }else{
                vc.branchList = moreVisit[sender.tag]
                vc.consultationService = 2
                vc.doctorId = self.doctorId
                vc.doctorName = self.doctorName
                vc.doctorImg = self.doctorImg
                self.show(vc, sender: nil)
            }
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if type == "branch" {
            let vc = BranchInfoVCViewController()
            vc.branchList = moreVisit[indexPath.row]
            self.show(vc, sender: nil)
        } else if type == "home" {
            let vc = HomeInfoVC()
            vc.homeList = moreVisit[indexPath.row]
            self.show(vc, sender: nil)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
