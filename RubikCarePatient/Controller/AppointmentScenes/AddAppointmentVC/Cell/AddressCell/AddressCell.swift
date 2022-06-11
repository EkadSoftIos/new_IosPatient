//
//  AddressCell.swift
//  E4 Patient
//
//  Created by Nada on 8/29/21.
//

import UIKit

class AddressCell: UICollectionViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var changeBtn: UIButton!
    @IBOutlet weak var addressLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        bgView.setupShadowView(cornerRadius: 13, shadowRadius: 4, shadowColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.16), shadowOpacity: 0.4, shadowOffset: .init(width: 3, height: 4), borderwidth: 0.2, borderColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.16))
        changeBtn.layer.cornerRadius = 11
    }

}
