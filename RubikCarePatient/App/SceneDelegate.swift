//
//  SceneDelegate.swift
//  E4 Patient
//
//  Created by mohab on 16/01/2021.
//

import UIKit
import IQKeyboardManager
import MOLH

class SceneDelegate: UIResponder, UIWindowSceneDelegate, MOLHResetable {

    var window: UIWindow?


    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        setupNavigationBar()
        setupTabbar()
        setupKeyboard()
        
        guard let _ = (scene as? UIWindowScene) else { return }
        
        MOLH.setLanguageTo(Locale.preferredLanguages[0])
        MOLH.shared.activate(true)
        MOLHLanguage.setDefaultLanguage("ar")
        reset()
    }
    
    func setupKeyboard(){
        IQKeyboardManager.shared().isEnabled  = true
        IQKeyboardManager.shared().toolbarTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func reset() {
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
