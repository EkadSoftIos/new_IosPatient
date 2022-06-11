//
//  ShowAttachementImageVC.swift
//  E4 Patient
//
//  Created by Nada on 10/5/21.
//

import UIKit

class ShowAttachementImageVC: UIViewController {
    
    var imgPath: String?

    @IBOutlet weak var attachImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        attachImg.kf.setImage(with: URL(string: (imgPath ?? "")),placeholder: UIImage(named: "profile"))
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
