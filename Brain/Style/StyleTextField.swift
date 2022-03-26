//
//  textFieldStyle.swift
//  osratyUser
//
//  Created by apple on 4/19/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
class StyleTextField : TextField {
        
    func applyTextFieldStyle() {
        
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyTextFieldStyle()
    }
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        applyTextFieldStyle()
    }
    
}
 class StyleTextFieldGreenCorner: StyleTextField {
    override func applyTextFieldStyle() {
        self.layer.cornerRadius = self.layer.frame.height / 2
        self.layer.borderWidth = 1
        self.layer.borderColor = AppColor.Blue.cgColor
        self.layer.masksToBounds = true
        
    }
}

class StyleTextFieldGrayBorder: StyleTextField {
    override func applyTextFieldStyle() {
        self.layer.borderWidth = 1
        self.layer.borderColor = AppColor.Blue.cgColor
        self.layer.masksToBounds = true
        
    }
}

class StyleTextFieldShadowRounded : StyleTextField{
    override func applyTextFieldStyle() {
        //Basic texfield Setup
          self.backgroundColor = AppColor.Blue

          //To apply corner radius
          self.layer.cornerRadius = self.frame.size.height / 2

          //To apply border
          self.layer.borderWidth = 0.25
          self.layer.borderColor = UIColor.white.cgColor

          //To apply Shadow
          self.layer.shadowOpacity = 1
          self.layer.shadowRadius = 3.0
          self.layer.shadowOffset = CGSize.zero
          //  self.layer.shadowOffset = CGSize(width: 0, height: 3)

          self.layer.shadowColor = UIColor.gray.cgColor
        //self.layoutIfNeeded()
    }

}

class StyleTextFieldShadowRoundedClear : StyleTextField{
    override func applyTextFieldStyle() {
        self.backgroundColor = .white
          //To apply corner radius
          self.layer.cornerRadius = self.frame.size.height / 2

          //To apply border
          self.layer.borderWidth = 0.25
          self.layer.borderColor = UIColor.white.cgColor

          //To apply Shadow
          self.layer.shadowOpacity = 1
          self.layer.shadowRadius = 3.0
          self.layer.shadowOffset = CGSize.zero
          //  self.layer.shadowOffset = CGSize(width: 0, height: 3)

          self.layer.shadowColor = UIColor.gray.cgColor
        //self.layoutIfNeeded()
    }

}

/* class StyleTextFieldLineGray: StyleTextField {
    override func applyTextFieldStyle() {
      /*  let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.height - 1, width: self.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.groupTableViewBackground.cgColor
        self.borderStyle = .none
        self.layer.addSublayer(bottomLine)*/
        
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.groupTableViewBackground.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
        
    }
}*/
 class StyleTextFieldLineWhite: StyleTextField {
    override func applyTextFieldStyle() {
        
        self.borderStyle = .none
//        self.addLine(position: .LINE_POSITION_BOTTOM, color: AppColor.Blue, width: 1)

    }
}

 class StyleTextFieldLineGray: StyleTextField {
    override func applyTextFieldStyle() {
 
        self.borderStyle = .none
       // self.addLine(position: .LINE_POSITION_BOTTOM, color: AppColor.Blue, width: 1)

    }
}
