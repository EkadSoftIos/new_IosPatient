//
//  AULocationCell.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/2/22.
//

import UIKit
import SKCountryPicker

struct AULocationDisplay{
    let name:String
    
    init?(item:Any) {
        if let country = item as? ULCountry  {
            name = country.nameLocalized
        }else if let city = item as? City  {
            name = city.nameLocalized
        }else if let area = item as? Area  {
            name = area.nameLocalized
        }else {
            return nil
        }
    }
}

protocol AULocationCellProtocol{
    func config(display:AULocationDisplay)
}

class AULocationCell: UITableViewCell, AULocationCellProtocol {
    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.applyShadow(0.2)
    }
    
    func config(display: AULocationDisplay) {
        selectionStyle = .none
        titleLabel.text = display.name
    }

}
