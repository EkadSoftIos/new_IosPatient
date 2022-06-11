//
//  AnimationViewRotate.swift
//  E4 Patient
//
//  Created by mohab on 21/03/2021.
//

import UIKit
extension UIView {

    func rotate(angle: CGFloat) {
        
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = self.transform.rotated(by: radians);
        self.transform = rotation
    }
}
