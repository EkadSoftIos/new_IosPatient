//
//  MoreCell.swift
//  E4 Patient
//
//  Created by mohab on 17/01/2021.
//

import UIKit

class MoreCell: UITableViewCell {
    @IBOutlet var cellView: UIView!
    @IBOutlet var cellImage: UIImageView!
    @IBOutlet var cellTitle: UILabel!
    @IBOutlet var imageWidth: NSLayoutConstraint!
    @IBOutlet var nextImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellView.ShadowView(view: cellView, radius: 10, opacity: 0.4, shadowRadius: 4, color: UIColor.darkGray.cgColor)
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
