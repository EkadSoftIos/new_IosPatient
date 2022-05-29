//
//  ServiceCell.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 5/29/22.
//

import UIKit

struct ServiceCellDisplay{
    let name:String
}

protocol ServiceCellProtocol {
    func config(display:ServiceCellDisplay)
}

class ServiceCell: UITableViewCell, ServiceCellProtocol {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var checkbox: UIImageView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        checkbox.isHighlighted = selected
        nameLabel.textColor = selected ? .selectedPCColor:.uncheckedServiceColor
    }
    
    
    func config(display: ServiceCellDisplay) {
        
    }
    
}

extension UIColor{
    
    public static let uncheckedServiceColor = UIColor(named: "uncheckedServiceColor")
}
