//
//  UINavigationController+Extension.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/8/22.
//

import UIKit
import Foundation
import AVFoundation

extension UINavigationController{
    
    func getRootVC<Model>(vc:Model.Type) -> UIViewController? where Model: AnyObject {
        for childVC in viewControllers as Array {
            if childVC.isKind(of: vc.self){
                return childVC
            }
        }// end Loop
        return nil
    }
    
    func popTo<Model>(vc:Model.Type, animated: Bool = true) where Model: AnyObject {
        for childVC in viewControllers as Array {
            if childVC.isKind(of: vc.self){
                popToViewController(childVC, animated: animated)
                break
            }
        }// end Loop
    }
    
    func popTo(vc:UIViewController, animated: Bool = true)  {
        popToViewController(vc, animated: animated)
    }
    
}
