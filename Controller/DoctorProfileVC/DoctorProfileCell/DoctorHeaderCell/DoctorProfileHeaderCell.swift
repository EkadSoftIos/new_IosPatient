//
//  DoctorProfileHeaderCell.swift
//  E4 Patient
//
//  Created by Nada on 9/15/21.
//

import UIKit

class DoctorProfileHeaderCell: UITableViewCell {
    
    var doctorId: Int?
    var slf: UIViewController?
    
    var doctorCanDo: [Int] = [] {
        didSet {
            for service in doctorCanDo {
                print(service)
                switch service {
                case 1:
                    sImg1.image = #imageLiteral(resourceName: "f1")
                case 2:
                    sImg2.image = #imageLiteral(resourceName: "ic_call")
                case 3:
                    sImg3.image = #imageLiteral(resourceName: "ic_home_visit")
                case 4:
                    sImg4.image = #imageLiteral(resourceName: "f4")
                case 5:
                    sImg5.image = #imageLiteral(resourceName: "ic_help_call")
                default:
                    return
                }
            }
        }
    }

    @IBOutlet weak var sImg5: UIImageView!
    @IBOutlet weak var sImg4: UIImageView!
    @IBOutlet weak var sImg3: UIImageView!
    @IBOutlet weak var sImg2: UIImageView!
    @IBOutlet weak var sImg1: UIImageView!
    @IBOutlet weak var totalAppointement: UILabel!
    @IBOutlet weak var patientNumber: UILabel!
    @IBOutlet weak var viewersNumber: UILabel!
    @IBOutlet weak var rateLbl: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var doctorDesc: UILabel!
    @IBOutlet weak var doctorName: UILabel!
    @IBOutlet weak var doctorImg: UIImageView!
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.ShadowView(view: bgView, radius: 10, opacity: 0.4, shadowRadius: 2, color: UIColor.lightGray.cgColor)
    }
    @IBAction func likeBtnPressed(_ sender: Any) {
    }
    @IBAction func allreviewsBtnPressed(_ sender: Any) {
        let vc = ReviewsVC()
        vc.doctorId = doctorId ?? 0
        slf?.show(vc, sender: nil)
    }
    @IBAction func videoCallBtnPressed(_ sender: Any) {
    }
    
}
