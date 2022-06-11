//
//  ShiftCell.swift
//  E4 Patient
//
//  Created by mohab on 10/05/2021.
//

import UIKit

class ShiftCell: UICollectionViewCell {

    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var shiftLbl: UILabel!
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
