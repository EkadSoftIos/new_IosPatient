//
//  HomeInfoVC.swift
//  E4 Patient
//
//  Created by mohab on 09/05/2021.
//

import UIKit

class HomeInfoVC: UIViewController {
    
    var homeList: ServiceList?
    
    @IBOutlet var homeView: UIView!
    @IBOutlet var serviseView: UIView!
    @IBOutlet var serviseTableView: UITableView!
    @IBOutlet var moreBTN: UIButton!
    @IBOutlet weak var doctorMedicalServiceLBL: UILabel!
    @IBOutlet weak var homeVisitLBL: UILabel!
    @IBOutlet weak var firstServiceLBL: UILabel!
    @IBOutlet weak var viewHeightConstraint: NSLayoutConstraint!
    override func viewWillAppear(_ animated: Bool) {
        setLocalization()
        if  homeList?.medicalServiceList?.count ?? 0 > 1{
            moreBTN.isHidden = false
            viewHeightConstraint.constant = 120
            firstServiceLBL.text = homeList?.medicalServiceList?[0].medicalServiceNameLocalized ?? ""
        }else {
            moreBTN.isHidden = true
            viewHeightConstraint.constant = 40
        }
        
        self.navigationItem.title = "Home Info".localized
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColor.Blue]
    }
    func setLocalization(){
        
        homeVisitLBL.text = "HomeVisit".localized
        doctorMedicalServiceLBL.text = "DoctorMedicalService".localized
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        serviseView.ShadowView(view: serviseView, radius: 10, opacity: 2, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        homeView.ShadowView(view: homeView, radius: 10, opacity: 2, shadowRadius: 2, color: UIColor.lightGray.cgColor)
    }

    @IBAction func moreAction(_ sender: Any) {
        let vc = HomeInfoTableVC()
        vc.homeList = homeList
        self.navigationController?.pushViewController(vc, animated: true)
    }

 

}

