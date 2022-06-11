//
//  MedicineReminderTBCell.swift
//  E4 Patient
//
//  Created by Ahmed Kassem on 23/05/2022.
//

import UIKit

class MedicineReminderTBCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.ShadowView(view: bgView, radius: 10, opacity: 0.4, shadowRadius: 2, color: UIColor.lightGray.cgColor)
    }
    
    
}
