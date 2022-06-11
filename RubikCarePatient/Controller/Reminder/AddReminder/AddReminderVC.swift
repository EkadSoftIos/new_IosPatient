//
//  AddReminderVC.swift
//  E4 Patient
//
//  Created by Ahmed Kassem on 23/05/2022.
//

import UIKit

class AddReminderVC: UIViewController {

    @IBOutlet weak var toView: UIView!
    @IBOutlet weak var fromView: UIView!
    @IBOutlet weak var startTimeView: UIView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var instructionTextView: UITextView!
    @IBOutlet weak var saveBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func didTappedsave(_ sender: Any) {
        
    }
}

//MARK: - Setup View
extension AddReminderVC {
    fileprivate func setupUI() {
        self.title = "Set Reminder"
        saveBtn.layer.cornerRadius = 11
        instructionTextView.layer.cornerRadius = 11
        instructionTextView.layer.borderWidth = 1
        instructionTextView.layer.borderColor = UIColor.lightGray.cgColor
        bgView.ShadowView(view: bgView, radius: 10, opacity: 0.4, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        setupViews(view: toView)
        setupViews(view: fromView)
        setupViews(view: startTimeView)
    }
    
    func setupViews(view: UIView) {
        view.layer.cornerRadius = 9
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
    }
}
