////
////  5.swift
////  TYOUT
////
////  Created by Mohamed Lotfy on 9/25/18.
////  Copyright © 2018 Gra7. All rights reserved.
////
//
import UIKit
import Kingfisher
import AudioToolbox
import SwiftMessages
import SwiftEntryKit
import UIView_Shake
extension UIViewController : UIGestureRecognizerDelegate{
    

    
    // MARK: - Instatiate, Show And Present VC
    func instatiateVCFrom(board: storyBoardName, vcId: storyBoardVCIDs) -> UIViewController {
        let storyBoard = UIStoryboard(name: board.rawValue, bundle: nil)
        return storyBoard.instantiateViewController(withIdentifier: vcId.rawValue)
    }
    
    // MARK: - Transparent With Nav Bar
    func transparentNavBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    func setTitleImage(name:String){
        let logo = UIImage(named: name)
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
    }

    func setNavImage(name:String){
        let logo = UIImage(named: name)
        
        let imageView = UIImageView(image:logo)
        //        imageView.contentMode = .scaleToFill
        self.navigationController?.navigationBar.setBackgroundImage(imageView.image?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .tile), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    // MARK: - Transparent With Nav Bar
    func notTransparentNavBar() {
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
    }
    
    @IBAction func backClicked(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func searchClicked(_ sender: Any) {
       // self.show(self.instatiateVCFrom(board: .Main, vcId: .SearchVC), sender: self)
    }
    
    @IBAction func dismissToRootClicked(_ sender: Any) {
           self.view.window!.rootViewController?.dismiss(animated: true)
       }
    
    @IBAction func dismissClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func startAnimatingView(text:String = ""){
              

    
    }
    
    func stopAnimating()  {
    }

    // MARK: - Show Alert
      func showAlertWith(title: String? = nil, msg: String? = nil, type: Theme = .warning, layout: MessageView.Layout = .messageView) {
          
          let view = MessageView.viewFromNib(layout: .messageView)
          var config = SwiftMessages.Config()
          config.presentationContext = .window(windowLevel: .statusBar)
          view.configureTheme(backgroundColor: UIColor.black.withAlphaComponent(0.92), foregroundColor: .white)
          view.configureContent(title: title ?? "", body: msg ?? "", iconText: "")
          view.button?.isHidden = true
//          view.bodyLabel?.font = UIFont.init(name: Constants.AppFont.regular.rawValue, size: 17.0)
          
          
          SwiftMessages.show(config: config, view: view)
          
      }
    
    func showMessage(title: String? = nil, sub: String?, type: Theme = .warning, layout: MessageView.Layout = .messageView) {
        // Instantiate a message view from the provided card view layout. SwiftMessages searches for nib
        // files in the main bundle first, so you can easily copy them into your project and make changes.

        let view = MessageView.viewFromNib(layout: layout)
        var config = SwiftMessages.Config()
        config.presentationContext = .window(windowLevel: .statusBar)
        if type == .error {
            Vibration.error.vibrate()
            view.configureTheme(backgroundColor: UIColor.red.withAlphaComponent(0.92), foregroundColor: .white)
        }else{
            view.configureTheme(backgroundColor: AppColor.Blue.withAlphaComponent(0.92), foregroundColor: .white)
        }

        view.configureContent(title: title ?? "", body: sub ?? "", iconText: "")
        view.button?.isHidden = true
//        view.bodyLabel?.font = UIFont.init(name: Constants.AppFont.regular.rawValue, size: 17.0)
        
        
        SwiftMessages.show(config: config, view: view)
        
    }
    func showpopView(myView: UIView,hieght: CGFloat) {
        var attributes = EKAttributes()
        attributes = .centerFloat
        attributes.hapticFeedbackType = .success
        attributes.displayDuration = .infinity
        attributes.screenBackground = .visualEffect(style: .dark)
        attributes.entryBackground = .clear
        attributes.screenInteraction = .dismiss
        attributes.entryInteraction = .absorbTouches
        
        attributes.entranceAnimation = .init(translate: .init(duration: 0.6, spring: .init(damping: 0.9, initialVelocity: 0)),
                                             scale: .init(from: 0.8, to: 1, duration: 0.6, spring: .init(damping: 0.8, initialVelocity: 0)),
                                             fade: .init(from: 0.7, to: 1, duration: 0.3))
        attributes.exitAnimation = .init(translate: .init(duration: 0.5),
                                         scale: .init(from: 1, to: 0.8, duration: 0.5),
                                         fade: .init(from: 1, to: 0, duration: 0.5))
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.3),
                                                            scale: .init(from: 1, to: 0.8, duration: 0.3)))
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.3, radius: 6))
        attributes.positionConstraints.verticalOffset = 10
        attributes.positionConstraints.size = .init(width: .offset(value: 20), height: .constant(value: hieght))
        attributes.positionConstraints.maxSize = .init(width: .constant(value: UIScreen.main.minEdge), height: .intrinsic)
        attributes.statusBar = .inferred
        SwiftEntryKit.display(entry: myView, using: attributes)
    }
    
    
    func addPopGesture() {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    func alert(msg:String) {
        let alert = UIAlertController(title: "", message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    // MARK: - Email And Phone Validation
    func isEmailValid(_ emailString: String, showAlert: Bool = true) -> Bool{
        let regExPattern = "^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", argumentArray: [regExPattern])
        if !emailTest.evaluate(with: emailString) && showAlert {
            showMessage(title: "Error".localized, sub: "Please, Insert Email Correctly".localized
                , type: .error, layout: .messageView)
            
        }
        return emailTest.evaluate(with: emailString)
    }
    
    func isNotEmptyString(text: String, withAlertMessage message: String) -> Bool{
        if text == ""{
            //            showAlertWithTitle(title: "Empty Field".localized, message: message, type: .error);
            showMessage(title: "Empty Field".localized, sub: message, type: .error, layout: .messageView)
            //                Vibration.error.vibrate()
            
            return false
        }else{
            return true
        }
    }

    func alertSkipLogin(){
        let alert = UIAlertController.init(title: "Warning".localized , message: "please login first".localized ,  preferredStyle: .alert)
        alert.view.tintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        
        
        
        let cancelAction = UIAlertAction.init(title: "Ok".localized, style: .cancel, handler: { (nil) in
            
            //            appDelegate.setRoot(storyBoard: .authentication, vc: .splash)
            
            
        })
        
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    //    func transparentNavBar() {
    //           self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    //           self.navigationController?.navigationBar.shadowImage = UIImage()
    //           self.navigationController?.navigationBar.isTranslucent = true
    //           self.navigationController?.view.backgroundColor = .clear
    //       }
    
    func setShadow(view : UIView , width : Int , height: Int , shadowRadius: CGFloat , shadowOpacity: Float , shadowColor: CGColor){
        // to make the shadow with rounded corners and offset shadow form the bottom
        view.layer.shadowColor = shadowColor
        view.layer.shadowOffset = CGSize(width: width, height: height)
        view.layer.shadowRadius = shadowRadius
        view.layer.shadowOpacity = shadowOpacity
        view.clipsToBounds = true
        view.layer.masksToBounds = false
    }
    enum Vibration {
        case error
        case success
        case warning
        case light
        case medium
        case heavy
        case selection
        case oldSchool
        func vibrate() {
            
            switch self {
            case .error:
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.error)
                
            case .success:
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
                
            case .warning:
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.warning)
                
            case .light:
                let generator = UIImpactFeedbackGenerator(style: .light)
                generator.impactOccurred()
                
            case .medium:
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.impactOccurred()
                
            case .heavy:
                let generator = UIImpactFeedbackGenerator(style: .heavy)
                generator.impactOccurred()
                
            case .selection:
                let generator = UISelectionFeedbackGenerator()
                generator.selectionChanged()
                
            case .oldSchool:
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
            
        }
        
    }
    //    func showAlertWithTitle(title: String, message: String, type: ISAlertType) {
    //        ISMessages.showCardAlert(withTitle: title, message: message, duration: 3.5, hideOnSwipe: true, hideOnTap: true, alertType: type, alertPosition: .top, didHide: nil)
    //        if type == .error{
    //            self.view.shake()
    //        }
    //    }
    func changeLanguage(storyBoard: String = "SideMenu", vcId: storyBoardVCIDs) {
        let transition: UIView.AnimationOptions = .transitionCrossDissolve
        
        if L102Language.currentAppleLanguage() == englishLang {
            L102Language.setAppleLAnguageTo(lang: arabicLang)
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        } else {
            L102Language.setAppleLAnguageTo(lang: englishLang)
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        
        let storyBoard: UIStoryboard = UIStoryboard.init(name: storyBoard, bundle: nil)
        
        
        let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
        rootviewcontroller.rootViewController = storyBoard.instantiateViewController(withIdentifier: vcId.rawValue)
        let mainwindow = (UIApplication.shared.delegate?.window!)!
        mainwindow.backgroundColor = UIColor(hue: 0.6477, saturation: 0.6314, brightness: 0.6077, alpha: 0.8)
        UIView.transition(with: mainwindow, duration: 0.55001, options: transition, animations: { () -> Void in
        }) { (finished) -> Void in
            
        }
    }
    func changeLanguage(toLanguage: String) {
        var transition: UIView.AnimationOptions?
        
        if toLanguage == "ar" {
            transition = UIView.AnimationOptions.transitionFlipFromLeft
            L102Language.setAppleLAnguageTo(lang: "ar")
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        } else {
            transition = UIView.AnimationOptions.transitionFlipFromRight
            L102Language.setAppleLAnguageTo(lang: "en")
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        
           
       // sceneDelegate.siRootChangeLanguage()
//        if #available(iOS 13.0, *) {
//            appDelegate.setRoot(storyBoard: .Main, vc: vcId)
//        } else {
//            appDelegate.setRoot(storyBoard: .Main, vc: vcId)
//        }

    }

    
    func performSegueTo(storyBoard: storyBoardName, vc: storyBoardVCIDs) {
        let sb = UIStoryboard(name: storyBoard.rawValue, bundle: nil)
        let vcNew = sb.instantiateViewController(withIdentifier: vc.rawValue)
        //        self.navigationController?.pushViewController(vcNew, animated: true)
        show(vcNew, sender: self)
        
    }

}
extension UIScreen {
    var minEdge: CGFloat {
        return UIScreen.main.bounds.minEdge
    }
}
extension CGRect {
    var minEdge: CGFloat {
        return min(width, height)
    }
}
extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}
extension UICollectionView {
    func reloadAnimation() {
        self.reloadData()
        self.layoutIfNeeded()
        
        let cells = self.visibleCells
        
        let tableViewHeight = self.bounds.size.height
        
        for (index,cell) in cells.enumerated() {
            
            if (index + 1 + index + 2 + index + 3 + 1 ) == 9 {
                cell.transform = CGAffineTransform(translationX:  -tableViewHeight * 0.5, y: tableViewHeight)
            } else {
                cell.transform = CGAffineTransform(translationX: tableViewHeight * 1.5, y: -tableViewHeight)
            }
        }
        var delayCounter = 0
        for cell in cells{
            UIView.animate(withDuration: 1.75, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
            
        }
    }
    
//    func reloadAnimationTwo() {
//        self.reloadData()
//        self.layoutIfNeeded()
//
//        let cells = self.visibleCells
//
//        let tableViewHeight = self.bounds.size.height
//        //
//        //           for (index,cell) in cells.enumerated() {
//        //
//        //               if (index + 1 + index + 2 + index + 3 + 1 ) == 9 {
//        //                   cell.transform = CGAffineTransform(translationX:  -tableViewHeight * 0.5, y: tableViewHeight)
//        //               } else {
//        //                   cell.transform = CGAffineTransform(translationX: tableViewHeight * 1.5, y: -tableViewHeight)
//        //               }
//        //           }
//        var delayCounter = 0
//        for cell in cells{
//            UIView.animate(withDuration: 5.0, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
//                //                let animation = AnimationType.from(direction: .bottom, offset: 100.0)
//                //                cell.animate(animations: [animation])
//
//                let fromAnimation = AnimationType.from(direction: .right, offset: 30.0)
//                let zoomAnimation = AnimationType.zoom(scale: 0.2)
//                let rotateAnimation = AnimationType.rotate(angle: CGFloat.pi/6)
//                UIView.animate(views: self.visibleCells,
//                               animations: [fromAnimation, zoomAnimation],
//                               duration: 0.5)
//
//            }, completion: nil)
//            delayCounter += 1
//
//        }
//    }
    
    func reloadAnimationSecond(){
        
        switch Int(arc4random_uniform(3)) {
        case 0:
            animateTable0()
            break
        case 1:
            animateTable1()
            break
        case 2 :
            animateTable2()
            break
            
        default:
            break
        }
        
    }
    
    func animateTable0(){
        self.reloadData()
        let cells = self.visibleCells
        let tableViewHeight = self.bounds.size.height
        for cell in cells{
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        var delayCounter = 0
        for cell in cells{
            
            UIView.animate(withDuration: 1.75, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
            
        }
        
    }
    func animateTable1(){
        self.reloadData()
        let cells = self.visibleCells
        let tableViewHeight = self.bounds.size.height
        
        for (index, cell) in cells.enumerated() {
            if index % 2 == 0 {
                cell.transform = CGAffineTransform(translationX: 1000, y: tableViewHeight)
            } else {
                cell.transform = CGAffineTransform(translationX: -1000, y: tableViewHeight)
            }
        }
        var delayCounter = 0
        for cell in cells{
            
            UIView.animate(withDuration: 1.75, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }
    
    
    func animateTable2(){
        self.reloadData()
        let cells = self.visibleCells
        let tableViewHeight = self.bounds.size.height
        for cell in cells{
            cell.transform = CGAffineTransform(translationX: -1000, y: tableViewHeight)
        }
        var delayCounter = 0
        for cell in cells{
            
            UIView.animate(withDuration: 1.75, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
            
        }
    }
    
    
    //       func scrollToBottom(){
    //
    //           DispatchQueue.main.async {
    //               let indexPath = IndexPath(
    //                   row: self.numberOfRows(inSection:  self.numberOfSections - 1 ) - 1,
    //                   section: self.numberOfSections - 1)
    //               self.scrollToRow(at: indexPath, at: .bottom, animated: true)
    //           }
    //       }
    //       func scrollToTop() {
    //
    //           DispatchQueue.main.async {
    //               let indexPath = IndexPath(row: 0, section: 0)
    //               self.scrollToRow(at: indexPath, at: .top, animated: false)
    //           }
    //       }
}
extension UITableView {
    
    func reloadAnimation(){
        
        switch Int(arc4random_uniform(3)) {
        case 0:
            animateTable0()
            break
        case 1:
            animateTable1()
            break
        case 2 :
            animateTable2()
            break
            
        default:
            break
        }
        
    }
    
    func animateTable0(){
        self.reloadData()
        let cells = self.visibleCells
        let tableViewHeight = self.bounds.size.height
        for cell in cells{
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        var delayCounter = 0
        for cell in cells{
            
            UIView.animate(withDuration: 1.75, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
            
        }
        
    }
    func animateTable1(){
        self.reloadData()
        let cells = self.visibleCells
        let tableViewHeight = self.bounds.size.height
        
        for (index, cell) in cells.enumerated() {
            if index % 2 == 0 {
                cell.transform = CGAffineTransform(translationX: 1000, y: tableViewHeight)
            } else {
                cell.transform = CGAffineTransform(translationX: -1000, y: tableViewHeight)
            }
        }
        var delayCounter = 0
        for cell in cells{
            
            UIView.animate(withDuration: 1.75, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }
    
    
    func animateTable2(){
        self.reloadData()
        let cells = self.visibleCells
        let tableViewHeight = self.bounds.size.height
        for cell in cells{
            cell.transform = CGAffineTransform(translationX: -1000, y: tableViewHeight)
        }
        var delayCounter = 0
        for cell in cells{
            
            UIView.animate(withDuration: 1.75, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
            
        }
    }
    
    func scrollToBottom(){
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection:  self.numberOfSections - 1 ) - 1,
                section: self.numberOfSections - 1)
            self.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    func scrollToTop() {
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            self.scrollToRow(at: indexPath, at: .top, animated: false)
        }
    }
    
}
extension UIView {
    func shake() {
        self.transform = CGAffineTransform(translationX: 20, y: 0)
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}
