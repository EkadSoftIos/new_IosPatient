//
//  Extensions.swift
//  Zaid
//
//  Created by Ahlam on 1/9/19.
//  Copyright © 2019 ahlam. All rights reserved.
//
import Foundation
import UIKit

var _maxLengths_field = [UITextField: Int]()


extension UIView{
    func addDashedLineBorder(Color:UIColor,width:Int,height:Int,cornerRadius:Float) {
        let color = Color.cgColor
        let shapeLayer:CAShapeLayer = CAShapeLayer()
       // let frameSize = (self.frame.size)
        let shapeRect = CGRect(x: 0, y: 0, width: width,height: height)
        let path = UIBezierPath(roundedRect: shapeRect, cornerRadius: CGFloat(cornerRadius))
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x:width/2, y:height/2)
        shapeLayer.cornerRadius = 10
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 1.5
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.path = path.cgPath
        shapeLayer.lineDashPattern = [4,4]
        // shapeLayer.path = UIBezierPath(rect: shapeRect).cgPath
        self.layer.addSublayer(shapeLayer)
    }
//    func setupShadowView(cornerRadius: CGFloat, shadowRadius: CGFloat, shadowColor: CGColor, shadowOpacity: Float, shadowOffset: CGSize, borderwidth: CGFloat, borderColor: CGColor){
//      self.layer.cornerRadius = cornerRadius
//      self.layer.shadowRadius = shadowRadius
//      self.layer.shadowColor = shadowColor
//      self.layer.shadowOpacity = shadowOpacity
//      self.layer.shadowOffset = shadowOffset
//      self.layer.borderWidth = borderwidth
//      self.layer.borderColor = borderColor
//    }
    func addDashedLineBorder(Color:UIColor,cornerRadius:Float) {
        let color = Color.cgColor
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = (self.frame.size)
        let shapeRect = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        let path = UIBezierPath(roundedRect: shapeRect, cornerRadius: CGFloat(cornerRadius))
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
      //  shapeLayer.cornerRadius = 10
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 1
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.path = path.cgPath
        shapeLayer.lineDashPattern = [2,2]
        // shapeLayer.path = UIBezierPath(rect: shapeRect).cgPath
        self.layer.addSublayer(shapeLayer)
    }
    
}
extension UITextField{
    func dismissKeyboard(){
//        let tap = UITapGestureRecognizer(target:self,action:#selector(handleTab))
//        self.addGestureRecognizer(tap)
//        //let invocation = IQInvocation(self, #selector(didPressOnDoneButton))
//        self.resignFirstResponder()
//        //or
//        //self.view.endEditing(true)
//        self.endEditing(true)
        
    }
    
    @objc func handleTab(){
        
        self.endEditing(true)
    }
    func addImageAtEnd(imageName:String){
//        self.leftViewMode = UITextField.ViewMode.always
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
//        let image = UIImage(named: imageName)
//        imageView.image = image
//        self.leftView = imageView
        
        let iconView = UIImageView(frame:
            CGRect(x: 10, y: 15, width: 5, height: 5))
        iconView.image = UIImage(named: imageName)
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 0, y: 0, width: 10, height: 10))
        iconContainerView.addSubview(iconView)
        self.leftView  = iconContainerView
        self.leftViewMode  = .always
    }
    func addImageAtStart(imageName:String){
//        self.rightViewMode = UITextField.ViewMode.always
//        let imageView = UIImageView(frame: CGRect(x: 10, y: 5, width: 5, height: 5))
//        let image = UIImage(named: imageName)
//        imageView.image = image
//      //  self.rightView?.bottomAnchor.constraint(equalTo: self.imageView).
//        self.rightView = imageView
//
        if Language.currentLanguage() == englishLang {
            addImageAtEnd(imageName: imageName)
        }
        else{
            let iconView = UIImageView(frame:
                CGRect(x: 10, y: 15, width: 5, height: 5))
            iconView.image = UIImage(named: imageName)
            let iconContainerView: UIView = UIView(frame:
                CGRect(x: 0, y: 0, width: 10, height: 10))
            iconContainerView.addSubview(iconView)
            self.rightView  = iconContainerView
            self.rightViewMode  = .always
        }
      
        
    }
    
     
    @IBInspectable var maxLength: Int {
        get {
            guard let l = _maxLengths_field[self] else {
               return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            _maxLengths_field[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(textField: UITextField) {
        let t = textField.text ?? ""
        let sub = t.prefix(maxLength)
        textField.text = String(sub)
    }
    
    
   

    
}




//extension UIViewController {
//    func hideKeyboardWhenTappedAround() {
//        let tap: UITapGestureRecognizer =     UITapGestureRecognizer(target: self, action:    #selector(UIViewController.dismissKeyboard))
//        tap.cancelsTouchesInView = false
//        view.addGestureRecognizer(tap)
//    }
//    @objc func dismissKeyboard() {
//        view.endEditing(true)
//    }
//}
extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    
    func changeDateFormatString(dateFormatFrom: String,dateFormatTo: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormatFrom
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = dateFormatTo
        let dateString = dateFormatter.string(from: date ?? Date())
        return dateString
    }

    
    func removeHtmlTags() -> String{
        var escapedString = self.replacingOccurrences(of: " \\ \"\"  ", with: "")
        escapedString = escapedString.replacingOccurrences(of: "/", with: "")
        let regex = try! NSRegularExpression(pattern: "<[^>]+>", options: .caseInsensitive)
        
        let range = NSMakeRange(0, escapedString.count)
        var modString:String = regex.stringByReplacingMatches(in: escapedString, options: [], range: range, withTemplate: "")
        
        
         modString = modString.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)

        return modString

    }
    
    
    class TagCleaningRegex: NSRegularExpression {
        override func replacementString(for result: NSTextCheckingResult, in string: String, offset: Int, template templ: String) -> String {
            print(string[Range(result.range, in: string)!])
            if
                result.numberOfRanges >= 4,
                case let attrRng = result.range(at: 2),
                attrRng.location != NSNotFound,
                attrRng.length != 0
            {
                let tagStart = string[Range(result.range(at: 1), in: string)!]
                let tagEnd = string[Range(result.range(at: 3), in: string)!]
                return "\(tagStart)\(tagEnd)"
            } else {
                return super.replacementString(for: result, in: string, offset: offset, template: templ)
            }
        }
    }
    
  
    
        public var replacedArabicDigitsWithEnglish: String {
            var str = self
            let map = ["٠": "0",
                       "١": "1",
                       "٢": "2",
                       "٣": "3",
                       "٤": "4",
                       "٥": "5",
                       "٦": "6",
                       "٧": "7",
                       "٨": "8",
                       "٩": "9"]
            map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
            return str
        }
    
    func getNormalStringDate() -> String{
        var date = self.toDate()
        if(date == nil){
            date = self.toDate(withFormat: "yyyy-MM-dd'T'HH:mm:ss")
        }
        return date?.getNormalDateDescripted() ?? ""
        
        
        
    }
    
    func toDate(withFormat format: String = "yyyy-MM-dd'T'HH:mm:ss.SSS") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        guard let date = dateFormatter.date(from: self) else {
            return nil
            //preconditionFailure("Take a look to your format")
        }
        return date
    }
    
    
    
    //----------------------------------------------------------------------
    //MARK:- Validited special character
    
    func hasSpecialCharacters() -> Bool {
        
        do {
            let regex = try NSRegularExpression(pattern: ".*[^A-Za-z0-9\\u0621-\\u064A\\u0660-\\u0669 ].*", options: .caseInsensitive)
            if let _ = regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, self.count)) {
                return true
            }
            
        } catch {
            debugPrint(error.localizedDescription)
            return false
        }
        
        return false
    }
}

extension Foundation.Date{
    
    var localizedDescription: String{
        return description(with: .current)
    }
    
    func getDatTime() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let dateSTring = dateFormatter.string(from: self)
        return dateSTring
       
    }
    func getNormalDateDescripted() -> String{
        let dateFormatterForText = DateFormatter()
        //        dateFormatterForText.locale = Locale(identifier: "ar")
        //        dateFormatterForText.timeZone = TimeZone.current
        dateFormatterForText.locale = Locale(identifier: "ar")
        //        dateFormatterForText.timeZone = TimeZone(abbreviation: "GMT+0:00")
        //        dateFormatterForText.dateFormat = "EEEE, MMM d, yyyy"
        dateFormatterForText.dateFormat = "yyyy-MM-dd"
        let dateSTringForText = dateFormatterForText.string(from: self)
        return dateSTringForText
    }
    func getNormalDate() -> String{
        let dateFormatterForText = DateFormatter()
//        dateFormatterForText.locale = Locale(identifier: "ar")
//        dateFormatterForText.timeZone = TimeZone.current
        dateFormatterForText.locale = Locale(identifier: "ar")
//        dateFormatterForText.timeZone = TimeZone(abbreviation: "GMT+0:00")
//        dateFormatterForText.dateFormat = "EEEE, MMM d, yyyy"
        dateFormatterForText.dateFormat = "dd-MM-yyyy"
       // "yyyy-MM-dd"
        let dateSTringForText = dateFormatterForText.string(from: self)
        return dateSTringForText.replacedArabicDigitsWithEnglish
    }
//    func getNormatdate() -> Date{
//        let isoDate = "2016-04-14T10:44:00+0000"
//        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
//        let date = dateFormatter.date(from:isoDate)!
//    }
    
    
    
}
//extension UILabel {
//    
//    var defaultFontName : String {
//        get { return self.font.fontName }
//        set { self.font = UIFont(name: newValue, size: self.font.pointSize) }
//    }
//}

extension UIView{
    
    func setCornerRadius(radius:CGFloat){
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func setBottomCornerRadius(radius:CGFloat){
        self.frame =  CGRect(x: self.bounds.minX, y: self.bounds.minY
            , width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.3)
        self.roundCorner(corners: [.bottomLeft, .bottomRight], radius: radius)
    }
  
    func roundCorner(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
        
    }
        func dropShadow(scale: Bool = true) {
            layer.masksToBounds = false
            layer.shadowColor = UIColor.lightGray.cgColor
            layer.shadowOpacity = 3
            layer.shadowOffset = .zero
            layer.shadowRadius = 2
            
            layer.shouldRasterize = true
            layer.rasterizationScale = scale ? UIScreen.main.scale : 1
        }
    
    
  
    
}

extension UIButton {
    func centerTextAndImage(spacing: CGFloat) {
        let insetAmount = spacing / 2
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
    } 
    func setupBtnView(cornerRadius: CGFloat, shadowRadius: CGFloat, shadowColor: CGColor, shadowOpacity: Float, shadowOffset: CGSize, borderwidth: CGFloat, borderColor: CGColor){
      self.layer.cornerRadius = cornerRadius
      self.layer.shadowRadius = shadowRadius
      self.layer.shadowColor = shadowColor
      self.layer.shadowOpacity = shadowOpacity
      self.layer.shadowOffset = shadowOffset
      self.layer.borderWidth = borderwidth
      self.layer.borderColor = borderColor
    }
}
extension UIApplication {
    class var topViewController: UIViewController? { return getTopViewController() }
    private class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController { return getTopViewController(base: nav.visibleViewController) }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController { return getTopViewController(base: selected) }
        }
        if let presented = base?.presentedViewController { return getTopViewController(base: presented) }
        return base
    }
}

extension Hashable {
    func share() {
        let activity = UIActivityViewController(activityItems: [self], applicationActivities: nil)
        UIApplication.topViewController?.present(activity, animated: true, completion: nil)
    }
}

import UIKit

extension Date {
    
    func convertDateToString(dateFormat: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let date = dateFormatter.string(from: self)
        return date
    }
    
    
    
    func currentDateWithCustomFormatter(dateFormat: String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let stringDate = dateFormatter.string(from: self)
        let date = dateFormatter.date(from: stringDate)
        return date ?? self
    }
    
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
            return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
        }
    
   
}
