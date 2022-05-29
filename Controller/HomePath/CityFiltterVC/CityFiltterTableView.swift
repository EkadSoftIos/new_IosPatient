//
//  CityFiltterTableView.swift
//  E4 Patient
//
//  Created by mohab on 03/05/2021.
//

import Foundation
import UIKit
extension CityFilterVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if type == "city" {
            return cityData?.count ?? 0 + 1
        } else {
            return areaData?.count ?? 0 + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moreCell") as! MoreCell
        if indexPath.row == 0 {
            cell.cellTitle.text = "Your Location".localized
        }else {
            if type == "city" {
                cell.cellTitle.text = cityData?[indexPath.row-1].cityNameEn ?? ""
            } else {
                cell.cellTitle.text = areaData?[indexPath.row-1].areaNameEn ?? ""
            }
        }
        
        
        cell.cellImage.isHidden = true
        cell.selectionStyle = .none
        cell.imageWidth.constant = 0
        cell.nextImage.isHidden = true
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.locationDelegate?.filterWithLocation(lat: lat, lng: lng, areaId: nil, cityId: nil)
            navigationController?.popViewController(animated: true)
        }else {
            if type == "city" {
                type = "area"
                cityId = cityData?[indexPath.row-1].cityID ?? 0
                areaData = cityData?[indexPath.row-1].lookupArea
                self.navigationItem.title = cityData?[indexPath.row-1].cityNameEn
                cityTableVIew.reloadData()
            } else {
                areaId = areaData?[indexPath.row-1].areaID ?? 0
                self.locationDelegate?.filterWithLocation(lat: nil, lng: nil, areaId: areaId, cityId: cityId)
                navigationController?.popViewController(animated: true)
            }
        }
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, -10, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0.0
        UIView.animate(withDuration: 0.75){
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1
        }
    }
    
    
}
