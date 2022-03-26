//
//  AcademicQualificationCell.swift
//  E4 Patient
//
//  Created by mohab on 09/05/2021.
//

import UIKit

class AcademicQualificationCell: UITableViewCell {
    @IBOutlet var cellView: UIView!
    
    @IBOutlet weak var acadimicName: UILabel!
    @IBOutlet weak var acadimicQualification: UILabel!
    @IBOutlet weak var acadimicFrom: UILabel!
    @IBOutlet weak var acadimicDate: UILabel!
    @IBOutlet weak var academicImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellView.ShadowView(view: cellView, radius: 10, opacity: 0.3, shadowRadius: 3, color: UIColor.darkGray.cgColor)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    static var nib : UINib {
        return UINib(nibName: identifire, bundle: nil)
    }
    
    static var identifire : String {
        return String(describing: self)
    }
    
}
