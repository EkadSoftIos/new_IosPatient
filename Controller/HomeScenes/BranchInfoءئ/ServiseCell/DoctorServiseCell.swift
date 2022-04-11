//
//  DoctorServiseCell.swift
//  E4 Patient
//
//  Created by mohab on 09/05/2021.
//

import UIKit

class DoctorServiseCell: UITableViewCell {

    @IBOutlet weak var medicalName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    static var nib : UINib {
        return UINib(nibName: identifire, bundle: nil)
    }
    
    static var identifire : String {
        return String(describing: self)
    }
    
}
