//
//  AllReportsCell.swift
//  E4 Patient
//
//  Created by Ahmed Kassem on 24/05/2022.
//

import UIKit

class AllReportsCell: UITableViewCell {

    @IBOutlet weak var reportStatus: UILabel!
    @IBOutlet weak var paymentType: UILabel!
    @IBOutlet weak var paidLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var serviceType: UILabel!
    @IBOutlet weak var patientName: UILabel!
    @IBOutlet weak var patientImg: UIImageView!
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.ShadowView(view: bgView, radius: 10, opacity: 0.4, shadowRadius: 2, color: UIColor.lightGray.cgColor)
    }
    
}
