//
//  DoctorProfileViewController.swift
//  E4 Patient
//
//  Created by Nada on 9/15/21.
//

import UIKit

class DoctorProfileViewController: UIViewController, BaseViewProtocol {

    var doctorId: Int?
    var doctorProfileViewModel = DoctorProfileViewModel()
    
    var doctorDetails = false
    
    let vw = UIView(frame: UIScreen.main.bounds)
    let indicator = UIActivityIndicatorView(style: .whiteLarge)
    @IBOutlet weak var doctorProfileTB: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        doctorProfileViewModel.getDoctordata(id: doctorId ?? 0)
        initBinding()
        
        self.title = "Doctor Profile"
        
        doctorProfileTB.separatorColor = .none
        doctorProfileTB.rowHeight = 44
        doctorProfileTB.estimatedRowHeight = UITableView.automaticDimension
        doctorProfileTB.delegate = self
        doctorProfileTB.dataSource = self
        
        doctorProfileTB.register(UINib(nibName: "DoctorProfileHeaderCell", bundle: nil), forCellReuseIdentifier: "DoctorProfileHeaderCell")
        doctorProfileTB.register(UINib(nibName: "AboutDoctorCell", bundle: nil), forCellReuseIdentifier: "AboutDoctorCell")
        doctorProfileTB.register(UINib(nibName: "AcadimicQualificationCell", bundle: nil), forCellReuseIdentifier: "AcadimicQualificationCell")
        doctorProfileTB.register(UINib(nibName: "ClinicCell", bundle: nil), forCellReuseIdentifier: "ClinicCell")
    }
    func initBinding() {
        doctorProfileViewModel.isLoading.addObserver { [weak self] (isLoading) in
            guard let self = self else {return}
            if isLoading {
                self.showActivityIndicator(view: self.vw, indicator: self.indicator)
            } else {
                self.hideActivityIndicator(view: self.vw, indicator: self.indicator)
            }
        }
        doctorProfileViewModel.reloadDoctorData.addObserver { [weak self] (isReload) in
            guard let self = self else {return}
            if isReload {
                DispatchQueue.main.async { self.doctorProfileTB.reloadData() }
            }
        }
        doctorProfileViewModel.showError.addObserver { [weak self] (value) in
            guard let self = self else {return}
            if value != "" {
                DispatchQueue.main.async { self.showAlert(message: value) }
            }
        }
    }
    @IBAction func backBtnPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension DoctorProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 1{
            return 1
        } else if section == 2 {
            if (doctorProfileViewModel.doctorData?.tblEmployeeAcademicQualification?.count ?? 0) > 1  {
                return 1
            } else {
                return doctorProfileViewModel.doctorData?.tblEmployeeAcademicQualification?.count ?? 0
            }
        } else if section == 3 {
//            if doctorProfileViewModel.branchList.count > 1  {
//                return 1
//            } else {
                return doctorProfileViewModel.branchList.count
//            }
        } else if section == 4 {
            if doctorProfileViewModel.homeVisit.count > 1 {
                return 1
            } else {
                return doctorProfileViewModel.homeVisit.count
            }
        } else {
            if doctorProfileViewModel.videoCallList.count > 1 {
                return 1
            } else {
                return doctorProfileViewModel.videoCallList.count
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorProfileHeaderCell", for: indexPath) as! DoctorProfileHeaderCell
            cell.selectionStyle = .none
            cell.slf = self
            
            cell.doctorCanDo = doctorProfileViewModel.doctorData?.doctorCanDo ?? []
            cell.doctorId = doctorProfileViewModel.doctorData?.businessProviderEmployeeId ?? 0
            
            let doctorProfileData = doctorProfileViewModel.doctorData
            if doctorProfileData?.isOnline == true {
                cell.statusView.backgroundColor = UIColor.green
                Animation.roundView(cell.statusView)
            }else{
                cell.statusView.backgroundColor = UIColor.clear
            }
            if doctorProfileData?.isFavourite == true {
                cell.likeBtn.setImage(UIImage (named: "ic_fav"), for: .normal)
                cell.likeBtn.tag = 1
            }else{
                cell.likeBtn.setImage(UIImage (named: "unfav"), for: .normal)
                cell.likeBtn.tag = 0
            }
            cell.likeBtn.addTarget(self, action: #selector(addFavourite(tag:)), for: .touchUpInside)
            
            let imgURL = URL(string: "\(Constants.baseURLImage)\(doctorProfileData?.profileImage ?? "")")
            cell.doctorImg?.kf.indicatorType = .activity
            cell.doctorImg?.kf.setImage(with: imgURL)
            Animation.roundView(cell.doctorImg)
            cell.doctorDesc.text = doctorProfileData?.fullProfisionalDetails_Localized ?? ""
            cell.doctorName.text = (doctorProfileData?.prefixTitle_Localized ?? "") + " " + (doctorProfileData?.doctorName ?? "")
            cell.rateLbl.text = doctorProfileData?.rate_stars ?? "0"
            cell.viewersNumber.text = doctorProfileData?.viewersnumber ?? "0"
            cell.patientNumber.text = doctorProfileData?.totalpatient ?? "0"
            cell.totalAppointement.text = doctorProfileData?.totalappointment ?? "0"
            
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AboutDoctorCell", for: indexPath) as! AboutDoctorCell
            cell.selectionStyle = .none
            cell.doctorDesc.text = doctorProfileViewModel.doctorData?.employeeAbout_Localized ?? ""
//            cell.doctorDesc.text = doctorProfileViewModel.doctorData?.fullProfisionalDetails_Localized ?? ""
            
            if  doctorDetails == false {
                var txt = ""
                if cell.doctorDesc.text!.count > 30 {
                    cell.moreBtn.isHidden = false
                    let str = cell.doctorDesc.text ?? ""
                    for (_, char) in str.enumerated() {
                        if txt.count <= 30 {
                            txt.append(char)
                            cell.doctorDesc.text = txt
                        } else {
                            break
                        }
                    }
                } else {
                    cell.moreBtn.isHidden = true
                }
            } else {
                cell.moreBtn.isHidden = true
            }
            
            cell.moreBtn.addTarget(self, action: #selector(moreDetails), for: .touchUpInside)
            
            return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AcadimicQualificationCell", for: indexPath) as! AcadimicQualificationCell
            cell.selectionStyle = .none
            
            if (doctorProfileViewModel.doctorData?.tblEmployeeAcademicQualification?.count ?? 0) > 1  {
                cell.moreBtn.isHidden = false
            } else {
                cell.moreBtn.isHidden = true
            }
            cell.moreBtn.addTarget(self, action: #selector(moreAcadimic), for: .touchUpInside)
            
            cell.graduationName.text = doctorProfileViewModel.doctorData?.tblEmployeeAcademicQualification?[indexPath.row].graduationType_Localized ?? ""
            cell.acadimicQualification.text = doctorProfileViewModel.doctorData?.tblEmployeeAcademicQualification?[indexPath.row].qualificationFromname_Localized ?? ""
            cell.dateLbl.text = String(doctorProfileViewModel.doctorData?.tblEmployeeAcademicQualification?[indexPath.row].yearOfComplete ?? 0000)
            
            return cell
        } else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ClinicCell", for: indexPath) as! ClinicCell
            cell.selectionStyle = .none
            
//            if doctorProfileViewModel.branchList.count > 1  {
//                cell.moreBtn.isHidden = false
//            } else {
                cell.moreBtn.isHidden = true
//            }
            
            cell.moreBtn.addTarget(self, action: #selector(moreBranches), for: .touchUpInside)
            
            cell.bookingBtn.tag = indexPath.row
            cell.bookingBtn.addTarget(self, action: #selector(bookingBranch(sender:)), for: .touchUpInside)
            cell.detailsImg.isHidden = false
            
            let branchname = (doctorProfileViewModel.branchList[indexPath.row].entityName_Localized ?? "") + " " + "("+(doctorProfileViewModel.branchList[indexPath.row].branchName_Localized ?? "") + ")"
            cell.branchName.text = branchname
            let fees = String(doctorProfileViewModel.branchList[indexPath.row].consultationServiceFees ?? 0)
            cell.feesLbl.text = "Fees \(fees) EGP"
            cell.availableTimeLbl.text = doctorProfileViewModel.branchList[indexPath.row].availableText ?? ""
            let imgURL = URL(string: "\(Constants.baseURLImage)\(doctorProfileViewModel.branchList[indexPath.row].imagepath ?? "")")
            if imgURL != nil {
                cell.branchImg?.kf.indicatorType = .activity
                cell.branchImg?.kf.setImage(with: imgURL)
            } else {
                cell.branchImg.image = nil
            }
            
            return cell
        } else if indexPath.section == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ClinicCell", for: indexPath) as! ClinicCell
            cell.selectionStyle = .none
            
            if doctorProfileViewModel.homeVisit.count > 1 {
                cell.moreBtn.isHidden = false
            } else {
                cell.moreBtn.isHidden = true
            }
            
            cell.moreBtn.addTarget(self, action: #selector(moreClinic), for: .touchUpInside)
            
            cell.bookingBtn.tag = indexPath.row
            cell.bookingBtn.addTarget(self, action: #selector(bookingHome(sender:)), for: .touchUpInside)
            cell.detailsImg.isHidden = false
            
            let branchname = (doctorProfileViewModel.homeVisit[indexPath.row].entityName_Localized ?? "") + "("+(doctorProfileViewModel.homeVisit[indexPath.row].branchName_Localized ?? "") + ")"
            cell.branchName.text = "Home Visit"
            let fees = String(doctorProfileViewModel.homeVisit[indexPath.row].consultationServiceFees ?? 0)
            cell.feesLbl.text = "Fees \(fees) EGP"
            cell.availableTimeLbl.text = doctorProfileViewModel.homeVisit[indexPath.row].availableText ?? ""
//            let imgURL = URL(string: "\(Constants.baseURLImage)\(doctorProfileViewModel.homeVisit[indexPath.row].imagepath ?? "")")
//            if imgURL != nil {
//                cell.branchImg?.kf.indicatorType = .activity
//                cell.branchImg?.kf.setImage(with: imgURL)
//            } else {
                cell.branchImg.image = (UIImage (named: "ic_home visit"))
//            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ClinicCell", for: indexPath) as! ClinicCell
            cell.selectionStyle = .none
            
            if doctorProfileViewModel.videoCallList.count > 1 {
                cell.moreBtn.isHidden = false
            } else {
                cell.moreBtn.isHidden = true
            }
            
            cell.moreBtn.addTarget(self, action: #selector(moreVideos), for: .touchUpInside)
            
            cell.bookingBtn.tag = indexPath.row
            cell.bookingBtn.addTarget(self, action: #selector(bookingVideoCall(sender:)), for: .touchUpInside)
            cell.detailsImg.isHidden = true
            
            let branchname = (doctorProfileViewModel.videoCallList[indexPath.row].entityName_Localized ?? "") + "("+(doctorProfileViewModel.videoCallList[indexPath.row].branchName_Localized ?? "") + ")"
            cell.branchName.text = "Video Call Consultations"
            let fees = String(doctorProfileViewModel.videoCallList[indexPath.row].consultationServiceFees ?? 0)
            cell.feesLbl.text = "Fees \(fees) EGP"
            cell.availableTimeLbl.text = doctorProfileViewModel.videoCallList[indexPath.row].availableText ?? ""
//            let imgURL = URL(string: "\(Constants.baseURLImage)\(doctorProfileViewModel.videoCallList[indexPath.row].imagepath ?? "")")
//            if imgURL != nil {
//                cell.branchImg?.kf.indicatorType = .activity
//                cell.branchImg?.kf.setImage(with: imgURL)
//            } else {
                cell.branchImg.image = (UIImage (named: "ic_video call"))
//            }
            
            return cell
        }
    }
    @objc func addFavourite(tag: UIButton) {
        if tag.tag == 0 {
            callAddToFavApi()
        }else{
            callRemoveFromFavApi()
        }
        doctorProfileViewModel.getDoctordata(id: doctorId ?? 0)
        doctorProfileTB.reloadData()
    }
    @objc func moreDetails() {
        doctorDetails = true
        doctorProfileTB.reloadData()
    }
    @objc func bookingBranch(sender: UIButton) {
        let vc = AddAppointmentVC()
        vc.branchList = doctorProfileViewModel.branchList[sender.tag]
        vc.consultationService = 1
        vc.doctorId = self.doctorId
        vc.branchId = doctorProfileViewModel.branchList[sender.tag].businessProviderBranchFk ?? 0
        vc.doctorName = (doctorProfileViewModel.doctorData?.prefixTitle_Localized ?? "") + " " + (doctorProfileViewModel.doctorData?.doctorName ?? "")
        vc.doctorImg = "\(Constants.baseURLImage)\(doctorProfileViewModel.doctorData?.profileImage ?? "")"
        vc.medicalServiceList = doctorProfileViewModel.branchList[sender.tag].medicalServiceList
        self.show(vc, sender: nil)
    }
    @objc func bookingHome(sender: UIButton) {
        let vc = AddAppointmentVC()
        vc.branchList = doctorProfileViewModel.homeVisit[sender.tag]
        vc.consultationService = 3
        vc.doctorId = self.doctorId
        self.show(vc, sender: nil)
    }
    @objc func bookingVideoCall(sender: UIButton) {
        let vc = AddAppointmentVC()
        if sender.tag > doctorProfileViewModel.videoCallList.count {
            return
        }else{
            vc.branchList = doctorProfileViewModel.videoCallList[sender.tag]
            vc.consultationService = 2
            vc.doctorId = self.doctorId
            vc.doctorName = (doctorProfileViewModel.doctorData?.prefixTitle_Localized ?? "") + " " + (doctorProfileViewModel.doctorData?.doctorName ?? "")
            vc.doctorImg = "\(Constants.baseURLImage)\(doctorProfileViewModel.doctorData?.profileImage ?? "")"
            self.show(vc, sender: nil)
        }
        
    }
    @objc func moreAcadimic() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MoreDoctorsBranchVC") as! MoreDoctorsBranchVC
        
        vc.title = "Acadimic Qualifications"
        vc.type = "acadimic"
        vc.acadimicList = doctorProfileViewModel.doctorData?.tblEmployeeAcademicQualification
        
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func moreBranches() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MoreDoctorsBranchVC") as! MoreDoctorsBranchVC
        
        vc.title = "Branches List"
        vc.type = "branch"
        vc.moreVisit = doctorProfileViewModel.branchList
        vc.doctorId = self.doctorId
        vc.doctorName = (doctorProfileViewModel.doctorData?.prefixTitle_Localized ?? "") + " " + (doctorProfileViewModel.doctorData?.doctorName ?? "")
        vc.doctorImg = "\(Constants.baseURLImage)\(doctorProfileViewModel.doctorData?.profileImage ?? "")"
        
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func moreClinic() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MoreDoctorsBranchVC") as! MoreDoctorsBranchVC
        
        vc.title = ""
        vc.type = "home"
        vc.moreVisit = doctorProfileViewModel.homeVisit
        vc.moreVisit = doctorProfileViewModel.branchList
        vc.doctorId = self.doctorId
        vc.doctorName = (doctorProfileViewModel.doctorData?.prefixTitle_Localized ?? "") + " " + (doctorProfileViewModel.doctorData?.doctorName ?? "")
        vc.doctorImg = "\(Constants.baseURLImage)\(doctorProfileViewModel.doctorData?.profileImage ?? "")"
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func moreVideos() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MoreDoctorsBranchVC") as! MoreDoctorsBranchVC
        
        vc.title = ""
        vc.type = "video"
        vc.moreVisit = doctorProfileViewModel.videoCallList
        vc.moreVisit = doctorProfileViewModel.branchList
        vc.doctorId = self.doctorId
        vc.doctorName = (doctorProfileViewModel.doctorData?.prefixTitle_Localized ?? "") + " " + (doctorProfileViewModel.doctorData?.doctorName ?? "")
        vc.doctorImg = "\(Constants.baseURLImage)\(doctorProfileViewModel.doctorData?.profileImage ?? "")"
        
        navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 3 {
            let vc = BranchInfoVCViewController()
            vc.branchList = doctorProfileViewModel.branchList[indexPath.row]
            self.show(vc, sender: nil)
        } else if indexPath.section == 4 {
            let vc = HomeInfoVC()
            vc.homeList = doctorProfileViewModel.homeVisit[indexPath.row]
            self.show(vc, sender: nil)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func callRemoveFromFavApi(){
        showUniversalLoadingView(true)
        NetworkClient.performRequest(_type: RegisterModel.self, router: .RemoveFavouriteDoctor(id: doctorId ?? 0)) { (result) in
            showUniversalLoadingView(false)
            switch result{
            case .success(let model):
                print(model)
                if model.successtate == 200{
                    print("success home")
                    self.doctorProfileTB.reloadData()
                }else{

                }
            case .failure(let model):
                self.showMessage(title: "", sub: "error connecting to server. please try again", type: .error, layout: .messageView)
                print("failure: \(model)")
            
            }
        }
    }
    func callAddToFavApi(){
        showUniversalLoadingView(true)
        NetworkClient.performRequest(_type: RegisterModel.self, router: .AddFavouriteDoctor(id: doctorId ?? 0)) { (result) in
            showUniversalLoadingView(false)
            switch result{
            case .success(let model):
                print(model)
                if model.successtate == 200{
                    print("success home")
                    self.doctorProfileTB.reloadData()
                }else{

                }
            case .failure(let model):
                self.showMessage(title: "", sub: "error connecting to server. please try again", type: .error, layout: .messageView)
                print("failure: \(model)")
            
            }
        }
    }
}
