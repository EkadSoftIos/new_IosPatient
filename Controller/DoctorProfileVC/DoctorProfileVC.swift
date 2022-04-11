//
//  DoctorProfileVC.swift
//  E4 Patient
//
//  Created by mohab on 06/05/2021.
//

import UIKit

class DoctorProfileVC: UIViewController, BaseViewProtocol {
    
    var doctorId: Int?
    var doctorProfileViewModel = DoctorProfileViewModel()
    
    let vw = UIView(frame: UIScreen.main.bounds)
    let indicator = UIActivityIndicatorView(style: .whiteLarge)
    @IBOutlet weak var branchHeight: NSLayoutConstraint!
    @IBOutlet weak var videoCallHeight: NSLayoutConstraint!
    @IBOutlet weak var homeHight: NSLayoutConstraint!
    @IBOutlet weak var moreVideoBtn: UIButton!
    @IBOutlet weak var videoDateLbl: UILabel!
    @IBOutlet weak var videoFeesLbl: UILabel!
    @IBOutlet weak var videoCallImg: UIImageView!
    @IBOutlet weak var videoCallLbl: UILabel!
    @IBOutlet weak var moreHomeBtn: UIButton!
    @IBOutlet weak var homeDate: UILabel!
    @IBOutlet weak var homeFeesLbl: UILabel!
    @IBOutlet weak var homeTitleLbl: UILabel!
    @IBOutlet weak var homeImg: UIImageView!
    @IBOutlet weak var branchImage: UIImageView!
    @IBOutlet weak var moreBranchBtn: UIButton!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var feeslbl: UILabel!
    @IBOutlet weak var branchNameLbl: UILabel!
    @IBOutlet weak var acadimicQualificationConst: NSLayoutConstraint!
    @IBOutlet weak var moreAcadimcBtn: UIButton!
    @IBOutlet weak var graduationName: UILabel!
    @IBOutlet weak var acadimicQualificationFrom: UILabel!
    @IBOutlet weak var acadimcDateLbl: UILabel!
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var constHeightDetailsLbl: NSLayoutConstraint!
    @IBOutlet weak var doctorDetailsLbl: UILabel!
    @IBOutlet weak var totalAppointementLbl: UILabel!
    @IBOutlet weak var totalPatientLbl: UILabel!
    @IBOutlet weak var doctorViewerNumber: UILabel!
    @IBOutlet weak var rateLbl: UILabel!
    @IBOutlet weak var doctorDetails: UILabel!
    @IBOutlet weak var doctorName: UILabel!
    @IBOutlet weak var doctorImage: UIImageView!
    @IBOutlet var dataView: UIView!
    @IBOutlet var abotView: UIView!
    @IBOutlet var acadimicView: UIView!
    @IBOutlet var addressView: UIView!
    @IBOutlet var homeVisitView: UIView!
    @IBOutlet var videoCallView: UIView!
    @IBOutlet var favBTN: UIButton!

    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Doctor Profile".localized
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColor.Blue]
        doctorProfileViewModel.getDoctordata(id: doctorId ?? 0)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initBinding()
        
        
        dataView.ShadowView(view: dataView, radius: 10, opacity: 0.4, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        abotView.ShadowView(view: abotView, radius: 10, opacity: 0.4, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        acadimicView.ShadowView(view: acadimicView, radius: 10, opacity: 0.4, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        addressView.ShadowView(view: addressView, radius: 10, opacity: 0.4, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        homeVisitView.ShadowView(view: homeVisitView, radius: 10, opacity: 0.4, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        videoCallView.ShadowView(view: videoCallView, radius: 10, opacity: 0.4, shadowRadius: 2, color: UIColor.lightGray.cgColor)
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
                self.setDoctorData()
            }
        }
        doctorProfileViewModel.showError.addObserver { [weak self] (value) in
            guard let self = self else {return}
            if value != "" {
                DispatchQueue.main.async { self.showAlert(message: value) }
            }
        }
    }
    func setDoctorData() {
        let doctorProfileData = doctorProfileViewModel.doctorData
        if doctorProfileData?.isFavourite == true {
            self.favBTN.setImage(UIImage (named: "ic_fav"), for: .normal)
            self.favBTN.tag = 1
        }else{
            self.favBTN.setImage(UIImage (named: "unfav"), for: .normal)
            self.favBTN.tag = 0
        }
        let imgURL = URL(string: "\(Constants.baseURLImage)\(doctorProfileData?.profileImage ?? "")")
        doctorImage?.kf.indicatorType = .activity
        doctorImage?.kf.setImage(with: imgURL)
        Animation.roundView(doctorImage)
        doctorDetails.text = doctorProfileData?.fullProfisionalDetails_Localized ?? ""
        doctorName.text = (doctorProfileData?.prefixTitle_Localized ?? "") + " " + (doctorProfileData?.doctorName ?? "")
        rateLbl.text = doctorProfileData?.totalpatientRateCount ?? "0"
        doctorViewerNumber.text = doctorProfileData?.viewersnumber ?? "0"
        totalPatientLbl.text = doctorProfileData?.totalpatient ?? "0"
        totalAppointementLbl.text = doctorProfileData?.totalappointment ?? "0"
        
        doctorDetailsLbl.text = doctorProfileData?.fullProfisionalDetails_Localized ?? ""
        var txt = ""
        if doctorDetailsLbl.text!.count > 30 {
            moreBtn.isHidden = false
            let str = doctorDetailsLbl.text ?? ""
            for (_, char) in str.enumerated() {
                if txt.count <= 30 {
                    txt.append(char)
                    doctorDetailsLbl.text = txt
                } else {
                    break
                }
            }
        } else {
            moreBtn.isHidden = true
        }
        
        if doctorProfileData?.tblEmployeeAcademicQualification?.count != 0 {
            acadimicQualificationConst.constant = 108
            graduationName.text = doctorProfileData?.tblEmployeeAcademicQualification?[0].graduationType_Localized ?? ""
            acadimicQualificationFrom.text = doctorProfileData?.tblEmployeeAcademicQualification?[0].qualificationFromname_Localized ?? ""
            acadimcDateLbl.text = String(doctorProfileData?.tblEmployeeAcademicQualification?[0].yearOfComplete ?? 0000)
        } else {
            acadimicQualificationConst.constant = 0
        }
        if (doctorProfileData?.tblEmployeeAcademicQualification?.count ?? 0) > 1 {
            moreAcadimcBtn.isHidden = false
        } else {
            moreAcadimcBtn.isHidden = true
        }
         
        if doctorProfileViewModel.branchList.count != 0 {
            let branchname = (doctorProfileViewModel.branchList[0].entityName_Localized ?? "") + "("+(doctorProfileViewModel.branchList[0].branchName_Localized ?? "") + ")"
            branchNameLbl.text = branchname
            let fees = String(doctorProfileViewModel.branchList[0].consultationServiceFees ?? 0)
            feeslbl.text = "Fees \(fees) EGP"
            dateLbl.text = doctorProfileViewModel.branchList[0].availableText ?? ""
            let imgURL = URL(string: "\(Constants.baseURLImage)\(doctorProfileViewModel.branchList[0].imagepath ?? "")")
            branchImage?.kf.indicatorType = .activity
            branchImage?.kf.setImage(with: imgURL)
            
            if doctorProfileViewModel.branchList.count > 1 {
                moreBranchBtn.isHidden = false
            } else {
                moreBranchBtn.isHidden = true
            }
        } else {
            branchHeight.constant = 0
            addressView.isHidden = true
        }
        if doctorProfileViewModel.homeVisit.count != 0 {
            let branchname = (doctorProfileViewModel.homeVisit[0].entityName_Localized ?? "") + "("+(doctorProfileViewModel.homeVisit[0].branchName_Localized ?? "") + ")"
            homeTitleLbl.text = branchname
            let fees = String(doctorProfileViewModel.homeVisit[0].consultationServiceFees ?? 0)
            homeFeesLbl.text = "Fees \(fees) EGP"
            homeDate.text = doctorProfileViewModel.homeVisit[0].availableText ?? ""
            let imgURL = URL(string: "\(Constants.baseURLImage)\(doctorProfileViewModel.homeVisit[0].imagepath ?? "")")
            videoCallImg?.kf.indicatorType = .activity
            videoCallImg?.kf.setImage(with: imgURL)
            
            if doctorProfileViewModel.homeVisit.count > 1 {
                moreHomeBtn.isHidden = false
            } else {
                moreHomeBtn.isHidden = true
            }
        } else {
            homeHight.constant = 0
            homeVisitView.isHidden = true
        }
        if doctorProfileViewModel.videoCallList.count != 0 {
            let branchname = (doctorProfileViewModel.videoCallList[0].entityName_Localized ?? "") + "("+(doctorProfileViewModel.videoCallList[0].branchName_Localized ?? "") + ")"
            videoCallLbl.text = branchname
            let fees = String(doctorProfileViewModel.videoCallList[0].consultationServiceFees ?? 0)
            videoFeesLbl.text = "Fees \(fees) EGP"
            videoDateLbl.text = doctorProfileViewModel.videoCallList[0].availableText ?? ""
            let imgURL = URL(string: "\(Constants.baseURLImage)\(doctorProfileViewModel.videoCallList[0].imagepath ?? "")")
            homeImg?.kf.indicatorType = .activity
            homeImg?.kf.setImage(with: imgURL)
            
            if doctorProfileViewModel.videoCallList.count > 1 {
                moreVideoBtn.isHidden = false
            } else {
                moreVideoBtn.isHidden = true
            }
        } else {
            videoCallHeight.constant = 0
            videoCallView.isHidden = true
        }
    }
    @IBAction func moreBranchBtnpressed(_ sender: Any) {
    }
    @IBAction func AddToFavBtnpressed(_ sender: Any) {
        if favBTN.tag == 0 {
            callAddToFavApi()
        }else{
            callRemoveFromFavApi()
        }
        
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
                    self.favBTN.setImage(UIImage (named: "unfav"), for: .normal)
                    self.favBTN.tag = 0
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
                    self.favBTN.setImage(UIImage (named: "ic_fav"), for: .normal)
                    self.favBTN.tag = 0
                }else{

                }
            case .failure(let model):
                self.showMessage(title: "", sub: "error connecting to server. please try again", type: .error, layout: .messageView)
                print("failure: \(model)")
            
            }
        }
    }
    @IBAction func reviews_Click(_ sender: Any) {
        let vc = ReviewsVC()
        vc.doctorId = doctorProfileViewModel.doctorData?.businessProviderEmployeeId ?? 0
        self.show(vc, sender: nil)
    }
    @IBAction func vedio_Click(_ sender: Any) {
    }
    
    @IBAction func bookingLocation_Click(_ sender: Any) {
        let vc = AddAppointmentVC()
        vc.branchList = doctorProfileViewModel.branchList[0]
        vc.consultationService = 1
        vc.doctorId = self.doctorId
        vc.branchId = doctorProfileViewModel.branchList[0].businessProviderBranchFk ?? 0
        vc.doctorName = (doctorProfileViewModel.doctorData?.prefixTitle_Localized ?? "") + " " + (doctorProfileViewModel.doctorData?.doctorName ?? "")
        vc.doctorImg = "\(Constants.baseURLImage)\(doctorProfileViewModel.doctorData?.profileImage ?? "")"
        vc.medicalServiceList = doctorProfileViewModel.branchList[0].medicalServiceList
        self.show(vc, sender: nil)
    }
    @IBAction func acadimicQualification_Click(_ sender: Any) {
        let vc = AcademicQualificationVC()
        vc.academicQualifications = doctorProfileViewModel.doctorData?.tblEmployeeAcademicQualification
        self.show(vc, sender: nil)
    }
    @IBAction func moredoctorDescriptionLbl(_ sender: Any) {
        moreBtn.isHidden = true
        doctorDetailsLbl.numberOfLines = 0
        constHeightDetailsLbl.constant = (doctorDetailsLbl.bounds.size.height) + 70
        let doctorProfileData = doctorProfileViewModel.doctorData
        doctorDetailsLbl.text = doctorProfileData?.fullProfisionalDetails_Localized ?? ""
    }
    

    @IBAction func bookingHomeVisit_Click(_ sender: Any) {
        let vc = AddAppointmentVC()
        vc.branchList = doctorProfileViewModel.homeVisit[0]
        vc.consultationService = 3
        vc.doctorId = self.doctorId
        self.show(vc, sender: nil)
    }
    @IBAction func bookingVedioCall_Click(_ sender: Any) {
        let vc = AddAppointmentVC()
        vc.branchList = doctorProfileViewModel.videoCallList[0]
        vc.consultationService = 2
        vc.doctorId = self.doctorId
        vc.doctorName = (doctorProfileViewModel.doctorData?.prefixTitle_Localized ?? "") + " " + (doctorProfileViewModel.doctorData?.doctorName ?? "")
        vc.doctorImg = "\(Constants.baseURLImage)\(doctorProfileViewModel.doctorData?.profileImage ?? "")"
        self.show(vc, sender: nil)
    }
    @IBAction func branchInfo_Click(_ sender: Any) {
        let vc = BranchInfoVCViewController()
        vc.branchList = doctorProfileViewModel.branchList[0]
        self.show(vc, sender: nil)
    }
    @IBAction func showHomeVisit_click(_ sender: Any) {
        let vc = HomeInfoVC()
        vc.homeList = doctorProfileViewModel.homeVisit[0]
        self.show(vc, sender: nil)
    }
    
}
