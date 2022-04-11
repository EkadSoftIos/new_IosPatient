//
//  BranchInfoVCViewController.swift
//  E4 Patient
//
//  Created by mohab on 09/05/2021.
//

import UIKit

class BranchInfoVCViewController: UIViewController {
    
    var branchList: ServiceList?
    
    @IBOutlet weak var branchRate: UILabel!
    @IBOutlet weak var branchLocation: UILabel!
    @IBOutlet weak var branchName: UILabel!
    @IBOutlet weak var branchImg: UIImageView!
    @IBOutlet var locationView: UIView!
    @IBOutlet var serviseView: UIView!
    @IBOutlet var photoView: UIView!
    @IBOutlet var photoCollection: UICollectionView!
    @IBOutlet var doctorMedTable: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Branch Info".localized
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColor.Blue]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setBranchData()
        setupTableView()
        setupCollectionView()
        locationView.ShadowView(view: locationView, radius: 10, opacity: 2, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        serviseView.ShadowView(view: serviseView, radius: 10, opacity: 2, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        photoView.ShadowView(view: photoView, radius: 10, opacity: 2, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        branchImg.layer.cornerRadius = branchImg.frame.width / 2
    }
    func setBranchData() {
        let branchname = "\(branchList?.entityName_Localized ?? "")" + "(" + "\(branchList?.branchName_Localized ?? "")" + ")"
        branchName.text = branchname
        let imgURL = URL(string: "\(Constants.baseURLImage)\(branchList?.imagepath ?? "")")
        branchImg?.kf.indicatorType = .activity
//        branchImg?.kf.setImage(with: imgURL, options: [.transition(.fade(0.8))])
        branchImg.kf.setImage(with: imgURL)
        branchLocation.text = branchList?.branchAddress_Localized ?? ""
    }
    func setupTableView(){
        doctorMedTable.register(DoctorServiseCell.nib, forCellReuseIdentifier: "DoctorServiseCell")
        doctorMedTable.delegate = self
        doctorMedTable.dataSource = self
        doctorMedTable.separatorStyle = .none
    }
    func setupCollectionView(){
        photoCollection.register(PhotoCell.nib, forCellWithReuseIdentifier: "PhotoCell")
        photoCollection.delegate = self
        photoCollection.dataSource = self
    }

}
