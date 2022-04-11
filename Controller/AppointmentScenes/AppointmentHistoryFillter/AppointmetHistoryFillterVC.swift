//
//  AppointmetHistoryFillterVC.swift
//  E4 Patient
//
//  Created by mohab on 09/05/2021.
//

import UIKit

class AppointmetHistoryFillterVC: UIViewController {
    @IBOutlet var serviseView: UIView!
    @IBOutlet var statusView: UIView!
    @IBOutlet weak var selectServiceLBL: UILabel!
    @IBOutlet weak var AllIcon: UIImageView!
    @IBOutlet weak var allLBL: UILabel!
    @IBOutlet weak var clinicIcon: UIImageView!
    @IBOutlet weak var clinicLBL: UILabel!
    @IBOutlet weak var videoIcon: UIImageView!
    @IBOutlet weak var videoLBL: UILabel!
    @IBOutlet weak var homeIcon: UIImageView!
    @IBOutlet weak var homeLBL: UILabel!
    @IBOutlet weak var immediateIcon: UIImageView!
    @IBOutlet weak var immediateLBL: UILabel!
    @IBOutlet weak var appointmentStatusLBL: UILabel!
    @IBOutlet weak var finishIcon: UIImageView!
    @IBOutlet weak var finishLBL: UILabel!
    @IBOutlet weak var cancelIcon: UIImageView!
    @IBOutlet weak var cancelLBL: UILabel!
    @IBOutlet weak var noShowIcon: UIImageView!
    @IBOutlet weak var noShowLBL: UILabel!
    @IBOutlet weak var resetBTN: UIButton!
    @IBOutlet weak var searchBTN: UIButton!
    var consultationServiceFk = 0
    //1,0 >> Waiting 2 >> Confirm
    var AppointmentStatus = [0,1,2]
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationItem.title = "Filter".localized
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColor.Blue]
        selectServiceLBL.text = "Select Service Type"
        appointmentStatusLBL.text = "Appointment Status"
        searchBTN.setTitle("Search", for: .normal)
        resetBTN.setTitle("Reset", for: .normal)
        allLBL.text = "All"
        clinicLBL.text = "Clinic Consultation"
        videoLBL.text = "Video Call Consultation"
        homeLBL.text = "Home Visit"
        immediateLBL.text = "Immediate Video Call"
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        serviseView.ShadowView(view: serviseView, radius: 10, opacity: 2, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        statusView.ShadowView(view: statusView, radius: 10, opacity: 2, shadowRadius: 2, color: UIColor.lightGray.cgColor)
    }
    @IBAction func search_click(_ sender: Any) {
        let vc = AppointmentVC()
        vc.fromFilter = true
        vc.consultationServiceFk = consultationServiceFk
        vc.AppointmentStatus = AppointmentStatus
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func reset_Click(_ sender: Any) {
        let vc = AppointmentVC()
        vc.fromFilter = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func AllBtnSelected(_ sender: Any) {
        consultationServiceFk = 0
        allLBL.textColor = UIColor (named: "Blue")
        clinicLBL.textColor = UIColor.gray
        videoLBL.textColor = UIColor.gray
        homeLBL.textColor = UIColor.gray
        immediateLBL.textColor = UIColor.gray
        
        AllIcon.image = UIImage (named: "ic_radiobtn_active")
        clinicIcon.image = UIImage (named: "ic_radiobtn_unactive")
        videoIcon.image = UIImage (named: "ic_radiobtn_unactive")
        homeIcon.image = UIImage (named: "ic_radiobtn_unactive")
        immediateIcon.image = UIImage (named: "ic_radiobtn_unactive")
    }
    
    @IBAction func clinicBTNSelected(_ sender: Any) {
        consultationServiceFk = 1
        clinicLBL.textColor = UIColor (named: "Blue")
        allLBL.textColor = UIColor.gray
        videoLBL.textColor = UIColor.gray
        homeLBL.textColor = UIColor.gray
        immediateLBL.textColor = UIColor.gray
        
        AllIcon.image = UIImage (named: "ic_radiobtn_unactive")
        clinicIcon.image = UIImage (named: "ic_radiobtn_active")
        videoIcon.image = UIImage (named: "ic_radiobtn_unactive")
        homeIcon.image = UIImage (named: "ic_radiobtn_unactive")
        immediateIcon.image = UIImage (named: "ic_radiobtn_unactive")
    }
    
    @IBAction func videoBTNSelected(_ sender: Any) {
        consultationServiceFk = 2
        videoLBL.textColor = UIColor (named: "Blue")
        clinicLBL.textColor = UIColor.gray
        allLBL.textColor = UIColor.gray
        homeLBL.textColor = UIColor.gray
        immediateLBL.textColor = UIColor.gray
        
        AllIcon.image = UIImage (named: "ic_radiobtn_unactive")
        videoIcon.image = UIImage (named: "ic_radiobtn_active")
        clinicIcon.image = UIImage (named: "ic_radiobtn_unactive")
        homeIcon.image = UIImage (named: "ic_radiobtn_unactive")
        immediateIcon.image = UIImage (named: "ic_radiobtn_unactive")
    }
    @IBAction func homeBTNSelected(_ sender: Any) {
        consultationServiceFk = 3
        homeLBL.textColor = UIColor (named: "Blue")
        clinicLBL.textColor = UIColor.gray
        videoLBL.textColor = UIColor.gray
        allLBL.textColor = UIColor.gray
        immediateLBL.textColor = UIColor.gray
        
        AllIcon.image = UIImage (named: "ic_radiobtn_unactive")
        homeIcon.image = UIImage (named: "ic_radiobtn_active")
        videoIcon.image = UIImage (named: "ic_radiobtn_unactive")
        clinicIcon.image = UIImage (named: "ic_radiobtn_unactive")
        immediateIcon.image = UIImage (named: "ic_radiobtn_unactive")
    }
    @IBAction func immediateBTNSelected(_ sender: Any) {
        consultationServiceFk = 4
        immediateLBL.textColor = UIColor (named: "Blue")
        clinicLBL.textColor = UIColor.gray
        videoLBL.textColor = UIColor.gray
        allLBL.textColor = UIColor.gray
        homeLBL.textColor = UIColor.gray
        
        AllIcon.image = UIImage (named: "ic_radiobtn_unactive")
        immediateIcon.image = UIImage (named: "ic_radiobtn_active")
        videoIcon.image = UIImage (named: "ic_radiobtn_unactive")
        homeIcon.image = UIImage (named: "ic_radiobtn_unactive")
        clinicIcon.image = UIImage (named: "ic_radiobtn_unactive")
    }
    @IBAction func finishBTNSelected(_ sender: Any) {
        AppointmentStatus = [5]
        finishLBL.textColor = UIColor (named: "Blue")
        cancelLBL.textColor = UIColor.gray
        noShowLBL.textColor = UIColor.gray
        
        cancelIcon.image = UIImage (named: "ic_radiobtn_unactive")
        finishIcon.image = UIImage (named: "ic_radiobtn_active")
        noShowIcon.image = UIImage (named: "ic_radiobtn_unactive")
    }
    @IBAction func cancelBTNSelected(_ sender: Any) {
        AppointmentStatus = [3,4]
        finishLBL.textColor = UIColor.gray
        noShowLBL.textColor = UIColor.gray
        cancelLBL.textColor = UIColor (named: "Blue")
        
        finishIcon.image = UIImage (named: "ic_radiobtn_unactive")
        cancelIcon.image = UIImage (named: "ic_radiobtn_active")
        noShowIcon.image = UIImage (named: "ic_radiobtn_unactive")
    }
    @IBAction func noShowBTNSelected(_ sender: Any) {
        AppointmentStatus = [6]
        finishLBL.textColor = UIColor.gray
        cancelLBL.textColor = UIColor.gray
        noShowLBL.textColor = UIColor (named: "Blue")
        
        finishIcon.image = UIImage (named: "ic_radiobtn_unactive")
        noShowIcon.image = UIImage (named: "ic_radiobtn_active")
        cancelIcon.image = UIImage (named: "ic_radiobtn_unactive")
    }

    



}
