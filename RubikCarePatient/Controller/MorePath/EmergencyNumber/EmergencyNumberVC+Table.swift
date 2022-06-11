//
//  EmergencyNumberVC+Table.swift
//  E4 Patient
//
//  Created by mohab on 24/01/2021.
//

import UIKit
extension EmergencyNumberVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.message.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmergencyNumberCellTableViewCell") as! EmergencyNumberCellTableViewCell
        cell.selectionStyle = .none
        let emergency = model?.message[indexPath.row]
        cell.nameLbl.text = emergency?.emergencyNameEn
        cell.phoneLbl.text = emergency?.emergencyPhone
     //   cell.emergencyImage.kf.setImage(with: URL(string: (emergency.)!),placeholder: UIImage(named: "user"))
        cell.callHandelr = {
            self.dialNumber(number: emergency?.emergencyPhone ?? "0")
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
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
    func dialNumber(number : String) {

     if let url = URL(string: "tel://\(number)"),
       UIApplication.shared.canOpenURL(url) {
          if #available(iOS 10, *) {
            UIApplication.shared.open(url, options: [:], completionHandler:nil)
           } else {
               UIApplication.shared.openURL(url)
           }
       } else {
                // add error message here
       }
    }
}
   
