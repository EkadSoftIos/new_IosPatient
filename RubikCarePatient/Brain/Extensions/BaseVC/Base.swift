//
//  Base.swift
//  E4 Patient
//
//  Created by Nada on 8/13/21.
//

import Foundation
import UIKit

protocol BaseViewProtocol where Self: UIViewController  {
    func showActivityIndicator(view: UIView, indicator: UIActivityIndicatorView)
    func hideActivityIndicator(view: UIView, indicator: UIActivityIndicatorView)
    func showAlert(title: String?, message: String?, selfDismissing: Bool, time: TimeInterval)
    func showAlertWithDismiss(title: String?, message: String?, selfDismissing: Bool, time: TimeInterval)
    func showAlertGoLog(title: String?, message: String?, selfDismissing: Bool, time: TimeInterval)
    func showAlertRestartApp(title: String?, message: String?, selfDismissing: Bool, time: TimeInterval)
    func presentPage(identifier: String)
    func goNextNavigationPage(identifier: String)
}

extension BaseViewProtocol{
    
    
    func showAlert(title: String? = "", message: String?, selfDismissing: Bool = true, time: TimeInterval = 2) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.view.alpha = 0.3
        
        if !selfDismissing {
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        }
        
        present(alert, animated: true)
        
        if selfDismissing {
            Timer.scheduledTimer(withTimeInterval: time, repeats: false) { t in
                t.invalidate()
                alert.dismiss(animated: true)
            }
        }
    }
    func showAlertRestartApp(title: String? = "", message: String?, selfDismissing: Bool = true, time: TimeInterval = 2) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.view.alpha = 0.3
        
        if !selfDismissing {
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        }
        
        present(alert, animated: true)
        
        if selfDismissing {
            Timer.scheduledTimer(withTimeInterval: time, repeats: false) { t in
                t.invalidate()
                alert.dismiss(animated: true)
//                AuthService.instance.restartApp()
            }
        }
    }

    func showAlertWithDismiss(title: String? = "", message: String?, selfDismissing: Bool = true, time: TimeInterval = 3) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.view.alpha = 0.3
        
        if !selfDismissing {
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        }
        
        present(alert, animated: true)
        
        if selfDismissing {
            Timer.scheduledTimer(withTimeInterval: time, repeats: false) { t in
                t.invalidate()
                alert.dismiss(animated: true)
                self.dismiss(animated: true)
            }
        }
    }
    
    func showAlertGoLog(title: String? = "", message: String? = "من فضلك سجل دخول اولا", selfDismissing: Bool = true, time: TimeInterval = 2) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.view.alpha = 0.3
        
        if !selfDismissing {
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        }
        
        present(alert, animated: true)
        
        if selfDismissing {
            Timer.scheduledTimer(withTimeInterval: time, repeats: false) { t in
                t.invalidate()
                alert.dismiss(animated: true)
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignInVC")
                vc.modalPresentationStyle = .fullScreen
                vc.modalTransitionStyle = .flipHorizontal
                self.present(vc, animated: true)
            }
        }
    }

    func showActivityIndicator(view: UIView, indicator: UIActivityIndicatorView) {
//        view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.35)
        
//        indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.frame = CGRect(x: 0, y: 0, width: indicator.bounds.size.width, height: indicator.bounds.size.height)
        
        indicator.center = view.center
        view.addSubview(indicator)
        view.center = self.view.center
        self.view.addSubview(view)
        
        indicator.startAnimating()
    }
    func hideActivityIndicator(view: UIView, indicator: UIActivityIndicatorView) {
        indicator.stopAnimating()
        view.removeFromSuperview()
    }
    func goNextNavigationPage(identifier: String) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: identifier)
        navigationController?.pushViewController(vc, animated: true)
    }
    func presentPage(identifier: String) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: identifier)
        vc.modalTransitionStyle = .flipHorizontal
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}
