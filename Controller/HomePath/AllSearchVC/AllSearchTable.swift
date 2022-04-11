//
//  AllSearchTable.swift
//  E4 Patient
//
//  Created by mohab on 30/04/2021.
//

import Foundation
import UIKit
extension AllSearchVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if type == "All" {
            return allSearchViewModel.filteredDoctors.count
        } else {
            return allSearchViewModel.filteredDoctorsearch.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllSearchCell") as! AllSearchCell
        cell.selectionStyle = .none
        
        let doctorModel: DoctorSearchData?
        if type == "All" {
            doctorModel =  allSearchViewModel.filterDoctors[indexPath.row]
        } else {
            doctorModel = allSearchViewModel.filteredDoctorsearch[indexPath.row]
        }
        let imgURL = URL(string: "\(Constants.baseURLImage)\(doctorModel?.profileImage ?? "")")
        cell.doctorImage?.kf.indicatorType = .activity
        cell.doctorImage?.kf.setImage(with: imgURL)
        Animation.roundView(cell.doctorImage)
        cell.nameLbl.text = doctorModel?.doctorName
        cell.detailsOneLbl.text = doctorModel?.specialityLocalized
        cell.detailsTwoLbl.text = doctorModel?.fullProfisionalDetailsLocalized
        cell.detailsThreeLbl.text = doctorModel?.mainAddress?.branchNameLocalized ?? ""
        cell.rateLbl.text = String(doctorModel?.totalRate ?? 0)
        cell.doctorCanDo = doctorModel?.doctorCanDo ?? []
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "DoctorProfileViewController") as! DoctorProfileViewController
        if type == "All" {
            vc.doctorId = allSearchViewModel.filterDoctors[indexPath.row].businessProviderEmployeeID ?? 0
        }else{
            vc.doctorId = allSearchViewModel.filteredDoctorsearch[indexPath.row].businessProviderEmployeeID ?? 0
        }
//        vc.doctorId = allSearchViewModel.filteredDoctors[indexPath.row].businessProviderEmployeeID ?? 0
//        vc.doctorId = allSearchViewModel.filterDoctors[indexPath.row].businessProviderEmployeeID ?? 0
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
