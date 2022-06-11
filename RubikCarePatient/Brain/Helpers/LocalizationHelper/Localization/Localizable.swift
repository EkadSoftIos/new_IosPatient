//
//  Localizable.swift
//  Zaid
//
//  Created by Ahlam on 1/8/19.
//  Copyright © 2019 700apps. All rights reserved.
//
import Foundation
import UIKit
var fromSetting =  true

protocol XIBLocalizable {
    var xibLocKey: String? { get set }
}

extension UILabel: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            text = key?.localized
            //self.textAlignment = Language.language == .english ? .left : .right
        }
    }
}

extension UIButton: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            setTitle(key?.localized, for: .normal)
        }
    }
    @IBInspectable var imgLocalized: String? {
        get { return nil }
        set(key) {
            guard let imgKey = key?.localized else {
                return
            }
            self.setImage(UIImage(named: imgKey), for: .normal)
        }
    }
}

enum Languagee: String {
    
    case arabic = "ar"
    case english = "en"
    case ukrainian = "uk"
    
    var semantic: UISemanticContentAttribute {
        switch self {
        case .arabic:
            return .forceRightToLeft
        case .english, .ukrainian:
            return .forceLeftToRight
        
        }
    }
    
    
    static var language: Languagee {
        get {
            
            if let languageCode = UserDefaults.standard.string(forKey: Constants.appleLanguagesKey),
                let language = Languagee(rawValue: languageCode) {
                return language
            } else {
                let preferredLanguage = NSLocale.preferredLanguages[0] as String
                let index = preferredLanguage.index(
                    preferredLanguage.startIndex,
                    offsetBy: 2
                )
                guard let localization = Languagee(
                    rawValue: preferredLanguage.substring(to: index)
                    ) else {
                        return Languagee.english
                }
                
                return localization
            }
        }
        set {
            guard language != newValue else {
                return
            }
            
            //change language in the app
            //the language will be changed after restart
            UserDefaults.standard.set([newValue.rawValue], forKey: Constants.appleLanguagesKey)
            UserDefaults.standard.synchronize()
            
            //Changes semantic to all views
            //this hack needs in case of languages with different semantics: leftToRight(en/uk) & rightToLeft(ar)
            UIView.appearance().semanticContentAttribute = newValue.semantic
            
            //initialize the app from scratch
            //show initial view controller
            //so it seems like the is restarted
            //NOTE: do not localize storboards
            //After the app restart all labels/images will be set
            //see extension String below
//           if fromSetting {
//                let vc = UIStoryboard(name: "Main",bundle: nil).instantiateViewController(withIdentifier: "Main")
//               // Utilities.shared.getSetting()
///               UIApplication.shared.windows[0].rootViewController = vc
//               // Utilities.shared.getSetting()
//          }
          //  else{ //AdsViewController
//                let vc = UIStoryboard(name: "Main",bundle: nil).instantiateViewController(withIdentifier: "SplasScreenViewController")
//                UIApplication.shared.windows[0].rootViewController = vc
          //  }
        
        }
    }
}

extension UITextField: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
             self.semanticContentAttribute = Languagee.arabic.semantic
            if Languagee.language == .arabic{
                self.textAlignment = .right
            }else{
                self.textAlignment = .left
            }
            self.placeholder = key?.localized
            
            self.textAlignment = Languagee.language == .english ? .left : .right
        }
    }
}


extension UIBarButtonItem: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            self.title = key?.localized
        }
    }
    @IBInspectable var ImageLocalized: String? {
        get { return nil }
        set(key) {
            guard let key = key else {
                return
            }
            self.image = UIImage(named: key.localized)
            //            self.title = key?.localized
        }
    }
}
extension UISearchBar: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            self.placeholder = key?.localized
        }
    }
}



extension UITabBarItem: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            self.title = key?.localized
        }
    }
    
}
extension String {
    
    var localized: String {
        return Bundle.localizedBundle.localizedString(forKey: self, value: nil, table: nil)
    }
    
    var localizedImage: UIImage? {
        return localizedImage()
            ?? localizedImage(type: ".png")
            ?? localizedImage(type: ".jpg")
            ?? localizedImage(type: ".jpeg")
            ?? UIImage(named: self)
    }
    
    private func localizedImage(type: String = "") -> UIImage? {
        guard let imagePath = Bundle.localizedBundle.path(forResource: self, ofType: type) else {
            return nil
        }
        return UIImage(contentsOfFile: imagePath)
    }
}

extension Bundle {
    //Here magic happens
    //when you localize resources: for instance Localizable.strings, images
    //it creates different bundles
    //we take appropriate bundle according to language
    static var localizedBundle: Bundle {
        let languageCode = Languagee.language.rawValue
        guard let path = Bundle.main.path(forResource: languageCode, ofType: "lproj") else {
            return Bundle.main
        }
        return Bundle(path: path)!
    }
}

