//
//  SpecializationsCell.swift
//  E4 Patient
//
//  Created by mohab on 25/04/2021.
//

import UIKit

class SpecializationsCell: UICollectionViewCell {
    @IBOutlet var mainView: UIView!
    @IBOutlet var SpecializationImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mainView.ShadowView(view: mainView, radius: 7, opacity: 0.4, shadowRadius: 1, color: UIColor.darkGray.cgColor)
    }

    static var nib : UINib {
        return UINib(nibName: identifire, bundle: nil)
    }
    
    static var identifire : String {
        return String(describing: self)
    }

    
    
}
