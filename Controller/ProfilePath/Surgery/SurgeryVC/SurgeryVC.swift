//
//  SurgeryVC.swift
//  E4 Patient
//
//  Created by mohab on 23/01/2021.
//

import UIKit

class SurgeryVC: UIViewController {
    @IBOutlet var sugaryTable: UITableView!
    @IBOutlet var addView: UIView!
    var model: UserDataModel?
    override func viewWillAppear(_ animated: Bool) {
        emptyTable()
        UIView.animate(withDuration: 1.5) {
            self.addView.rotate(angle: 180)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()

        self.navigationItem.title = "Surgery / Implants".localized
    }
    func emptyTable(){
        if model?.message?.tblPatientSurgery?.count == 0{
            sugaryTable.setEmptyView()
        }else{
            sugaryTable.restore()
        }
    }
    func setupTableView(){
        sugaryTable.register(DieseasesCell.nib, forCellReuseIdentifier: "DieseasesCell")
        sugaryTable.separatorStyle = .none
        sugaryTable.delegate = self
        sugaryTable.dataSource = self
    }
    

    @IBAction func add_CLick(_ sender: Any) {
        let vc = AddSurgeryVC()
        vc.Delegete = self
        vc.isUpdate = false
        show(vc, sender: nil)
    }
    
   
}
extension SurgeryVC: AddSurgery , DeleteSurgey{
    func Data(isAdded: Bool) {
        if isAdded == true{
            callApiAdd()
        }
    }
    
    
}
