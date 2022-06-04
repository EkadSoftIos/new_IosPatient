//
//  UIViewController+Extension.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/4/22.
//

import UIKit
import Foundation

extension UIViewController{
    
    func openAppSettings(){
        let settingTitle = "Settings".localized
        let message = "Please go to Settings and turn on the permissions".localized
        let alertController = UIAlertController(title: settingTitle, message: message, preferredStyle: .alert)
        
        
        let settingsAction = UIAlertAction(title: settingTitle, style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel".localized, style: .default, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(settingsAction)
        present(alertController, animated: true, completion: nil)
    }
}
