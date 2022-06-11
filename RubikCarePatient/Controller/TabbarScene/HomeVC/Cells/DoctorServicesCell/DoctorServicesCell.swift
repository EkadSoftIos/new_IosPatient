//
//  DoctorServicesCell.swift
//  E4 Patient
//
//  Created by mohab on 25/04/2021.
//

import UIKit

class DoctorServicesCell: UICollectionViewCell {
    @IBOutlet var serviseImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    static var nib : UINib {
        return UINib(nibName: identifire, bundle: nil)
    }
    
    static var identifire : String {
        return String(describing: self)
    }
    
    
    
}
