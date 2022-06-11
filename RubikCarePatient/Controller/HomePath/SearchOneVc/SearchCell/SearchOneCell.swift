//
//  SearchOneCell.swift
//  E4 Patient
//
//  Created by mohab on 25/04/2021.
//

import UIKit

class SearchOneCell: UITableViewCell {
    @IBOutlet var mainView: UIView!
    @IBOutlet var speImage: UIImageView!
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var douctorsNumberLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.ShadowView(view: mainView, radius: 10, opacity: 0.3, shadowRadius: 3, color: UIColor.darkGray.cgColor)
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
