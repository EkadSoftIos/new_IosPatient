//
//  DefultLocationVC.swift
//  E4 Patient
//
//  Created by mohab on 19/01/2021.
//

import UIKit
import TransitionButton
class DeleteAllergiesVC: UIViewController {
    @IBOutlet var blurView: UIView!
    @IBOutlet var yesBtn: TransitionButton!
    @IBOutlet var addressLbl: UILabel!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var yesBTN: UIButton!
    @IBOutlet var noBTN: UIButton!

    var id: Int = 0
    var Delegete: DeleteAllergies?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.AddBlurEffect(BlurView: self.blurView)
            addressLbl.text = "Are you want to Delete this allergy ?".localized
        titleLbl.text = "Delete allergy".localized
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
    func callApiDelete(Id: Int){
        showUniversalLoadingView(true)
        NetworkClient.performRequest(_type: SuccessModel.self, router: .deleAllergies(Id: Id)) { (result) in
            showUniversalLoadingView(false)
            switch result{
            case .success(let model):
                if model.successtate == 200{
                    UserDefaults.standard.set(false, forKey: "AddedAllergies")
                    self.Delegete?.Data(isAdded: true)
                    self.dismiss(animated: true, completion: nil)
                    self.showMessage(sub: "Allergy has been removed from list".localized)
                }else{
                    self.showMessage(title: "", sub: model.errormessage, type: .error, layout: .messageView)
                }
            case .failure(let model):
                print("failure: \(model)")
            
            }
        }
    }
    //MARK:- Call Api


    @IBAction func yes_Click(_ sender: Any) {
        self.yesBtn.startAnimation()
        callApiDelete(Id: id)
    }
    @IBAction func no_Click(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
protocol DeleteAllergies {
    func Data(isAdded: Bool)
}
