//
//  DefultLocationVC.swift
//  E4 Patient
//
//  Created by mohab on 19/01/2021.
//

import UIKit
import TransitionButton
class DeleteMedicalReportVC: UIViewController {
    @IBOutlet var blurView: UIView!
    @IBOutlet var yesBtn: TransitionButton!
    @IBOutlet var addressLbl: UILabel!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var yesBTN: UIButton!
    @IBOutlet var noBTN: UIButton!

    var id: Int = 0
    var Delegete: DeleteMedicalReports?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.AddBlurEffect(BlurView: self.blurView)
            addressLbl.text = "Are you want to Delete this medical report ?".localized
        titleLbl.text = "Delete Medical Report".localized
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
    func callApiDelete(Id: Int){
        
        NetworkClient.performRequest(_type: SuccessModel.self, router: .deleteMedical(id: Id)) { (result) in
            showUniversalLoadingView(false)
            switch result{
            case .success(let model):
                if model.successtate == 200{
                    self.Delegete?.Data(isAdded: true)
                    self.dismiss(animated: true, completion: nil)
                    self.showMessage(sub: "Medical report has been removed from list".localized)

                }else{
                    self.showMessage(title: "", sub: model.errormessage, type: .error, layout: .messageView)
                }
            case .failure(let model):
                print("failure: \(model)")
            
            }
        }
    }

    @IBAction func yes_Click(_ sender: Any) {
        self.yesBtn.startAnimation()
        callApiDelete(Id: id)
    }
    @IBAction func no_Click(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
protocol DeleteMedicalReports {
    func Data(isAdded: Bool)
}
