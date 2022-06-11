//
//  HomeInfoVC.swift
//  E4 Patient
//
//  Created by mohab on 09/05/2021.
//

import UIKit

class BranchImagesCollectionVC: UIViewController {
    
    var branchList: ServiceList?
    
    @IBOutlet var photoCollection: UICollectionView!
    
    @IBOutlet weak var doctorMedicalServiceLBL: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        setLocalization()
//        self.navigationItem.title = "Home Info".localized
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColor.Blue]
    }
    func setLocalization(){
        doctorMedicalServiceLBL.text = "Clinic Photo".localized
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
    }

    func setupCollection(){
        photoCollection.register(PhotoCell.nib, forCellWithReuseIdentifier: "PhotoCell")
        photoCollection.delegate = self
        photoCollection.dataSource = self
    }
 

}
extension BranchImagesCollectionVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return branchList?.branchImageList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
        let imgURL = URL(string: "\(Constants.baseURLImage)\(branchList?.branchImageList?[indexPath.row].imagePath ?? "")")
        cell.clinicImage?.kf.indicatorType = .activity
        cell.clinicImage?.kf.setImage(with: imgURL)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3 - 8,height:  70 )
        
    }

}
