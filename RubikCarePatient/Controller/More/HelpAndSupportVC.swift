//
//  HelpAndSupportVC.swift
//  E4 Patient
//
//  Created by Nada on 2/28/22.
//

import UIKit

class HelpAndSupportVC: UIViewController {
    
    var data: String?
    
    @IBOutlet weak var SupportDataLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Terms & Condition"
        SupportDataLbl?.text = data?.html2String ?? ""
    }

}
