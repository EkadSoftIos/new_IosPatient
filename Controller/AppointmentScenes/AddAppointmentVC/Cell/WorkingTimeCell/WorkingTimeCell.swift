//
//  WorkingTimeCell.swift
//  E4 Patient
//
//  Created by Nada on 8/29/21.
//

import UIKit

class WorkingTimeCell: UICollectionViewCell {

    @IBOutlet weak var reservationCountLbl: UILabel!
    @IBOutlet weak var todate: UILabel!
    @IBOutlet weak var fromDate: UILabel!
    @IBOutlet weak var reservationLeftView: UIView!
    @IBOutlet weak var reserationRequiredView: UIView!
    @IBOutlet weak var workingTimeView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        reserationRequiredView.setupShadowView(cornerRadius: 13, shadowRadius: 4, shadowColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.16), shadowOpacity: 0.4, shadowOffset: .init(width: 3, height: 4), borderwidth: 0.2, borderColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.16))
        workingTimeView.setupShadowView(cornerRadius: 13, shadowRadius: 4, shadowColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.16), shadowOpacity: 0.4, shadowOffset: .init(width: 3, height: 4), borderwidth: 0.2, borderColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.16))
        reservationLeftView.setupShadowView(cornerRadius: 13, shadowRadius: 4, shadowColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.16), shadowOpacity: 0.4, shadowOffset: .init(width: 3, height: 4), borderwidth: 0.2, borderColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.16))
    }

}
