//
//  UICollection+Extension.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/8/22.
//

import UIKit

extension UICollectionView {

    func setEmptyMessage(_ message: String = "No data found".localized) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height))
        messageLabel.font = UIFont.font(style: .regular, size: 14)
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()
        backgroundView = messageLabel
    }

    func hiddenEmptyMessage() {
        backgroundView = nil
    }
}
