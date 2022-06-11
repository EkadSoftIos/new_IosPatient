//
//  TopDoctorCell.swift
//  E4 Patient
//
//  Created by mohab on 25/04/2021.
//

import UIKit

class TopDoctorCell: UICollectionViewCell {
    @IBOutlet var mainView: UIView!
    @IBOutlet var doctorImage: UIImageView!
    @IBOutlet var doctorNameLbl: UILabel!
    @IBOutlet var specializationLbl: UILabel!
    @IBOutlet var rateLbl: UILabel!
    @IBOutlet var viewCountLbl: UILabel!
    @IBOutlet var friendLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.ShadowView(view: mainView, radius: 10, opacity: 0.3, shadowRadius: 3, color: UIColor.darkGray.cgColor)
       
    }
    static var nib : UINib {
        return UINib(nibName: identifire, bundle: nil)
    }
    
    static var identifire : String {
        return String(describing: self)
    }
}
