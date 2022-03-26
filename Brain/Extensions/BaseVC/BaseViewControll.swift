//
//  BaseVC.swift
//  Mat3amy-Delivery-App
//
//  Created by Mohamed Lotfy on 6/14/18.
//  Copyright © 2018 Mat3amy. All rights reserved.
//

import UIKit

class BaseViewControll: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: IBOutlet
    @IBOutlet weak var sideMenuButton: UIBarButtonItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    // MARK: Variables
    let screenSize = UIScreen.main.bounds
    let dimView = UIView()
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // To make the navigation bar transparent
       
      
        
//        createDimView()
////        integrateSideMenu()
//        if(backButton != nil){
//            if L102Language.currentAppleLanguage() == arabicLang {
//                backButton.image = #imageLiteral(resourceName: "backarrow-right")
//            }else {
//                backButton.image = #imageLiteral(resourceName: "backarrow")
//            }
//        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        
//        if revealViewController() != nil {
//            revealViewController().delegate = self
//
//            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
//            view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
//            self.revealViewController().panGestureRecognizer().isEnabled = true
//        }
//
        
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    
    

    
    // To creat dim view when the side bar is open
    func createDimView(){
        dimView.frame = CGRect.init(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        dimView.backgroundColor = .clear
        self.view.addSubview(dimView)
        dimView.isHidden = true
    }
    

    func setView(view : UIView, superView: UIView){
        // to make the view with rounded corners and offset shadow form the bottom
        view.layer.borderColor = #colorLiteral(red: 0.13515836, green: 0.1564543247, blue: 0.2654414475, alpha: 1)
        view.layer.borderWidth = 1
        view.layer.cornerRadius = superView.frame.height * 0.025
        
    }
    
    func setViewCustomeRatio(view : UIView, superView: UIView, ratio : CGFloat){
        // to make the view with rounded corners and offset shadow form the bottom
        view.layer.borderColor = #colorLiteral(red: 0.13515836, green: 0.1564543247, blue: 0.2654414475, alpha: 1)
        view.layer.borderWidth = 1
        view.layer.cornerRadius = superView.frame.height * ratio
        
    }
    
    
    func setLoginView(view : UIView, superViwe: UIView){
        // to make the view with rounded corners and offset shadow form the bottom
        view.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.layer.borderWidth = 1
        view.layer.cornerRadius = superViwe.frame.height * 0.025
        
    }
    
    
    
    func setButton(button : UIButton){
        // to make the view with rounded corners and offset shadow form the bottom
        button.layer.cornerRadius = button.bounds.height/2
        button.layer.masksToBounds = false
        button.layer.shadowOffset = CGSize(width: 0, height: 1)
        button.layer.shadowRadius = 1
        button.layer.shadowOpacity = 0.3
    }
    
    func setImage(image : UIImageView){
        
        // to make the UIImageView with rounded corners
        image.layer.cornerRadius = image.bounds.height / 3
        image.layer.masksToBounds = true
        
    }
    
    func setupRoundedBorderForView(_ view: UIView,borderColor color: UIColor, andBorderWidth width: CGFloat){
        
        view.layoutIfNeeded()
        view.layer.cornerRadius = view.frame.size.height / 2
        view.layer.borderColor = color.cgColor
        view.layer.borderWidth = width
        view.clipsToBounds = true
        
    }
    
    
//    func setMenuFrontView(storyBoard: storyBoardName, vc: storyBoardVCIDs) {
//        let sb = UIStoryboard(name: storyBoard.rawValue, bundle: nil)
//        let vcNew = sb.instantiateViewController(withIdentifier: vc.rawValue) as! UINavigationController
//        self.revealViewController().setFront(vcNew, animated: true)
//        self.revealViewController().setFrontViewPosition(FrontViewPosition.left, animated: true)
//    }
    
    func isValidEmail(email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func isValidPhone(phone:String) -> Bool {
        let phoneRegEx = "[01]{2}+[0-9]{9}"
        let phoneTest = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return phoneTest.evaluate(with: phone)
    }
    
    func setTextFieldPlaceholder (textField: UITextField, placeholder: String){
        textField.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    func textFieldBeginEdit(textField : UITextField, view: UIView){
        textField.textColor = #colorLiteral(red: 0.9019607843, green: 0.7294117647, blue: 0.5607843137, alpha: 1)
        view.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.7294117647, blue: 0.5607843137, alpha: 1)
    }
    
    func textFieldEndEdit(textField: UITextField, view: UIView){
        textField.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    func showActionSheet(vc: UIViewController) {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.camera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.photoLibrary()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        vc.present(actionSheet, animated: true, completion: nil)
    }
    
    
    func camera()
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            imagePicker.sourceType = .camera
            imagePicker.delegate = self
            
            imagePicker.allowsEditing = true
            imagePicker.cameraDevice = .front
            
            if let topController = UIApplication.topViewController() {
                print("topController\(topController)")
                topController.present(imagePicker, animated: true, completion: nil)
            }
        }
        
    }
    
    func photoLibrary()
    {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            
            if let topController = UIApplication.topViewController() {
                print("topController\(topController)")
                topController.present(imagePicker, animated: true, completion: nil)
            }
            
        }
    }
    
    func formatDate(date: Date) -> String{
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy"
        
        
        return dateFormatterPrint.string(from: date)
        
    }
    
}
