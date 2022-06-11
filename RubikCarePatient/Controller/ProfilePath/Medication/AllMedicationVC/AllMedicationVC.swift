//
//  AllMedicationVC.swift
//  E4 Patient
//
//  Created by mohab on 19/01/2021.
//

import UIKit

class AllMedicationVC: UIViewController {
    @IBOutlet var medicationTableView: UITableView!
    @IBOutlet var addView: UIView!
    var model: UserDataModel?
    override func viewWillAppear(_ animated: Bool) {
        callApiAdd()
        UIView.animate(withDuration: 1.5) {
            self.addView.rotate(angle: 180)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        if model?.message?.tblPatientMedicine?.count == 0{
            medicationTableView.setEmptyView()
        }else{
            medicationTableView.restore()
        }
        self.navigationItem.title = "Medication".localized
    }
    func setupTableView(){
        medicationTableView.register(MedicationCell.nib, forCellReuseIdentifier: "MedicationCell")
        medicationTableView.separatorStyle = .none
        medicationTableView.delegate = self
        medicationTableView.dataSource = self
    }
    @IBAction func add_Click(_ sender: Any) {
        let vc = AddMedicationListVC()
        vc.userModel = model
        vc.Delegete = self
        show(vc, sender: true)
    }
}
extension AllMedicationVC: addmedicationList{
    func Data(isAdded: Bool) {
       callApiAdd()
    }
    
}
