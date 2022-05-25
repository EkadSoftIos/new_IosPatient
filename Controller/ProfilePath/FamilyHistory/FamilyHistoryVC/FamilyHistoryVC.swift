//
//  FamilyHistoryVC.swift
//  E4 Patient
//
//  Created by mohab on 23/01/2021.
//

import UIKit

class FamilyHistoryVC: UIViewController {
    @IBOutlet var familyTable: UITableView!
    @IBOutlet var addView: UIView!
    var model: UserDataModel?
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1.5) {
            self.addView.rotate(angle: 180)
        }
        if model?.message?.tblPatientSocialFamily?.count == 0{
            familyTable.setEmptyView()
        }else{
            familyTable.restore()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        self.navigationItem.title = "Family History".localized
    }
    func setupTableView(){
        familyTable.register(DieseasesCell.nib, forCellReuseIdentifier: "DieseasesCell")
        familyTable.separatorStyle = .none
        familyTable.delegate = self
        familyTable.dataSource = self
    }

    @IBAction func add_CLick(_ sender: Any) {
        let vc = AddFamilyHistoryVC()
        vc.isUpdate = false
        vc.model = model
        vc.Delegete = self
        show(vc, sender: nil)
    }
}
extension FamilyHistoryVC: AddFamily , DeleteFamilyHistory{
    func Data(isAdded: Bool) {
        if isAdded == true{
            callApiAdd()
        }
    }
    
}
