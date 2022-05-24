//
//  ProfileVC.swift
//  E4 Patient
//
//  Created by mohab on 18/01/2021.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var summaryLbl: UILabel!
    @IBOutlet weak var summaryImage: UIImageView!
    @IBOutlet weak var summaryView: UIView!
    @IBOutlet var profileView: UIView!
    @IBOutlet var buttomView: UIView!
    @IBOutlet var PatientInfoView: UIView!
    @IBOutlet var healthView: UIView!
    @IBOutlet var profileTableView: UITableView!
    @IBOutlet var buttomViewWidht: NSLayoutConstraint!
    @IBOutlet var healthInfoLbl: UILabel!
    @IBOutlet var healthInfoImage: UIImageView!
    @IBOutlet var patiientInfoLbl: UILabel!
    @IBOutlet var patientInfoImage: UIImageView!
    @IBOutlet var scrollHeight: NSLayoutConstraint!
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var joinAtLbl: UILabel!
    @IBOutlet var progressLBl: UILabel!
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var patientIDLbl: UILabel!
    @IBOutlet var progressView: UIProgressView!
    var buttonType: Int = 0
    let patientInfoArr = ["All Address".localized,"Insurance".localized,"Emergency Contacts".localized]
    let healthInfoArr = ["Follow Up", "Diseases / Conditions".localized,"Medications".localized,"Allergies".localized,"Social History".localized,"Family History".localized,"Surgery / Implants".localized,"Medical Reports".localized]
    var userData: UserDataModel?
    override func viewWillAppear(_ animated: Bool) {
        callApi()
        getSummaryClickData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollHeight.constant = 650
        self.navigationItem.title = "My Profile".localized
        buttomViewWidht.constant = view.frame.width / 3
        profileView.ShadowView(view: profileView, radius: 10, opacity: 0.4, shadowRadius: 6, color: UIColor.darkGray.cgColor)
        setupTableView()
        
    }
    
    func convertDateFormat(inputDate: String) -> String {

         let olDateFormatter = DateFormatter()
         olDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"

        let oldDate = olDateFormatter.date(from: inputDate) ?? Date()

         let convertDateFormatter = DateFormatter()
         convertDateFormatter.dateFormat = "MMMM dd yyyy"
        convertDateFormatter.locale = Locale(identifier: "en_US_POSIX")
         return convertDateFormatter.string(from: oldDate)
    }
    override func viewWillDisappear(_ animated: Bool) {
   }
    func getSummaryClickData(){
        UIView.animate(withDuration: 1) {
            self.scrollHeight.constant = CGFloat((self.userData?.message?.visitSummery?.count ?? 0) * 140) + 260
            self.buttomView.center.x = self.summaryView.center.x
            self.summaryLbl.textColor = AppColor.Blue
            self.patiientInfoLbl.textColor = AppColor.Gray
            self.healthInfoLbl.textColor = AppColor.Gray
            self.healthInfoImage.image = UIImage(named: "ic_health_active")
            self.patientInfoImage.image = UIImage(named: "ic_profile_unactive")
            self.summaryImage.image = UIImage(named: "ic_health_active-1")
            self.view.layoutIfNeeded()
        }
        buttonType = 2 //->
        self.profileTableView.reloadData()
    }
    @IBAction func visitSummaryClick(_ sender: Any) {
        getSummaryClickData()
    }
    @IBAction func editProfile_Click(_ sender: Any) {
        let vc = EditProfileVC()
        vc.model = userData
        vc.Delegete = self
        show(vc, sender: nil)
    }
    @IBAction func health_Click(_ sender: Any) {
        UIView.animate(withDuration: 1) {
            self.scrollHeight.constant = 1250
            self.buttomView.center.x = self.healthView.center.x
            self.healthInfoLbl.textColor = AppColor.Blue
            self.summaryLbl.textColor = AppColor.Gray
            self.patiientInfoLbl.textColor = AppColor.Gray
            self.healthInfoImage.image = UIImage(named: "ic_health_active-1")
            self.patientInfoImage.image = UIImage(named: "ic_profile_unactive")
            self.summaryImage.image = UIImage(named: "ic_health_active")
            self.view.layoutIfNeeded()
        }
        buttonType = 1
        self.profileTableView.reloadData()
    }
    @IBAction func profilePopUp_Click(_ sender: Any) {
        let vc = ProfileDataPopUpVC()
        vc.model = userData?.message?.profilepercentageList
        vc.progress = userData?.message?.profilePercentage
         vc.modalPresentationStyle = .overCurrentContext
         vc.modalTransitionStyle = .crossDissolve
         self.present(vc, animated: true, completion: nil)
    }
    @IBAction func patient_Click(_ sender: Any) {
        UIView.animate(withDuration: 1) {
            self.scrollHeight.constant = 700
            self.buttomView.center.x = self.PatientInfoView.center.x
            self.patiientInfoLbl.textColor = AppColor.Blue
            self.healthInfoLbl.textColor = AppColor.Gray
            self.summaryLbl.textColor = AppColor.Gray
            self.healthInfoImage.image = UIImage(named: "ic_health_active")
            self.patientInfoImage.image = UIImage(named: "profile")
            self.summaryImage.image = UIImage(named: "ic_health_active")
            self.view.layoutIfNeeded()
        }
        buttonType = 0
        self.profileTableView.reloadData()
    }
    func setupTableView(){
        profileTableView.register(ProfileCell.nib, forCellReuseIdentifier: "profileCell")
        profileTableView.register(UINib(nibName: "ProfileSummaryCell", bundle: nil), forCellReuseIdentifier: "ProfileSummaryCell")
        profileTableView.separatorStyle = .none
        profileTableView.delegate = self
        profileTableView.dataSource = self
    }
}
extension ProfileVC : isProfileEdit{
    func Data(isAdded: Bool) {
        callApi()
    }
    
    
}
