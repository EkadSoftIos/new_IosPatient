//
//  AppDelegate.swift
//  E4 Patient
//
//  Created by mohab on 16/01/2021.
//

import UIKit
import IQKeyboardManager
import FBSDKCoreKit

//@main
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupNavigationBar()
       // let attributes = [NSAttributedString.Key.font:  UIFont(name: "Helvetica-Bold", size: 0.1)!, NSAttributedString.Key.foregroundColor: UIColor.clear]

        //setupTabbar()
      //  window?.rootViewController = LoginVC()
       // window?.makeKeyAndVisible()
        UINavigationBar.appearance().tintColor = AppColor.Blue
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -1000.0, vertical: 0.0), for: .default)
    //    navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: AppColor.Blue]
        
     //UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: UIControl.State.highlighted)
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().tintColor = AppColor.Blue
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
        
        setupKeyboard()
        return true
    }
    func setupKeyboard(){
        IQKeyboardManager.shared().isEnabled  = true
        IQKeyboardManager.shared().toolbarTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
       }



}

extension UINavigationController{

    func customizeBackArrow(){
        let yourBackImage = UIImage(named: "ic_back")
        self.navigationBar.backIndicatorImage = yourBackImage
       // self.navigationBar.tintColor = Common.offBlackColor
        self.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        navigationItem.leftItemsSupplementBackButton = true
        self.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "",
           style: .plain, target: self, action: nil)

    }
}
