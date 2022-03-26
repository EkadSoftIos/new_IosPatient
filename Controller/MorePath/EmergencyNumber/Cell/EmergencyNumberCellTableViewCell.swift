//
//  EmergencyNumberCellTableViewCell.swift
//  E4 Patient
//
//  Created by mohab on 24/01/2021.
//

import UIKit

class EmergencyNumberCellTableViewCell: UITableViewCell {
    @IBOutlet var phoneLbl: UILabel!
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var cellView: UIView!
    @IBOutlet var callBtn: UIButton!
    @IBOutlet var emergencyImage: UIImageView!
    var callHandelr: ActionClouser?
    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.ShadowView(view: cellView, radius: 10, opacity: 0.2, shadowRadius: 4, color: UIColor.darkGray.cgColor)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func call_Click(_ sender: Any) {
        callHandelr?()
    }
    static var nib : UINib {
        return UINib(nibName: identifire, bundle: nil)
    }
    
    static var identifire : String {
        return String(describing: self)
    }
}
