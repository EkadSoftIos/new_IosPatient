//
//  LoadingButton.swift
//  VetClinic
//
//  Created by Mohammed Elnaggar on 9/19/18.
//  Copyright © 2018 Mohammed Elnaggar. All rights reserved.
//

import UIKit
protocol AnimatableView: class {
    func startAnimating()
    func stopAnimating()
}

class LoadingButton: UIButton, AnimatableView {
    
    var originalButtonText: String?
    var activityIndicator: UIActivityIndicatorView!
    
    @IBInspectable
    var activityIndicatorColor: UIColor = .white
    
    func startAnimating() {
        self.isUserInteractionEnabled = false
        originalButtonText = self.titleLabel?.text
        self.setTitle("", for: .normal)
        
        if (activityIndicator == nil) {
            activityIndicator = createActivityIndicator()
        }
        
        showSpinning()
    }
    
    func stopAnimating() {
        self.isUserInteractionEnabled = true
        self.setTitle(originalButtonText, for: .normal)
        activityIndicator.stopAnimating()
    }
    
    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = activityIndicatorColor
        return activityIndicator
    }
    
    private func showSpinning() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        centerActivityIndicatorInButton()
        activityIndicator.startAnimating()
    }
    
    private func centerActivityIndicatorInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: self,
                                                   attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: activityIndicator,
                                                   attribute: .centerX,
                                                   multiplier: 1, constant: 0)
        self.addConstraint(xCenterConstraint)
        
        let yCenterConstraint = NSLayoutConstraint(item: self,
                                                   attribute: .centerY,
                                                   relatedBy: .equal,
                                                   toItem: activityIndicator,
                                                   attribute: .centerY,
                                                   multiplier: 1, constant: 0)
        self.addConstraint(yCenterConstraint)
    }
    
}
