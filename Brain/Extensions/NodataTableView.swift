//
//  NodataTableView.swift
//  Naqilat Delivery
//
//  Created by mohab on 9/10/20.
//  Copyright © 2020 panorama. All rights reserved.
//

import Foundation
import UIKit
extension UITableView {
    func setNoDataPlaceholder(_ message: String) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 600, height: self.bounds.size.height))
        label.textAlignment = .center
        label.text = message
        // styling
        label.sizeToFit()

        self.isScrollEnabled = false
        self.backgroundView = label
        self.separatorStyle = .none
    }
}
extension UITableView {
    func removeNoDataPlaceholder() {
        self.isScrollEnabled = true
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
