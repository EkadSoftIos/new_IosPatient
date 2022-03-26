//
//  DefultLocationVC.swift
//  E4 Patient
//
//  Created by mohab on 19/01/2021.
//

import UIKit
import TransitionButton
class DefultLocationVC: UIViewController {
    @IBOutlet var blurView: UIView!
    @IBOutlet var yesBtn: TransitionButton!
    @IBOutlet var addressLbl: UILabel!
    var id: Int = 0
    var Delegete: DefultLocation?
    var isMain: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.AddBlurEffect(BlurView: self.blurView)
        if isMain == false {
            isMain = true
            addressLbl.text = "Are you want to set this address a default?".localized
        }else{
            isMain = false
            addressLbl.text = "Are you want to Delete this address from default address?".localized
        }
    }
    
    func AddBlurEffect(BlurView: UIView){
        UIView.animate(withDuration: 0.6) {
        BlurView.backgroundColor = .clear

        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)

        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        BlurView.addSubview(blurEffectView)
        }
    }
    //MARK:- Call Api
    func callApi(){
        let parameters: [String: Any] = [
            "PatientAddressId": id,
            "IsMain": isMain
          ]
        NetworkClient.performRequest(_type: SuccessModel.self, router: .mainAddress(params: parameters)) { (result) in
            switch result{
            case .success(let model):
                self.yesBtn.stopAnimation()
                if model.successtate == 200{
                    self.Delegete?.Data(isAdded: true)
                    self.dismiss(animated: true, completion: nil)
                    self.showMessage(sub: "Success".localized)
                    
                }else{
                    self.yesBtn.stopAnimation()
                    Vibration.success.vibrate()
                    self.showMessage(title: "", sub: model.errormessage, type: .error, layout: .messageView)
                }
            case .failure(let model):
                self.yesBtn.stopAnimation()
                self.showMessage(title: "", sub: "error connecting to server. please try again", type: .error, layout: .messageView)
                print("failure: \(model)")
            
            }
        }
    }
    @IBAction func yes_Click(_ sender: Any) {
        self.yesBtn.startAnimation()
        callApi()
    }
    @IBAction func no_Click(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
protocol DefultLocation {
    func Data(isAdded: Bool)
}
