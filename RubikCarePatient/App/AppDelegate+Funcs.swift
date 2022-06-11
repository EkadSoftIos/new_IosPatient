//
//  AppDelegate+Funcs.swift
//  E4 Patient
//
//  Created by mohab on 17/01/2021.
//

import UIKit
extension AppDelegate {
    func setupNavigationBar(){
        UINavigationBar.appearance().tintColor = AppColor.Blue
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
         //  UINavigationBar.appearance().tintColor = .white
          // UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name:AppFont.Cairo.regular.value, size: 18)!]
           UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
           UINavigationBar.appearance().shadowImage = UIImage()
           UINavigationBar.appearance().isTranslucent = true
           //UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().backItem?.leftBarButtonItem?.tintColor = AppColor.Blue
       }
    func setupTabbar(){
         let appearance = UITabBarItem.appearance()
         let attributes = [
                           NSAttributedString.Key.foregroundColor: AppColor.Blue]
         appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
     }
        
       
}

@available(iOS 13.0, *)
extension SceneDelegate{
    func setupNavigationBar(){
       /* UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
          // UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name:AppFont.Cairo.regular.value, size: 18)!]
           UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
           UINavigationBar.appearance().shadowImage = UIImage()
           UINavigationBar.appearance().isTranslucent = true
           UINavigationBar.appearance().backgroundColor = .clear*/
       }
    
    func setupTabbar(){
        let appearance = UITabBarItem.appearance()
        let attributes = [
                          NSAttributedString.Key.foregroundColor: AppColor.Blue]
        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
    }
       
}
