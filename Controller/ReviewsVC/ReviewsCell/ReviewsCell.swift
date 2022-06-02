//
//  ReviewsCell.swift
//  E4 Patient
//
//  Created by mohab on 09/05/2021.
//

import UIKit

class ReviewsCell: UITableViewCell {
    
    @IBOutlet var cellView: UIView!
    @IBOutlet weak var patientFeedback: UILabel!
    @IBOutlet weak var rateDate: UILabel!
    @IBOutlet weak var patientRate: UILabel!
    @IBOutlet weak var patientName: UILabel!
    @IBOutlet weak var patientImg: UIImageView!
    @IBOutlet weak var viewReplyBTN: UIButton!
    @IBOutlet weak var doctorIMG: UIImageView!
    @IBOutlet weak var doctorNameLBL: UILabel!
    @IBOutlet weak var doctorReplyDateLBL: UILabel!
    @IBOutlet weak var doctorReplyLBL: UILabel!
    @IBOutlet weak var subViewHeightConstrait: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        contentView.ShadowView(view: cellView, radius: 10, opacity: 2, shadowRadius: 0.3, color: UIColor.darkGray.cgColor)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    static var nib : UINib {
        return UINib(nibName: identifire, bundle: nil)
    }
    
    static var identifire : String {
        return String(describing: self)
    }
    
    
}
