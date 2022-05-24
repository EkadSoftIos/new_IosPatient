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
    
    @IBOutlet weak var doctorMedicalServiceLBL: UILabel!
    @IBOutlet weak var homeVisitLBL: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        setLocalization()
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
        setupTableView()
    }

    func setupTableView(){
        serviseTableView.register(DoctorServiseCell.nib, forCellReuseIdentifier: "DoctorServiseCell")
        serviseTableView.delegate = self
        serviseTableView.dataSource = self
        serviseTableView.separatorStyle = .none
    }
 

}
extension HomeInfoVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeList?.medicalServiceList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorServiseCell") as! DoctorServiseCell
        cell.selectionStyle = .none
        
        cell.medicalName.text = homeList?.medicalServiceList?[indexPath.row].medicalServiceNameLocalized ?? ""
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}
