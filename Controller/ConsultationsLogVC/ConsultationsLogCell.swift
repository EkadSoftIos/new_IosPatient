//
//  ConsultationsLogCell.swift
//  E4 Patient
//
//  Created by mohab on 09/05/2021.
//

import UIKit

class ConsultationsLogCell: UITableViewCell {
    @IBOutlet var cellView: UIView!
    
    @IBOutlet weak var clinicName: UILabel!
    @IBOutlet weak var doctorName: UILabel!
    @IBOutlet weak var doctorImg: UIImageView!
    @IBOutlet weak var dateLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellView.ShadowView(view: cellView, radius: 10, opacity: 2, shadowRadius: 2, color: UIColor.lightGray.cgColor)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        doctorImg.layer.cornerRadius = doctorImg.frame.width / 2
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
