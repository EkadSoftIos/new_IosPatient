//
//  EmergencyNumberVC.swift
//  E4 Patient
//
//  Created by mohab on 24/01/2021.
//

import UIKit

class EmergencyNumberVC: UIViewController {
    @IBOutlet var emergencyTable: UITableView!
    var model: GetEmergencyModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        callApi()
        self.navigationItem.title = "Emergency Contacts".localized
    }
    func setupTableView(){
        emergencyTable.register(EmergencyNumberCellTableViewCell.nib, forCellReuseIdentifier: "EmergencyNumberCellTableViewCell")
        emergencyTable.separatorStyle = .none
        emergencyTable.delegate = self
        emergencyTable.dataSource = self
    }


   

}
