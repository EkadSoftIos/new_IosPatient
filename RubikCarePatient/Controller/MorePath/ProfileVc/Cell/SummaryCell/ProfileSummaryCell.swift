//
//  ProfileSummaryCell.swift
//  E4 Patient
//
//  Created by Nada on 10/5/21.
//

import UIKit

class ProfileSummaryCell: UITableViewCell {

    @IBOutlet weak var attachmentBtn: UIButton!
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var doctorNameLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        bgView.ShadowView(view: bgView, radius: 10, opacity: 0.4, shadowRadius: 6, color: UIColor.darkGray.cgColor)
        attachmentBtn.layer.cornerRadius = 9
        attachmentBtn.layer.borderColor = #colorLiteral(red: 0.07058823529, green: 0.4666666667, blue: 0.8196078431, alpha: 1)
        attachmentBtn.layer.borderWidth = 1
    }
    
}
