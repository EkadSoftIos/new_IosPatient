//
//  ContactUsVC.swift
//  E4 Patient
//
//  Created by Nada on 2/28/22.
//

import UIKit

class ContactUsVC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var MessageTextView: UITextView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Contact Us".localized
        MessageTextView.delegate = self
        saveBtn.layer.cornerRadius = 11
        MessageTextView.layer.cornerRadius = 11
        MessageTextView.layer.borderWidth = 1
        MessageTextView.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Message" {
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Message"
        }
    }
    
    @IBAction func didTappedSaveBtn(_ sender: Any) {
        guard let name = nameTF.text, !name.isEmpty else {
            self.showMessage(title: "", sub: "Enter Name", type: .error, layout: .messageView)
            return
        }
        guard let mobile = mobileTF.text, !mobile.isEmpty else {
            self.showMessage(title: "", sub: "Enter Phone Number", type: .error, layout: .messageView)
            return
        }
        guard let email = nameTF.text, !email.isEmpty else {
            self.showMessage(title: "", sub: "Enter Email", type: .error, layout: .messageView)
            return
        }
        if MessageTextView.text == "" || MessageTextView.text == "Message" {
            self.showMessage(title: "", sub: "Enter Message", type: .error, layout: .messageView)
            return
        }
        
        showUniversalLoadingView(true)
        
        let para: [String: Any] =
        ["InqueryText": MessageTextView.text ?? "", "SenderEmail": email, "SenderMobile": mobile, "SenderName": name]
        
        NetworkClient.performRequest(_type: ContactUsModel.self, router: .saveContactUs(params: para)) { result in
            showUniversalLoadingView(false)
            switch result{
            case .success(let model):
                print(model)
                if model.successtate == 200{
                    self.showMessage(title: "", sub: model.message ?? "", type: .error, layout: .messageView)
                    self.navigationController?.popViewController(animated: true)
                }else{

                }
            case .failure(let model):
                self.showMessage(title: "", sub: "error connecting to server. please try again", type: .error, layout: .messageView)
                print("failure: \(model)")
            
            }
        }
        
    }
    
}
