//
//  SuccessBookingVC.swift
//  E4 Patient
//
//  Created by mohab on 09/05/2021.
//

import UIKit

class SuccessBookingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { t in
        t.invalidate()
            self.dismiss(animated: true, completion: nil)
        }
    }



}
