//
//  3.swift
//  TYOUT
//
//  Created by Mohamed Lotfy on 9/25/18.
//  Copyright © 2018 Gra7. All rights reserved.
//

import UIKit
import AVFoundation


protocol PickerImageDelegate {
    func didPickedImage(_ image: UIImage)
}

class PickImageVC: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var delegate: PickerImageDelegate!
    
    func pick(vc: UIViewController){
        
        let alert:UIAlertController = UIAlertController(title: "Choose Image",
                                                        message: nil, preferredStyle: UIAlertController.Style.alert)
        
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertAction.Style.default) { UIAlertAction in
            self.openCamera()
        }
        let gallaryAction = UIAlertAction(title: "Photo gallery", style: UIAlertAction.Style.default) { UIAlertAction in
            self.openGallery()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) { UIAlertAction in
        }
        
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        
  
        vc.present(alert, animated: true, completion: nil)
    }
    
    // MARK: Image Pick Management
    func openCamera() {
        let picker = UIImagePickerController()
        
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            
            if self.determineStatus(){
                picker.sourceType = .camera
                picker.delegate = self
                
                picker.allowsEditing = true
                picker.cameraDevice = .front
                
                if let topController = UIApplication.topViewController() {
                    print("topController\(topController)")
                    _ = topController.navigationController?.popViewController(animated: true)
                    topController.present(picker, animated: true, completion: nil)
                }
            }
        }
        else {
          
        }
    }
    
    func openGallery() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        
        if let topController = UIApplication.topViewController() {
            print("topController\(topController)")
            topController.navigationController?.popViewController(animated: true)
            topController.present(picker, animated: true, completion: nil)
        }
    }
    

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            picker.dismiss(animated: true, completion: nil)
            
            if delegate != nil{
                delegate.didPickedImage(pickedImage)
            }
        }
    }
    
    
    func determineStatus() -> Bool {
        let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch status {
        case .authorized:
            return true
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: {_ in })
            return false
        case .restricted:
            return false
        case .denied:
            let alert = UIAlertController(
                title: "Need Authorization",
                message: "Wouldn't you like to authorize this app " +
                "to use the camera?",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(
                title: "No", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(
                title: "OK", style: .default, handler: {
                    _ in
                    let url = NSURL(string:UIApplication.openSettingsURLString)!
                    UIApplication.shared.openURL(url as URL)
            }))

            return false
        }
    }
    func showAlertWithTitle(_ title: String, message: String) {
        let alertView = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: nil, otherButtonTitles:  "OK")
        
        // Configure Alert View
        alertView.tag = 1
        
        // Show Alert View
        alertView.show()
    }
    
}
