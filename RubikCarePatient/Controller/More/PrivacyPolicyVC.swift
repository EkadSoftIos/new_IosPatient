//
//  PrivacyPolicyVC.swift
//  E4 Patient
//
//  Created by Nada on 2/28/22.
//

import UIKit

class PrivacyPolicyVC: UIViewController {
    
    var data: String? {
        didSet {
            print(data)
        }
    }
    
    @IBOutlet weak var privacyDataLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Privacy Policy & Terms of Use"
        privacyDataLbl?.text = data?.html2String ?? ""
    }
    

}

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String { html2AttributedString?.string ?? "" }
}

extension StringProtocol {
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}
