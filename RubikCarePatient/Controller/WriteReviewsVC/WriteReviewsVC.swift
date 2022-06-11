//
//  WriteReviewsVC.swift
//  E4 Patient
//
//  Created by mohab on 09/05/2021.
//

import UIKit
import Cosmos

class WriteReviewsVC: UIViewController {
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var giveArateLBL: UILabel!
    @IBOutlet weak var doctorRatingLBL: UILabel!
    @IBOutlet weak var doctorCosmosView: CosmosView!
    @IBOutlet weak var assistantRatingLBL: UILabel!
    @IBOutlet weak var assistantCosmosView: CosmosView!
    @IBOutlet weak var clinicRatingLBL: UILabel!
    @IBOutlet weak var clinicCosmosView: CosmosView!
    @IBOutlet weak var writeReviewLBL: UILabel!
    @IBOutlet weak var writeReviewTXT: UITextView!
    @IBOutlet weak var saveBTN: UIButton!
    var ratingDoctorValue = 0
    var ratingAssistantValue = 0
    var ratingClinicValue = 0
    var bookingFK = 0
    var doctorFK = 0
    var patientReviewId = 0
    var successRateSent = ""{
        didSet{
            self.navigationController?.popViewController(animated: true)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Write Reviews".localized
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColor.Blue]
        saveBTN.setTitle("Save", for: .normal)
        giveArateLBL.text = "Give a rate"
        doctorRatingLBL.text = "Doctor Rating"
        assistantRatingLBL.text = "Assistant Rating"
        clinicRatingLBL.text = "Clinic Rating"
        writeReviewLBL.text = "Write Reviews".localized
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.ShadowView(view: mainView, radius: 10, opacity: 2, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        doctorCosmosView.didTouchCosmos = didTouchdoctorCosmos
        doctorCosmosView.didFinishTouchingCosmos = didFinishTouchingDoctorCosmos
        assistantCosmosView.didTouchCosmos = didTouchAssistantCosmos
        assistantCosmosView.didFinishTouchingCosmos = didFinishTouchingAssistantCosmos
        clinicCosmosView.didTouchCosmos = didTouchClinicCosmos
        clinicCosmosView.didFinishTouchingCosmos = didFinishTouchingClinicCosmos
    }
    //Doctor
    private func didTouchdoctorCosmos(_ rating: Double) {
        ratingDoctorValue = Int(Float(rating))
        updateDoctorRating(requiredRating: rating)
    }
    
    private func didFinishTouchingDoctorCosmos(_ rating: Double) {
        ratingDoctorValue = Int(Float(rating))
        
    }
    private func updateDoctorRating(requiredRating: Double?) {
    var newRatingValue: Double = 0
    if let nonEmptyRequiredRating = requiredRating {
        newRatingValue = nonEmptyRequiredRating
    } else {
        newRatingValue = Double(ratingDoctorValue)
    }
        
    doctorCosmosView.rating = newRatingValue
  }
    //Assistant
    private func didTouchAssistantCosmos(_ rating: Double) {
        ratingAssistantValue = Int(Float(rating))
        updateAssistantRating(requiredRating: rating)
    }
    
    private func didFinishTouchingAssistantCosmos(_ rating: Double) {
        ratingAssistantValue = Int(Float(rating))
        
    }
    private func updateAssistantRating(requiredRating: Double?) {
    var newRatingValue: Double = 0
    if let nonEmptyRequiredRating = requiredRating {
        newRatingValue = nonEmptyRequiredRating
    } else {
        newRatingValue = Double(ratingAssistantValue)
    }
        
    assistantCosmosView.rating = newRatingValue
  }
    //Clinic
    private func didTouchClinicCosmos(_ rating: Double) {
        ratingClinicValue = Int(Float(rating))
        updateClinicRating(requiredRating: rating)
    }
    
    private func didFinishTouchingClinicCosmos(_ rating: Double) {
        ratingClinicValue = Int(Float(rating))
        
    }
    private func updateClinicRating(requiredRating: Double?) {
    var newRatingValue: Double = 0
    if let nonEmptyRequiredRating = requiredRating {
        newRatingValue = nonEmptyRequiredRating
    } else {
        newRatingValue = Double(ratingAssistantValue)
    }
        
    clinicCosmosView.rating = newRatingValue
  }
    @IBAction func saveCLikc(_ sender: Any) {
        callApi()
    }
    
}
