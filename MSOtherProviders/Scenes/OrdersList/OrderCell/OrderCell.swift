//
//  OrderCell.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/8/22.
//

import UIKit
import Kingfisher

struct OrderCellDisplay {
    let avatar:URL?
    let numText:String
    let timeText:String
    let dateText:String
    let msNumText:String
    let branchNameText:String
    let priceText:NSAttributedString?
    
    init(order:Order, type:MSType) {
        timeText = order.createDate.timeFormated
        dateText = order.createDate.dateFullFormated
        branchNameText = order.branchNameLocalized
        msNumText = "\(order.itemCount) \(type.searchResultText)"
        numText = "\("Order Num".localized) \(order.bookingNumber)"
        avatar = URL(string: "\(URLs.baseURLImage)\(order.otherProviderImage)")
        if order.priceAfterDiscount > 0.0{
            priceText = order.priceAfterDiscount.totalStringValue
        }else { priceText = nil }
    }
}

protocol OrderCellProtocol{
    func config(display:OrderCellDisplay)
}

class OrderCell: UITableViewCell, OrderCellProtocol {
    
    

    // MARK: - Public properties -
    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var msNumLabel: UILabel!
    @IBOutlet weak var conainerView: UIView!
    @IBOutlet weak var branchNameLabel: UILabel!
    @IBOutlet weak var branchImageView: UIImageView!
    
    // MARK: - layoutSubviews  -
    override func layoutSubviews() {
        super.layoutSubviews()
        conainerView.applyShadow(0.3)
        branchImageView.cornerRadius = branchImageView.frame.height / 2
    }
    
    // MARK: - config  -
    func config(display: OrderCellDisplay) {
        
        numLabel.text = display.numText
        timeLabel.text = display.timeText
        dateLabel.text = display.dateText
        msNumLabel.text = display.msNumText
        branchNameLabel.text = display.branchNameText
        priceLabel.attributedText = display.priceText
        branchImageView.kf.indicatorType = .activity
        branchImageView.kf.setImage(with: display.avatar, placeholder: UIImage(named: "ProfileImage"))
    }
    
}
