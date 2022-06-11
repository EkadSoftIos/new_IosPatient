//
//  AllEmergencyContactsVC.swift
//  E4 Patient
//
//  Created by mohab on 19/01/2021.
//

import UIKit

class AllEmergencyContactsVC: UIViewController {
    @IBOutlet var EmergencyTableView: UITableView!
    @IBOutlet var addView: UIView!
    
    var model: UserDataModel?
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1.5) {
            self.addView.rotate(angle: 180)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        if model?.message?.tblPatientContact?.count == 0{
            EmergencyTableView.setEmptyView()
        }else{
            EmergencyTableView.restore()
        }
        self.navigationItem.title = "Emergency Contacts".localized
    }
    func setupTableView(){
        EmergencyTableView.register(EmergencyContactsCell.nib, forCellReuseIdentifier: "EmergencyCell")
        EmergencyTableView.separatorStyle = .none
        EmergencyTableView.delegate = self
        EmergencyTableView.dataSource = self
    }
    @IBAction func add_Click(_ sender: Any) {
        let vc = AddEmergencyVC()
        vc.model = model
        vc.Delegete = self
        vc.isUpdate = false
        show(vc, sender: nil)
    }
    

}
extension AllEmergencyContactsVC: AddEmergency{
    func Data(isAdded: Bool) {
        callApiAdd()
    }
    
    
}
