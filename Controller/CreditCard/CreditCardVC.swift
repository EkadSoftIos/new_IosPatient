//
//  CreditCardVC.swift
//  E4 Patient
//
//  Created by Ahmed Kassem on 04/06/2022.
//

import UIKit

class CreditCardVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var securityCodeTF: UITextField!
    @IBOutlet weak var expireDateTF: UITextField!
    @IBOutlet weak var cardNumberTF: UITextField!
    @IBOutlet weak var cardNameTF: UITextField!
    @IBOutlet weak var amountTF: UITextField!
    @IBOutlet weak var bgView: UIView!
    
    var patientId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        expireDateTF.delegate = self
        
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .date
        expireDateTF.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        
        bgView.ShadowView(view: bgView, radius: 10, opacity: 0.4, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        doneBtn.layer.cornerRadius = 13
        view.backgroundColor = UIColor(white: 0, alpha: 0.65)
        
    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: sender.date)
        expireDateTF.text = date
    }

    @IBAction func didTappedDone(_ sender: Any) {
        chargeWallet()
    }
    
    @IBAction func didtappedBackBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func chargeWallet() {
        guard let amount = amountTF.text, !amount.isEmpty else {return}
        guard let expireDate = expireDateTF.text, !expireDate.isEmpty else {return}
        let para: [String: Any] =
        [
              "PatientFk": patientId ?? 0,
              "Amount": amount,
              "PaymentType": 2,
              "TransactionDate": expireDate,
              "IsActive": true
        ]
        showUniversalLoadingView(true)
        NetworkClient.performRequest(_type: ChargeWalletModel.self, router: .chargeWallet(params: para)) {[weak self] result in
            guard let self = self else {return}
            showUniversalLoadingView(false)
            switch result {
            case.success(let data):
                if data.successtate == 200 {
                    self.showMessage(title: "", sub: data.message ?? "", type: .success, layout: .messageView)
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.showMessage(title: "", sub: data.message ?? "", type: .error, layout: .messageView)
                }
            case.failure(let err):
                print(err)
                self.showMessage(title: "", sub: "error connecting to server. please try again", type: .error, layout: .messageView)
            }
        }
    }
}
