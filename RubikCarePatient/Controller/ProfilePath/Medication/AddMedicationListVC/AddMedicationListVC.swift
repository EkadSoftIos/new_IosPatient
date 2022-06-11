//
//  AddMedicationListVC.swift
//  E4 Patient
//
//  Created by mohab on 20/01/2021.
//

import UIKit

class AddMedicationListVC: UIViewController {
    @IBOutlet var medicationTableView: UITableView!
    @IBOutlet var medicationCollectionView: UICollectionView!
    @IBOutlet var changeVIew: UIView!
    @IBOutlet var changeImage: UIImageView!
    @IBOutlet var searchView: UIView!
    @IBOutlet var searchTxt: UITextField!
    var istable = true
    var model: getAllMedicineModel?
    var userModel:  UserDataModel?
    var SearchArr = [String]()
    var Delegete: addmedicationList?
    override func viewWillAppear(_ animated: Bool) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Add Medication".localized
        searchTxt.placeholder = "MedicationName".localized
        changeVIew.ShadowView(view: changeVIew, radius: 5, opacity: 0.5, shadowRadius: 5, color: UIColor.darkGray.cgColor)
        searchTxt.returnKeyType = .search
        setupTableView()
        setupCollectionView()
        medicationTableView.alpha = 0
        medicationCollectionView.alpha = 1
        callApi()
    }

    func setupTableView(){
        medicationTableView.register(addMedicationTableCell.nib, forCellReuseIdentifier: "addMedicationTableCell")
        medicationTableView.separatorStyle = .none
        medicationTableView.delegate = self
        medicationTableView.dataSource = self
    }
    func setupCollectionView(){
        medicationCollectionView.register(AddMedicationCollectionCell.nib, forCellWithReuseIdentifier: "AddMedicationCollectionCell")
        medicationCollectionView.delegate = self
        medicationCollectionView.dataSource = self
    }

    @IBAction func change_CLick(_ sender: Any) {
        switch istable {
        case true:
            UIView.animate(withDuration: 1) {
                self.medicationTableView.alpha = 1
                self.medicationCollectionView.alpha = 0
                self.changeImage.image = #imageLiteral(resourceName: "ic_Graid")
                self.istable = false
                self.view.layoutIfNeeded()
            }
        case false:
            UIView.animate(withDuration: 1) {
                self.medicationTableView.alpha = 0
                self.medicationCollectionView.alpha = 1
                self.changeImage.image = #imageLiteral(resourceName: "ic_list")
                self.istable = true
                self.view.layoutIfNeeded()
            }
        }
    }
    @IBAction func search_Click(_ sender: Any) {
        let vc = SearchVC()
        vc.Delegete = self
        vc.doctorsModel = model
        self.present(vc, animated: true, completion: nil)
    }
}
extension AddMedicationListVC: addmedication{
    func Data(isAdded: Bool, isupdate: Bool) {
        if isupdate == false{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}
extension AddMedicationListVC: SearchDelegete{
    func Data(medModel: AllMedicineMessage) {
        let vc = CountinueAddMedicationVC()
        vc.Medicationmodel = medModel
        vc.model = userModel
        vc.Delegete = self
        show(vc, sender: true)
    }
}
protocol addmedicationList {
    func Data(isAdded: Bool)
}
