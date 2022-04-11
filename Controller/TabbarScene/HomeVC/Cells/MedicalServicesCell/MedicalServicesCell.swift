//
//  MedicalServicesCell.swift
//  E4 Patient
//
//  Created by mohab on 25/04/2021.
//

import UIKit

class MedicalServicesCell: UICollectionViewCell {
    @IBOutlet var mainView: UIView!
    @IBOutlet var serviseImage: UIImageView!
    @IBOutlet var serviseNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        serviseNameLbl.tintColor = .white
    }
    static var nib : UINib {
        return UINib(nibName: identifire, bundle: nil)
    }
    
    static var identifire : String {
        return String(describing: self)
    }

}
