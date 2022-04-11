//
//  TopOffersCell.swift
//  E4 Patient
//
//  Created by mohab on 25/04/2021.
//

import UIKit

class TopOffersCell: UICollectionViewCell {
    @IBOutlet var offersImage: UIImageView!
    @IBOutlet var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.ShadowView(view: mainView, radius: 7, opacity: 0.3, shadowRadius: 3, color: UIColor.lightGray.cgColor)
    }
    static var nib : UINib {
        return UINib(nibName: identifire, bundle: nil)
    }
    
    static var identifire : String {
        return String(describing: self)
    }
    
}
