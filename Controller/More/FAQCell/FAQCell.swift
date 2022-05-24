//
//  FAQCell.swift
//  E4 Patient
//
//  Created by Ahmed Kassem on 21/05/2022.
//

import UIKit

class FAQCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var answerLbl: UILabel!
    @IBOutlet weak var questionLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.ShadowView(view: bgView, radius: 10, opacity: 2, shadowRadius: 2, color: UIColor.lightGray.cgColor)

    }
}
