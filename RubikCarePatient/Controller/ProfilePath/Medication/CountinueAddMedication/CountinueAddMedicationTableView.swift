//
//  CountinueAddMedicationTableView.swift
//  E4 Patient
//
//  Created by mohab on 21/03/2021.
//

import Foundation
import UIKit
extension CountinueAddMedicationVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "doctorsCell") as! DoctorsSearchCell
        cell.selectionStyle = .none
        cell.nameLbl.text = searchArr[indexPath.row].employeeName
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBar.text = searchArr[indexPath.row].employeeName
        doctorId = searchArr[indexPath.row].businessProviderEmployeeID ?? 0
        setDoctorsView()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 25
    }
}
