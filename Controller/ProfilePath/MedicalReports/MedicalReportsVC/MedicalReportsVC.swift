//
//  MedicalReportsVC.swift
//  E4 Patient
//
//  Created by mohab on 23/01/2021.
//

import UIKit

class MedicalReportsVC: UIViewController {
    @IBOutlet var medicalTable: UITableView!
    @IBOutlet var addView: UIView!
    var model: UserDataModel?
    
    override func viewWillAppear(_ animated: Bool) {
        emptyTableView()
        UIView.animate(withDuration: 1.5) {
            self.addView.rotate(angle: 180)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Medical Reports".localized
        setupTableView()

    }
    func emptyTableView(){
        if model?.message?.tblPatientMedicalReport?.count == 0{
            medicalTable.setEmptyView()
        }else{
            medicalTable.restore()
        }
    }
    func setupTableView(){
        medicalTable.register(MedicalReportCell.nib, forCellReuseIdentifier: "MedicalReportCell")
        medicalTable.separatorStyle = .none
        medicalTable.delegate = self
        medicalTable.dataSource = self
    }
    @IBAction func Add_CLick(_ sender: Any) {
        let vc = AddMedicalReportsVC()
        vc.isUpdate = false
        vc.model = model
        vc.Delegete = self
        show(vc, sender: nil)
    }
    
}
extension MedicalReportsVC: AddMedicalReport ,DeleteMedicalReports{
    func Data(isAdded: Bool) {
        callApiAdd()
    }
    
    
}
