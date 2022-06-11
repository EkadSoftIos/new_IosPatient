//
//  AllAllergiesVC.swift
//  E4 Patient
//
//  Created by mohab on 20/01/2021.
//

import UIKit

class AllAllergiesVC: UIViewController {
    @IBOutlet var allergiesTableView: UITableView!
    @IBOutlet var addView: UIView!
    var model: UserDataModel?
    
    override func viewWillAppear(_ animated: Bool) {
        emptyData()
        UIView.animate(withDuration: 1.5) {
            self.addView.rotate(angle: 180)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Allergies".localized
        setupTableView()

    }
    func emptyData(){
        if model?.message?.tblPatientAllergies?.count == 0{
            allergiesTableView.setEmptyView()
        }else{
            allergiesTableView.restore()
        }
    }
    func setupTableView(){
        allergiesTableView.register(AllAllergiesCell.nib, forCellReuseIdentifier: "AllAllergiesCell")
        allergiesTableView.separatorStyle = .none
        allergiesTableView.delegate = self
        allergiesTableView.dataSource = self
    }
    @IBAction func add_click(_ sender: Any) {
        let vc = AddAllergiesVC()
        vc.Delegete = self
        vc.isUpdate = false
        self.show(vc, sender: nil)
    }
}
extension AllAllergiesVC: addAllergies , DeleteAllergies{
    func Data(isAdded: Bool) {
        callApiAdd()
    }
}
