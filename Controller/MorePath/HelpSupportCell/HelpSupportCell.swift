
//
//  HelpSupportCell.swift
//  E4Doctor
//
//  Created by Nada on 3/4/22.
//

import UIKit

class HelpSupportCell: UITableViewCell {
    @IBOutlet var cellView: UIView!

    var slf: UIViewController!
//    var webPagesData: [WebPagesData]? {
//        didSet {
//            if webPagesData?.count ?? 0 > 0 {
//                for data in webPagesData! {
//                    if data.id == 2 {
//                        privacyData = data.content ?? ""
//                    } else if data.id == 3 {
//                        supportData = data.content ?? ""
//                    } else if data.id == 5 {
//                        faqData = data.content ?? ""
//                    }
//                }
//            }
//        }
//    }
//    var privacyData = ""
//    var supportData = ""
//    var faqData = ""

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellView.ShadowView(view: cellView, radius: 10, opacity: 0.4, shadowRadius: 4, color: UIColor.darkGray.cgColor)

    }
    
    @IBAction func didTappedContactUs(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ContactUsVC")
        slf.navigationController?.pushViewController(vc, animated: true)

    }
    
    @IBAction func didTappedFAQ(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "FAQVC")
        slf.navigationController?.pushViewController(vc, animated: true)

    }
    
    @IBAction func didTappedConditions(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "HelpAndSupportVC")
        slf.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTappedPrivacyPolicy(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "PrivacyPolicyVC")
        slf.navigationController?.pushViewController(vc, animated: true)
    }
    static var nib : UINib {
        return UINib(nibName: identifire, bundle: nil)
    }
    static var identifire : String {
        return String(describing: self)
    }
}
