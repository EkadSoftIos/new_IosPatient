//
//  StyleTextView.swift
//  TaxiOrder
//
//  Created by apple on 8/29/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
class StyleTextView: UITextView {
    
    let padding = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    
    func applyTextViewStyle() {
        self.contentInset = padding
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        applyTextViewStyle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        applyTextViewStyle()
    }
}
class StyleTextViewBorderGray: StyleTextView {
    override func applyTextViewStyle() {
        self.layer.borderWidth = 1
        self.layer.borderColor = AppColor.Blue.cgColor
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
    }
}
