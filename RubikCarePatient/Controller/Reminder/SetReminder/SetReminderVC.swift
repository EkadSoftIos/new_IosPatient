//
//  SetReminderVC.swift
//  E4 Patient
//
//  Created by Ahmed Kassem on 23/05/2022.
//

import UIKit

class SetReminderVC: UIViewController {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var savebtn: UIButton!
    @IBOutlet weak var otherInstructionTextView: UITextView!
    @IBOutlet weak var toBG: UIView!
    @IBOutlet weak var fromBG: UIView!
    @IBOutlet weak var startTimeBG: UIView!
    @IBOutlet weak var medicineBG: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
    }
    
    @IBAction func didTappedSave(_ sender: Any) {
        
    }
    
}

//MARK: - Setup View
extension SetReminderVC {
    fileprivate func setupUI() {
        self.title = "Set Reminder"
        savebtn.layer.cornerRadius = 11
        otherInstructionTextView.layer.cornerRadius = 11
        otherInstructionTextView.layer.borderWidth = 1
        otherInstructionTextView.layer.borderColor = UIColor.lightGray.cgColor
        bgView.ShadowView(view: bgView, radius: 10, opacity: 0.4, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        medicineBG.ShadowView(view: medicineBG, radius: 10, opacity: 0.4, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        setupViews(view: toBG)
        setupViews(view: fromBG)
        setupViews(view: startTimeBG)
    }
    
    func setupViews(view: UIView) {
        view.layer.cornerRadius = 9
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
    }
}
