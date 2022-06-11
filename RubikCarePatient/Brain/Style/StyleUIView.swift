//
//  StyleUIView.swift
//  TaxiOrder
//
//  Created by apple on 9/2/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
class StyleUIView: UIView {
    
    func applyStyle() {
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyStyle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        applyStyle()
    }
    
    
}

class StyleViewRoundedBottomShadow : StyleUIView{
    override func applyStyle() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = CGFloat(frame.size.height / 2 )
        self.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 3.5
    }
}
class StyleViewShadow : StyleUIView {
    override func applyStyle() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = CGFloat(8)
        self.layer.shadowOffset = .zero
        self.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 15
        
    }
}
class StyleViewBorderYellowCorner : StyleUIView {
    override func applyStyle() {
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = AppColor.Blue.cgColor
        self.layer.masksToBounds = true
    }
}
/*class StyleGradiantCorner : StyleUIView {
 var gradientLayer:CAGradientLayer = CAGradientLayer()
 
 override func applyStyle() {
 self.layer.cornerRadius = CGFloat(10)
 self.layer.masksToBounds = true
 // gradientLayer.frame.size = self.frame.size
 gradientLayer.frame = self.bounds
 gradientLayer.colors =
 [AppColor.Green.cgColor,AppColor.GreenLight.cgColor]
 gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
 self.layer.insertSublayer(gradientLayer, at: 0)
 
 
 }
 override func layoutSubviews() {
 super.layoutSubviews()
 gradientLayer.frame = self.bounds
 layoutIfNeeded()
 }
 }
 class StyleGradiant : StyleUIView {
 var gradientLayer:CAGradientLayer = CAGradientLayer()
 override func applyStyle() {
 
 gradientLayer.frame = self.bounds
 gradientLayer.colors =
 [AppColor.Green.cgColor,AppColor.GreenLight.cgColor]
 gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
 self.layer.insertSublayer(gradientLayer, at: 0)
 
 }
 
 override func layoutSubviews() {
 super.layoutSubviews()
 gradientLayer.frame = self.bounds
 layoutIfNeeded()
 }
 
 }
 */
