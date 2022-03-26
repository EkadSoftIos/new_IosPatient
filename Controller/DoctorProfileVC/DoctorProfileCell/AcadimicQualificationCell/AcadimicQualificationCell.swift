//
//  AcadimicQualificationCell.swift
//  E4 Patient
//
//  Created by Nada on 9/15/21.
//

import UIKit

class AcadimicQualificationCell: UITableViewCell {

    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var acadimicQualification: UILabel!
    @IBOutlet weak var graduationName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
         bgView.ShadowView(view: bgView, radius: 10, opacity: 0.4, shadowRadius: 2, color: UIColor.lightGray.cgColor)
    }
    
}
