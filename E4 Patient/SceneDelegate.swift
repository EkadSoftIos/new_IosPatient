//
//  SceneDelegate.swift
//  E4 Patient
//
//  Created by mohab on 16/01/2021.
//

import UIKit
import IQKeyboardManager
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        setupNavigationBar()
        setupTabbar()
        setRoot()
        setupKeyboard()
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    func setupKeyboard(){
        IQKeyboardManager.shared().isEnabled  = true
        IQKeyboardManager.shared().toolbarTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
       }
    func setRoot(){
        let token = UserDefaults.standard.object(forKey: "token")
        if token != nil{
           let vc = TabbarManager()
            //let vc = LoginVC()
            window?.rootViewController = vc
            window?.makeKeyAndVisible()
        }else{
            let vc = LoginVC()
            window?.rootViewController = vc
            window?.makeKeyAndVisible()
        }
    }
    

}

