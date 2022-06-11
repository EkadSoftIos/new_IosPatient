//
//  ConfirmAccountVC.swift
//  E4 Patient
//
//  Created by mohab on 17/01/2021.
//

import UIKit
import TransitionButton
import SKCountryPicker


class ForgetPassVC: UIViewController {
    @IBOutlet var mainView: UIView!
    @IBOutlet var flagImage: UIImageView!
    @IBOutlet var counntryNameLbl: UILabel!
    @IBOutlet var phoneTxt: UITextField!
    @IBOutlet var titleLB: UILabel!
    @IBOutlet var bodyLB: UILabel!
    @IBOutlet var sendBT: TransitionButton!

    var codeMessage: String?
    var phone: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.ShadowView(view: mainView, radius: 20, opacity: 0.4, shadowRadius: 4, color: UIColor.black.cgColor)
    }

    @IBAction func goHome_CLick(_ sender: Any) {
        if phoneTxt.text == "" {
            self.showMessage(title: "", sub: "all data are required".localized, type: .error, layout: .messageView)
        }else{
            self.sendBT.startAnimation()
            callAPI()
        }
    }
    @IBAction func chooseCountry_Click(_ sender: Any) {
        let countryController = CountryPickerWithSectionViewController.presentController(on: self) { [weak self] (country: Country) in
          guard let self = self else { return }
          self.flagImage.image = country.flag
            self.counntryNameLbl.text = country.countryCode
            self.phoneTxt.placeholder = "\(country.dialingCode ?? "")\(" 000 00000 000")"
        }
//        countryController.detailColor = UIColor.blue
    }
    func callAPI(){
            let parameters: [String: Any] = [
                
                "Mobile": phoneTxt.text ?? "",
                "Type":2
            ]
            NetworkClient.performRequest(_type: ForgotPasswordModel.self, router: .forgetPass(params: parameters)) {[weak self] (result) in
                guard let self = self else {return}
                self.sendBT.stopAnimation()
                
                switch result{
                case .success(let model):
                    print("\(model)")
                    if model.successtate == 200 {
                        let vc = ConfirmAccountVC()
                        vc.modalPresentationStyle = .fullScreen
                        vc.codeMessage = model.message?.tokencode
                        vc.phone = self.phoneTxt.text!
                        self.present(vc, animated: true, completion: nil)
                    }
                    else{
                        self.showMessage(title: "", sub: model.errormessage, type: .error, layout: .messageView)
                    }
                    
                case .failure(let model):
                    print("failure: \(model)")
                }
            }
    }

    
    
}
