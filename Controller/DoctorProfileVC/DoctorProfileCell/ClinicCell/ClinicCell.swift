//
//  ClinicCell.swift
//  E4 Patient
//
//  Created by Nada on 9/15/21.
//

import UIKit

class ClinicCell: UITableViewCell {

    @IBOutlet weak var detailsImg: UIImageView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var bookingBtn: UIButton!
    @IBOutlet weak var feesLbl: UILabel!
    @IBOutlet weak var availableTimeLbl: UILabel!
    @IBOutlet weak var branchName: UILabel!
    @IBOutlet weak var branchImg: UIImageView!
    @IBOutlet weak var moreBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.ShadowView(view: bgView, radius: 10, opacity: 0.4, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        branchImg.layer.cornerRadius = branchImg.frame.width / 2
        branchImg.clipsToBounds = true
    }
    
}
