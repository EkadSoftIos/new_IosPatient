//
//  StyleButtonBackgroundOrange.swift
//  TaxiOrder
//
//  Created by apple on 8/29/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
class StyleButton: LoadingButton {
    
    func applyStyle() {
        
        self.layer.cornerRadius = self.layer.frame.height / 2
        self.clipsToBounds = true
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

class StyleButtonBackgroundGreen: StyleButton {
    override func applyStyle() {
        super.applyStyle()
        self.setTitleColor(UIColor.white, for: .normal)
        self.backgroundColor = AppColor.Blue
    }
}

class StyleButtonBackgroundOrange: StyleButton {
    override func applyStyle() {
        super.applyStyle()
        self.setTitleColor(UIColor.white, for: .normal)
        self.backgroundColor = AppColor.Blue
    }
}

class StyleButtonBackgroundYellow: StyleButton {
    override func applyStyle() {
        super.applyStyle()
        self.setTitleColor(UIColor.white, for: .normal)
        self.backgroundColor = AppColor.Blue
    }
}

class StyleButtonBackgroundWhite: StyleButton {
    override func applyStyle() {
        super.applyStyle()
        self.setTitleColor(AppColor.Blue, for: .normal)
        self.backgroundColor = .white
    }
}
class StyleButtonBorderGreen: StyleButton {
    override func applyStyle() {
        super.applyStyle()
        self.setTitleColor(AppColor.Blue, for: .normal)
        self.layer.borderWidth = 1
        self.layer.borderColor = AppColor.Blue.cgColor
    }
}

class StyleButtonAnimation : StyleButtonBackgroundOrange {
    private let expandCurve:CAMediaTimingFunction   = CAMediaTimingFunction(controlPoints: 0.95, 0.02, 1, 0.05)
    
    func expand(completion:(()->Void)?, revertDelay: TimeInterval) {
        
        let expandAnim = CABasicAnimation(keyPath: "transform.scale")
        let expandScale = (UIScreen.main.bounds.size.height/self.frame.size.height)*2
        expandAnim.fromValue            = 1.0
        expandAnim.toValue              = max(expandScale,26.0)
        expandAnim.timingFunction       = expandCurve
        expandAnim.duration             = 0.4
        expandAnim.fillMode             = .forwards
        expandAnim.isRemovedOnCompletion  = false
        
        CATransaction.setCompletionBlock {
            completion?()
            // We return to original state after a delay to give opportunity to custom transition
            DispatchQueue.main.asyncAfter(deadline: .now() + revertDelay) {
                self.setOriginalState(completion: nil)
                self.layer.removeAllAnimations() // make sure we remove all animation
            }
        }
        
        layer.add(expandAnim, forKey: expandAnim.keyPath)
        
        CATransaction.commit()
    }
    
    private func setOriginalState(completion:(()->Void)?) {
        
        self.isUserInteractionEnabled = true // enable again the user interaction
        
    }
    func shakeAnimation(completion:(()->Void)?) {
        let keyFrame = CAKeyframeAnimation(keyPath: "position")
        let point = self.layer.position
        keyFrame.values = [NSValue(cgPoint: CGPoint(x: CGFloat(point.x), y: CGFloat(point.y))),
                           NSValue(cgPoint: CGPoint(x: CGFloat(point.x - 10), y: CGFloat(point.y))),
                           NSValue(cgPoint: CGPoint(x: CGFloat(point.x + 10), y: CGFloat(point.y))),
                           NSValue(cgPoint: CGPoint(x: CGFloat(point.x - 10), y: CGFloat(point.y))),
                           NSValue(cgPoint: CGPoint(x: CGFloat(point.x + 10), y: CGFloat(point.y))),
                           NSValue(cgPoint: CGPoint(x: CGFloat(point.x - 10), y: CGFloat(point.y))),
                           NSValue(cgPoint: CGPoint(x: CGFloat(point.x + 10), y: CGFloat(point.y))),
                           NSValue(cgPoint: point)]
        
        keyFrame.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        keyFrame.duration = 0.7
        self.layer.position = point
        
        CATransaction.setCompletionBlock {
            completion?()
        }
        self.layer.add(keyFrame, forKey: keyFrame.keyPath)
        
        CATransaction.commit()
    }
    
}
