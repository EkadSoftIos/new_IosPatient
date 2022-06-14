//
//  ChangeLanguageVC.swift
//  E4Doctor
//
//  Created by mac on 17/01/2021.
//

import UIKit
 
class ChangeLanguageVC: UIViewController, ChangeLanguageViewProtocol {
    
    //MARK: - IBOutlets
    @IBOutlet private weak var englishLb: UIButton!
    @IBOutlet private weak var englishRadioButton: UIButton!
    @IBOutlet private weak var arabicLb: UIButton!
    @IBOutlet private weak var arabicRadioButton: UIButton!
    //MARK: - Properties
    var presenter: ChangeLanguagePresenterProtocol!
    private let unactiveButtonImage = UIImage(named: "ic_radio_unactive")
    private let activeButtonImage = UIImage(named: "ic_radio_active")
    private let unactiveTextColor = UIColor.lightGray
    private let activeTextColor = UIColor(named: "mainColor")
    private var englishIsSelected = true
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        }
    }
    
    func showLoadingIndicator() {
//        showLoader()
    }
    
    func hideLoadingIndicator() {
//        hideLoader()
    }
    
    func successRequest() {
        
    }
    
    func showMessage(message: String) {
        
    }
    
    //MARK: - IBOutlets
    @IBAction
    func didTappedEnglish(_ sender: UIButton) {
        didTappedEnglish()
    }
    
    @IBAction
    func didTappedArabic(_ sender: UIButton) {
        didTappedArabic()
    }
    
    @IBAction func didTappedCancel(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func didTappedDone(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
}

//MARK: Setup View
extension ChangeLanguageVC {
    
     fileprivate func setupUI() {
        setupLang()
     }
    
    fileprivate func setupLang(){
        arabicLb.setTitle("Arabic".localized, for: .normal)
//        arabicLb.titleLabel?.textAlignment = Helper.instance.appLang == "en" ? .left : .right
        englishLb.setTitle("English".localized, for: .normal)
//        englishLb.titleLabel?.textAlignment = Helper.instance.appLang == "en" ? .left : .right
    }
    
    
    
    
    fileprivate func didTappedEnglish(){
        animateButton(sender: englishRadioButton, senderTitle: englishLb)
        englishLb.setTitleColor(activeTextColor, for: .normal)
        arabicLb.setTitleColor(unactiveTextColor, for: .normal)
        arabicRadioButton.setImage(unactiveButtonImage, for: .normal)
        
    }
    
    fileprivate func didTappedArabic(){
        animateButton(sender: arabicRadioButton, senderTitle: arabicLb)
        englishLb.setTitleColor(unactiveTextColor, for: .normal)
        arabicLb.setTitleColor(activeTextColor, for: .normal)
        englishRadioButton.setImage(unactiveButtonImage, for: .normal)
        
    }
    
    fileprivate func animateButton(sender: UIButton, senderTitle: UIButton){
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
            let transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            sender.transform = transform
            senderTitle.transform = transform
        }) { _ in
            sender.isSelected = self.englishIsSelected
            UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
                sender.setImage(self.activeButtonImage, for: .normal)
                sender.transform = .identity
                senderTitle.transform = .identity
            }, completion: nil)
        }
    }
}

 
