//
//  UITableView+Extensions.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 5/31/22.
//

import UIKit
import KafkaRefresh


extension UITableView {

    
    func endRefreshing(_ isRefreshAvailable:Bool) {
        if isRefreshAvailable {
            footRefreshControl.endRefreshing()
        }else{
            footRefreshControl.endRefreshingAndNoLongerRefreshing(withAlertText: "")
        }
    }
    
    func setEmptyMessage(_ message: String = "No data found".localized) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()
        backgroundView = messageLabel
        separatorStyle = .none
    }

    func hiddenEmptyMessage() {
        backgroundView = nil
        separatorStyle = .singleLine
    }
}
