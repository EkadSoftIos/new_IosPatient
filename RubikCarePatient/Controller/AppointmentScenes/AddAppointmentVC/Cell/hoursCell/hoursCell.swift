//
//  hoursCell.swift
//  E4 Patient
//
//  Created by mohab on 10/05/2021.
//

import UIKit

class hoursCell: UICollectionViewCell {
    @IBOutlet var cellView: UIView!
    @IBOutlet weak var hoursLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        cellView.ShadowView(view: cellView, radius: 10, opacity: 2, shadowRadius: 2, color: UIColor.lightGray.cgColor)
    }
    
    static var nib : UINib {
        return UINib(nibName: identifire, bundle: nil)
    }
    
    static var identifire : String {
        return String(describing: self)
    }
}
