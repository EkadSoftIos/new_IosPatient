//
//  More+TableView.swift
//  E4 Patient
//
//  Created by mohab on 17/01/2021.
//

import UIKit
extension MoreVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moreArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 12 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HelpSupportCell") as! HelpSupportCell
            cell.slf = self
          cell.webPagesData = webPagesData
            return cell
        } else {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moreCell") as! MoreCell
        cell.cellTitle.text = moreArr[indexPath.row].0
        cell.cellImage.image = moreArr[indexPath.row].1
        cell.selectionStyle = .none
        return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = ProfileVC()
            vc.userData = self.userData
            vc.hidesBottomBarWhenPushed = true
            show(vc, sender: nil)
//        case 1:
            //My wallet
        case 2:
            let vc = MyFavoriteVC()
            vc.hidesBottomBarWhenPushed = true
            self.show(vc, sender: nil)
//        case 3:
            //Medicine Reminder
//        case 4:
            //Blog
        case 5:
            let vc = AppointmentVC()
            vc.isHistory = true
            vc.hidesBottomBarWhenPushed = true
            self.show(vc, sender: nil)
        case 6:
            let vc = ConsultationsLogVC()
            self.show(vc, sender: nil)
//        case 7:
            //Reports
//        case 8:
            //My Orders
        case 9:
            let vc = PermissionVC()
            vc.hidesBottomBarWhenPushed = true
            vc.Model = self.userData
//            vc.Delegete = self
            show(vc, sender: nil)
        case 10:
            let vc = EmergencyNumberVC()
            vc.hidesBottomBarWhenPushed = true
            show(vc, sender: nil)
        case 11:
            let vc = ForgetPasswordVC()
            vc.hidesBottomBarWhenPushed = true
            vc.Model = self.userData
            show(vc, sender: nil)
//        case 12:
//            let sb = UIStoryboard(name: "Main", bundle: nil)
//            let vc = sb.instantiateViewController(withIdentifier: "HelpAndSupportVC")
//            navigationController?.pushViewController(vc, animated: true)
//        case 13:
//            let sb = UIStoryboard(name: "Main", bundle: nil)
//            let vc = sb.instantiateViewController(withIdentifier: "PrivacyPolicyVC")
//            navigationController?.pushViewController(vc, animated: true)
//        case 14:
//            let sb = UIStoryboard(name: "Main", bundle: nil)
//            let vc = sb.instantiateViewController(withIdentifier: "ContactUsVC")
//            navigationController?.pushViewController(vc, animated: true)
//        case 15:
//            let sb = UIStoryboard(name: "Main", bundle: nil)
//            let vc = sb.instantiateViewController(withIdentifier: "FAQVC")
//            navigationController?.pushViewController(vc, animated: true)
        
//        case 16:
            //Language
        case 14:
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "LogOutVC")
            self.present(vc, animated: true, completion: nil)
//            navigationController?.pushViewController(vc, animated: true)

        default:
            print("")
            //self.showMessage(sub: "not available Now".localized)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 12 {
            return 210
        } else {
        return 50
        }
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

