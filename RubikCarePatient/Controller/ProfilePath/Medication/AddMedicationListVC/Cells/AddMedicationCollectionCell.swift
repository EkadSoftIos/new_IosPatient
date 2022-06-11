//
//  AddMedicationCollectionCell.swift
//  E4 Patient
//
//  Created by mohab on 20/01/2021.
//

import UIKit

class AddMedicationCollectionCell: UICollectionViewCell {
    @IBOutlet var cellView: UIView!
    @IBOutlet var medicineImage: UIImageView!
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var doseLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.ShadowView(view: cellView, radius: 10, opacity: 0.4, shadowRadius: 4, color: UIColor.lightGray.cgColor)
        
    }
    static var nib : UINib {
        return UINib(nibName: identifire, bundle: nil)
    }
    
    static var identifire : String {
        return String(describing: self)
    }
}
