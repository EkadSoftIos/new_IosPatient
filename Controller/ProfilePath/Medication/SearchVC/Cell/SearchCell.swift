//
//  SearchCell.swift
//  Khadom
//
//  Created by mohab on 23/12/2020.
//  Copyright © 2020 panorama. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {
    @IBOutlet var searchLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
