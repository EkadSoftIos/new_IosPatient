//
//  ConsultationLogTBCell.swift
//  E4 Patient
//
//  Created by Nada on 8/30/21.
//

import UIKit

class ConsultationLogTBCell: UITableViewCell {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var detailsName: UILabel!
    @IBOutlet weak var doctorName: UILabel!
    @IBOutlet weak var doctorImage: UIImageView!
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        bgView.setupShadowView(cornerRadius: 13, shadowRadius: 4, shadowColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.16), shadowOpacity: 0.4, shadowOffset: .init(width: 3, height: 4), borderwidth: 0.2, borderColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.16))
        doctorImage.layer.cornerRadius = doctorImage.frame.width / 2
    }
    
}
