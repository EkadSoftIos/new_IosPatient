//
//  SearchTableViewe.swift
//  E4 Patient
//
//  Created by mohab on 30/04/2021.
//

import Foundation
import UIKit
extension SearchOeVc: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchOneCell") as! SearchOneCell
        cell.selectionStyle = .none
        let imgURL = URL(string: "\(Constants.baseURLImage)\(currentArray?[indexPath.row].specialityImagePath ?? "")")
        cell.speImage?.kf.indicatorType = .activity
        cell.speImage?.kf.setImage(with: imgURL)
        cell.nameLbl.text = currentArray?[indexPath.row].nameLocalized
        cell.douctorsNumberLbl.text = String(currentArray?[indexPath.row].numberOfDoctors ?? 0) + " Doctor".localized
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AllSearchVC()
        vc.mainSpecialityID = currentArray?[indexPath.row].specialityID
        vc.consultationServiceId = consultationServiceId ?? 1
//        vc.mainSpecialityID = 6
        self.show(vc, sender: nil)

    }
    
}
