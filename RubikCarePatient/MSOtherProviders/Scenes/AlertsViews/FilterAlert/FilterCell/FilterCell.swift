//
//  FilterCell.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 5/31/22.
//

import UIKit

struct FilterCellDisplay{
    let name:String
}

protocol FilterCellProtocol {
    func config(display:FilterCellDisplay)
}

class FilterCell: UITableViewCell, FilterCellProtocol {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var checkbox: UIImageView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        checkbox.isHighlighted = selected
        nameLabel.textColor = selected ? .selectedPCColor:.uncheckedServiceColor
    }
    
    
    func config(display: FilterCellDisplay) {
        nameLabel.text = display.name
    }
    
}
