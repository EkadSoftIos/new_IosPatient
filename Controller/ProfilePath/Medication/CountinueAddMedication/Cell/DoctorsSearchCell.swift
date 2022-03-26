//
//  DoctorsSearchCell.swift
//  E4 Patient
//
//  Created by mohab on 21/03/2021.
//

import UIKit

class DoctorsSearchCell: UITableViewCell {
    @IBOutlet var nameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //doctorsCell
    static var nib : UINib {
        return UINib(nibName: identifire, bundle: nil)
    }
    
    static var identifire : String {
        return String(describing: self)
    }
}
