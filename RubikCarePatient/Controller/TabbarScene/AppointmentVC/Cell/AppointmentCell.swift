//
//  AppointmentCell.swift
//  E4 Patient
//
//  Created by mohab on 09/05/2021.
//

import UIKit

class AppointmentCell: UITableViewCell {
    @IBOutlet var cellView: UIView!
    @IBOutlet weak var doctorIMG: UIImageView!
    @IBOutlet weak var doctorTitleNameLBL: UILabel!
    @IBOutlet weak var doctorSpecLBL: UILabel!
    @IBOutlet weak var clinicNameLBL: UILabel!
    @IBOutlet weak var timeLBL: UILabel!
    @IBOutlet weak var unPaidLBL: UILabel!
    @IBOutlet weak var statusNameLBL: UILabel!
    @IBOutlet weak var cancelBTN: UIButton!
    @IBOutlet weak var clinicIMG: UIImageView!
    @IBOutlet weak var startVideoBTN: UIButton!
    @IBOutlet weak var overBookingLBL: UILabel!
    @IBOutlet weak var onlineStatusView: UIView!
    @IBOutlet weak var startVideoConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellView.ShadowView(view: cellView, radius: 10, opacity: 2, shadowRadius: 2, color: UIColor.lightGray.cgColor)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    static var nib : UINib {
        return UINib(nibName: identifire, bundle: nil)
    }
    
    static var identifire : String {
        return String(describing: self)
    }

    
}
