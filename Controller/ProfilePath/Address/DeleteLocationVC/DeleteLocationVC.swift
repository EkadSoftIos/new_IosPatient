//
//  DefultLocationVC.swift
//  E4 Patient
//
//  Created by mohab on 19/01/2021.
//

import UIKit
import TransitionButton
class DeleteLocationVC: UIViewController {
    @IBOutlet var blurView: UIView!
    @IBOutlet var yesBtn: TransitionButton!
    @IBOutlet var addressLbl: UILabel!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var yesBTN: UIButton!
    @IBOutlet var noBTN: UIButton!

    var id: Int = 0
    var Delegete: DeleteLocation?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.AddBlurEffect(BlurView: self.blurView)
            addressLbl.text = "Are you want to Delete this address ?".localized
        titleLbl.text = "Delete Address".localized
        yesBTN.setTitle("Yes".localized, for: .normal)
        noBTN.setTitle("No".localized, for: .normal)

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
    func callApiDelete(id: Int){
        showUniversalLoadingView(true)
        
        let parameters: [String: Any] = [
            "PatientAddressId": id
          ]
        NetworkClient.performRequest(_type: SuccessModel.self, router: .deleteAdress(params: parameters)) {[weak self] (result) in
            guard let self = self else {return}
            showUniversalLoadingView(false)
            switch result{
            case .success(let model):
                if model.successtate == 200 {
                    self.Delegete?.Data(isAdded: true)
                    self.dismiss(animated: true, completion: nil)
                    //" تم حذف العنوان من القائمة "
                    self.showMessage(sub: "Address has been removed from list".localized)
                }
                else{
                    self.showAlertWith(msg: model.errormessage)
                }
            case .failure(let model):
              print(model)
            }
        }
    }
    @IBAction func yes_Click(_ sender: Any) {
        self.yesBtn.startAnimation()
        callApiDelete(id: id)
    }
    @IBAction func no_Click(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
protocol DeleteLocation {
    func Data(isAdded: Bool)
}
