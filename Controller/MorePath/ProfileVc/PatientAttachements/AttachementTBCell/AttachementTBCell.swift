//
//  AttachementTBCell.swift
//  E4 Patient
//
//  Created by Nada on 10/5/21.
//

import UIKit

class AttachementTBCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var attachImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        bgView.ShadowView(view: bgView, radius: 10, opacity: 0.4, shadowRadius: 6, color: UIColor.darkGray.cgColor)
    }
    
}
