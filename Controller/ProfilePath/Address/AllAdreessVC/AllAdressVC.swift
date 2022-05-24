//
//  AllAdressVC.swift
//  E4 Patient
//
//  Created by mohab on 19/01/2021.
//

import UIKit

class AllAdressVC: UIViewController {
    @IBOutlet var adressTableView: UITableView!
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
       
        self.navigationItem.title = "All Address".localized
    }
    func EmptyTable(){
        if model?.message?.tblPatientAddress?.count == 0{
            adressTableView.setEmptyView()
        }else{
            adressTableView.restore()
        }
    }
    
    func setupTableView(){
        adressTableView.register(AllAddressCell.nib, forCellReuseIdentifier: "allAdressCell")
        adressTableView.separatorStyle = .none
        adressTableView.delegate = self
        adressTableView.dataSource = self
    }
    @IBAction func add_Click(_ sender: Any) {
        let vc = AddAddressVC()
        vc.userModel = model
        show(vc, sender: nil)
    }
    
}
extension AllAdressVC: DefultLocation , DeleteLocation{
    func Data(isAdded: Bool) {
        callApiAdd()
    }
}


