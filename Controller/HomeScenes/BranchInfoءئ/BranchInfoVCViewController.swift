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
    @IBOutlet weak var firstServiceLBL: UILabel!
    @IBOutlet weak var viewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var moreBTN: UIButton!
    @IBOutlet var morePhotoBTN: UIButton!
    @IBOutlet weak var branchInfoLBL: UIView!
    
    @IBOutlet weak var doctorMedicalLBL: UILabel!
    @IBOutlet weak var clinicPhotoLBL: UILabel!
    
    
    override func viewWillAppear(_ animated: Bool) {
        setLocalization()
        self.navigationItem.title = "Branch Info".localized
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColor.Blue]
        
        if  branchList?.medicalServiceList?.count ?? 0 > 1{
            moreBTN.isHidden = false
            viewHeightConstraint.constant = 120
            firstServiceLBL.text = branchList?.medicalServiceList?[0].medicalServiceNameLocalized ?? ""
        }else {
            moreBTN.isHidden = true
            viewHeightConstraint.constant = 40
        }

        if branchList?.branchImageList?.count ?? 0 > 6 {
            morePhotoBTN.isHidden = false
        }else{
            morePhotoBTN.isHidden = true
        }
    }
    func setLocalization(){
        doctorMedicalLBL.text = "DoctorMedicalService".localized
        clinicPhotoLBL.text = "Clinic Photo".localized
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setBranchData()
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
    
    func setupCollectionView(){
        photoCollection.register(PhotoCell.nib, forCellWithReuseIdentifier: "PhotoCell")
        photoCollection.delegate = self
        photoCollection.dataSource = self
    }
    @IBAction func moreAction(_ sender: Any) {
        let vc = HomeInfoTableVC()
        vc.homeList = branchList
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func morePhotoAction(_ sender: Any) {
        let vc = BranchImagesCollectionVC()
        vc.branchList = branchList
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
