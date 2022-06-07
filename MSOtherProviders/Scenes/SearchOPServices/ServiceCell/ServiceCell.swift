//
//  ServiceCell.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 5/29/22.
//

import UIKit

struct ServiceCellDisplay{
    let name:String
    let isWithPrice:Bool
    let priceAfterDiscount:String?
    let priceBeforeDiscount:String?
    init(service:Service, isWithPrice:Bool) {
        self.isWithPrice = isWithPrice
        name = service.serviceNameLocalized
         
        if let price = service.price {
            priceBeforeDiscount = price.stringValue
        } else{ priceBeforeDiscount = nil }
        if let price = service.priceAfterDiscount {
            priceAfterDiscount = price.stringValue
        } else{ priceAfterDiscount = nil }
    }
}

protocol ServiceCellProtocol {
    func config(display:ServiceCellDisplay)
}

class ServiceCell: UITableViewCell, ServiceCellProtocol {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var checkbox: UIImageView!
    @IBOutlet weak var priceAfterDiscountLabel: UILabel!
    @IBOutlet weak var priceBeforeDiscountLabel: UILabel!

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        checkbox.isHighlighted = selected
        nameLabel.textColor = selected ? .selectedPCColor:.uncheckedServiceColor
        priceAfterDiscountLabel.textColor = selected ? .selectedPCColor:.uncheckedServiceColor
        priceBeforeDiscountLabel.textColor = selected ? .selectedPCColor:.uncheckedServiceColor
    }
    
    
    func config(display: ServiceCellDisplay) {
        nameLabel.text = display.name
        
        if let price = display.priceBeforeDiscount, display.isWithPrice{
            priceAfterDiscountLabel.text = price
        }
        if let price = display.priceBeforeDiscount, display.isWithPrice{
            priceBeforeDiscountLabel.text = price
            priceBeforeDiscountLabel.setStrikethroughStyle()
        }
        priceAfterDiscountLabel.isHidden = display.isWithPrice
        priceBeforeDiscountLabel.isHidden = display.isWithPrice
    }
    
}
