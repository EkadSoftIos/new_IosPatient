//
//  BranchInfoTable+Collection.swift
//  E4 Patient
//
//  Created by mohab on 09/05/2021.
//

import Foundation
import UIKit
extension BranchInfoVCViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return branchList?.medicalServiceList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorServiseCell") as! DoctorServiseCell
        cell.selectionStyle = .none
        
        cell.medicalName.text = branchList?.medicalServiceList?[indexPath.row].medicalServiceNameLocalized ?? ""
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}
extension BranchInfoVCViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
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
