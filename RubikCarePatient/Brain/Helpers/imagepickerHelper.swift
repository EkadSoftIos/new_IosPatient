//
//  imagepickerHelper.swift
//  Naqilat Delivery
//
//  Created by mohab on 8/30/20.
//  Copyright © 2020 panorama. All rights reserved.
//

import Foundation
import UIKit
//import ImagePicker
class imagePickerHelper: NSObject ,ImagePickerDelegate {
    
    private weak var presentingViewController: UIViewController?

    
    private lazy var imagePicker: ImagePickerController = {
        let imagePicker = ImagePickerController()
        imagePicker.delegate = self
        //imagePicker.imageLimit = 1
        return imagePicker
    }()
    
    var imageSelected: ((_ image: UIImage) -> ())?
    var imagesSelected : ((_ images : [UIImage])->())?
    init(viewController : UIViewController,limit : Int? = 1) {
        super.init()
        presentingViewController = viewController
        imagePicker.imageLimit = limit ?? 1
    }
    
    func presentImagePicker() {
        //imagePicker.modalPresentationStyle = .fullScreen
        
        presentingViewController?.present(imagePicker, animated: true, completion: nil)
    }
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        imagePicker.dismiss(animated: true, completion: nil)
        print(images.count)
        if imagePicker.imageLimit == 1 {
            if let image = images.first {
                imageSelected?(image)
            }
        }else{
         imagesSelected?(images)
        }
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        //presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    

}
