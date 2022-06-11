//
//  ProfileDataPopUpVC.swift
//  E4 Patient
//
//  Created by mohab on 18/01/2021.
//

import UIKit

class ProfileDataPopUpVC: UIViewController {
    @IBOutlet var blurView: UIView!
    @IBOutlet var addressLbl: UILabel!
    @IBOutlet var insuranceLbl: UILabel!
    @IBOutlet var contactLbl: UILabel!
    @IBOutlet var dieseasesLbl: UILabel!
    @IBOutlet var medicationsLbl: UILabel!
    @IBOutlet var allergiesLbl: UILabel!
    @IBOutlet var socialHistoryLbl: UILabel!
    @IBOutlet var familyHistoryLbl: UILabel!
    @IBOutlet var surgeryLbl: UILabel!
    @IBOutlet var medicalReportsLbl: UILabel!
    @IBOutlet var progressLbl: UILabel!
    @IBOutlet var progressView: UIProgressView!
    var model: ProfilepercentageList?
    var progress: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.AddBlurEffect(BlurView: self.blurView)
        setData()
        setupSwipe()
    }
    func setData(){
        addressLbl.text = "\(model?.address ?? "") %"
        contactLbl.text = "\(model?.contact ?? "") %"
        dieseasesLbl.text = "\(model?.disease ?? "") %"
        medicationsLbl.text = "\(model?.medicine ?? "") %"
        allergiesLbl.text = "\(model?.allergies ?? "") %"
        socialHistoryLbl.text = "\(model?.socialHistory ?? "") %"
        familyHistoryLbl.text = "\(model?.socialFamily ?? "") %"
        medicalReportsLbl.text = "\(model?.medicine ?? "") %"
        insuranceLbl.text = "0%"
        surgeryLbl.text = "0%"
        contactLbl.text = "\(model?.contact ?? "") %"
        let Percentage = Int(progress ?? "")
        let resultProgress = Float(Percentage ?? 0) / 100.0
        progressLbl.text = "\(progress ?? "") %"
        progressView.progress = resultProgress
        
        
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

    func setupSwipe(){
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
    }
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == .right || gesture.direction == .left || gesture.direction == .up || gesture.direction == .down{
            self.dismiss(animated: false, completion: nil)
        }
    }
    @IBAction func dismiss_Click(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
