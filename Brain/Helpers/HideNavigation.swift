//
//  HideNavigation.swift
//  Aldubaikhi
//
//  Created by mohab on 5/6/20.
//  Copyright © 2020 panorama. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController {
  func navigation(){
     self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
     self.navigationController?.navigationBar.shadowImage = UIImage()
     self.navigationController?.navigationBar.isTranslucent = true
     self.navigationController?.view.backgroundColor = .clear
  }

  
}
