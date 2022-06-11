//
//  FollowUpCell.swift
//  E4 Patient
//
//  Created by Nada on 9/29/21.
//

import UIKit

class FollowUpCell: UITableViewCell {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var trachBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var diabetesLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var hyperLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var noteLbl: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var byLBL: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        bgView.layer.cornerRadius = 13
        bgView.ShadowView(view: bgView, radius: 10, opacity: 0.3, shadowRadius: 6, color: UIColor.darkGray.cgColor)
    }
    
}
