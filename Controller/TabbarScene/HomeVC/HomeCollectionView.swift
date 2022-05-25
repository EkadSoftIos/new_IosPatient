//
//  HomeCollectionView.swift
//  E4 Patient
//
//  Created by mohab on 25/04/2021.
//

import Foundation
import UIKit
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case SpecializationsCollection:
            return homeResponse?.message?.speciality?.count ?? 0
        case doctorServiseCollection:
            return 5
        case medicalServiseCollection:
            return 4
        case topDoctorCollection:
            return homeResponse?.message?.doctorDataForAPI?.count ?? 0
        case topOffersCollection:
            return 3
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case SpecializationsCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpecializationsCell", for: indexPath) as! SpecializationsCell
            let imgURL = URL(string: "\(Constants.baseURLImage)\(homeResponse?.message?.speciality?[indexPath.row].specialityImagePath ?? "")")
//            cell.SpecializationImage.loadImage(imgURL)
            cell.SpecializationImage?.kf.indicatorType = .activity
            cell.SpecializationImage?.kf.setImage(with: imgURL)
            return cell
        case doctorServiseCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DoctorServicesCell", for: indexPath) as! DoctorServicesCell
            cell.serviseImage.image = doctorServiseArr[indexPath.row]
            return cell
        case medicalServiseCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MedicalServicesCell", for: indexPath) as! MedicalServicesCell
            switch indexPath.row {
            case 0:
                cell.mainView.backgroundColor = AppColor.Blue
            case 1:
                cell.mainView.backgroundColor = AppColor.home2
            case 2:
                cell.mainView.backgroundColor = AppColor.home3
            default:
                cell.mainView.backgroundColor = AppColor.home4
            }
            cell.serviseImage.image = meedicalServiseArr[indexPath.row].0
            cell.serviseNameLbl.text = meedicalServiseArr[indexPath.row].1
            return cell
        case topDoctorCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopDoctorCell", for: indexPath) as! TopDoctorCell
            let model = homeResponse?.message?.doctorDataForAPI?[indexPath.row]
            let imgURL = URL(string: "\(Constants.baseURLImage)\(model?.profileImage ?? "")")
            cell.doctorImage?.kf.indicatorType = .activity
            cell.doctorImage?.kf.setImage(with: imgURL)
            Animation.roundView(cell.doctorImage)
            cell.doctorNameLbl.text = "\(model?.prefixTitleLocalized ?? "")\(" ")\(model?.doctorName ?? "")"
            cell.specializationLbl.text = model?.specialityLocalized
            cell.viewCountLbl.text = String(model?.totalViews ?? 0)
            cell.rateLbl.text = String(model?.totalRate ?? 0)
            cell.friendLbl.text = String(model?.totalpatients ?? 0)
            return cell
        case topOffersCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopOffersCell", for: indexPath) as! TopOffersCell
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopOffersCell", for: indexPath) as! TopOffersCell
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case SpecializationsCollection:
            return CGSize(width: 60 , height: 40)
        case doctorServiseCollection:
            return CGSize(width: 160 , height: 90)
        case medicalServiseCollection:
            return CGSize(width: 87 , height: 78)
        case topDoctorCollection:
            return CGSize(width: 220 , height: 100)
        case topOffersCollection:
            return CGSize(width: 170 , height: 75)
        default:
            return CGSize(width: 170 , height: 7)
            
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == topDoctorCollection {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "DoctorProfileViewController") as! DoctorProfileViewController
            vc.doctorId = homeResponse?.message?.doctorDataForAPI?[indexPath.row].businessProviderEmployeeID
            navigationController?.pushViewController(vc, animated: true)
        }else if collectionView == SpecializationsCollection{
            let vc = AllSearchVC()
            vc.mainSpecialityID = homeResponse?.message?.speciality?[indexPath.row].specialityID
            self.show(vc, sender: nil)
            
        } else if collectionView == doctorServiseCollection {
            let vc = SearchOeVc()
            vc.model = homeResponse
            vc.consultationServiceId = indexPath.item + 1
            self.show(vc, sender: nil)
        }else if collectionView == medicalServiseCollection{
            let vc = MedicalServicesVC()
            if indexPath.row == 2 { vc.type = .labs }
            else if indexPath.row == 3 { vc.type = .radiologyCenter }
            else{ return }
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}
