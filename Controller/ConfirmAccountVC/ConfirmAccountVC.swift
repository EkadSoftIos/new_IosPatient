//
//  ConfirmAccountVC.swift
//  E4 Patient
//
//  Created by mohab on 17/01/2021.
//

import UIKit
import TransitionButton

class ConfirmAccountVC: UIViewController {
    @IBOutlet var mainView: UIView!
    @IBOutlet var code1Txt: UITextField!
    @IBOutlet var code2Txt: UITextField!
    @IBOutlet var code3Txt: UITextField!
    @IBOutlet var code4Txt: UITextField!
//    @IBOutlet var code5Txt: UITextField!
//    @IBOutlet var code6Txt: UITextField!
    @IBOutlet weak var confirmAccountButton: TransitionButton!
    @IBOutlet weak var resendButton: UIButton!
    @IBOutlet var confirmAccountLbl: UILabel!
    var codeMessage: String?
    var email: String?
    var phone: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.ShadowView(view: mainView, radius: 20, opacity: 0.4, shadowRadius: 4, color: UIColor.black.cgColor)
        setUpText()
        confirmAccountLbl.text = "We've sent you a 4 digits confirm code to your Email \(email ?? "") Please enter it below"
    }
    func setUpText(){
        code1Txt.delegate = self
        code2Txt.delegate = self
        code3Txt.delegate = self
        code4Txt.delegate = self
//        code5Txt.delegate = self
//        code6Txt.delegate = self
    }
    @IBAction func goHome_CLick(_ sender: Any) {
        validateCode()
        
    }
    func validateCode (){
//        if code1Txt.text!.isEmpty || code2Txt.text!.isEmpty || code3Txt.text!.isEmpty || code4Txt.text!.isEmpty || code5Txt.text!.isEmpty || code6Txt.text!.isEmpty {
            if code1Txt.text!.isEmpty || code2Txt.text!.isEmpty || code3Txt.text!.isEmpty || code4Txt.text!.isEmpty {
            self.showMessage(title: "", sub: "enter valid code".localized, type: .error, layout: .messageView)
        }else{
            self.confirmAccountButton.startAnimation()
            callAPI()
        }
    }
    func callAPI(){
//        if codeMessage == "\(code1Txt.text!)\(code2Txt.text!)\(code3Txt.text!)\(code4Txt.text!)\(code5Txt.text!)\(code6Txt.text!)" {
        if codeMessage == "\(code1Txt.text!)\(code2Txt.text!)\(code3Txt.text!)\(code4Txt.text!)" {
            let parameters: [String: Any] = [
                
                "email": email ?? "",
                "code":"\(code1Txt.text!)\(code2Txt.text!)\(code3Txt.text!)\(code4Txt.text!)"
            ]
            NetworkClient.performRequest(_type: SuccessModel.self, router: .codeVerfication(params: parameters)) {[weak self] (result) in
                guard let self = self else {return}
                self.confirmAccountButton.stopAnimation()
                
                switch result{
                case .success(let model):
                    print("\(model)")
                    if model.successtate == 200 {
                        let vc = LoginVC()
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true, completion: nil)
                        self.showMessage(title: "", sub: "Your Acc created successfully".localized, type: .success, layout: .messageView)
                    }
                    else{
                        self.showMessage(title: "", sub: model.errormessage, type: .error, layout: .messageView)
                    }
                    
                case .failure(let model):
                    print("failure: \(model)")
                }
            }
            
        }
        else {
            self.showMessage(title: "", sub: "enter valid code".localized, type: .error, layout: .messageView)
        }
    }
    @IBAction func resend_Click(_ sender: Any) {
        self.showMessage(title: "", sub: "code send to your phone", type: .info, layout: .messageView)
    }
    
    
}
