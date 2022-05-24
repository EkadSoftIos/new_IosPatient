//
//  ReviewsVC.swift
//  E4 Patient
//
//  Created by mohab on 09/05/2021.
//

import UIKit
import Cosmos

class ReviewsVC: UIViewController, BaseViewProtocol {
    
    var doctorId: Int?
    var doctorReviewData: DoctorReviewsData? {
        didSet {
            let totalRate = doctorReviewData?.totalDoctorRate ?? 0.0
            let doctorRating = doctorReviewData?.totalDoctorRate ?? 0.0
            let assistantRating = doctorReviewData?.totalAssistantRate ?? 0.0
            let clinicRating = doctorReviewData?.totalClinicRate ?? 0.0
            
            totalRatingView.rating = Double(totalRate)
            doctorRatingView.rating = Double(doctorRating)
            assistantRatingView.rating = Double(assistantRating)
            clinicRatingView.rating = Double(clinicRating)
                
            totalRateLbl.text = "\(totalRate)"
            allVisitorCount.text = "From \(doctorReviewData?.totalpatients ?? 0) visitors"
            self.doctorRating.text = "\(doctorRating)"
            self.assistantRating.text = "\(assistantRating)"
            self.clinicRating.text = "\(clinicRating)"
        }
    }
    
    @IBOutlet weak var clinicRatingView: CosmosView!
    @IBOutlet weak var assistantRatingView: CosmosView!
    @IBOutlet weak var doctorRatingView: CosmosView!
    @IBOutlet weak var totalRatingView: CosmosView!
    
    @IBOutlet weak var clinicRating: UILabel!
    @IBOutlet weak var assistantRating: UILabel!
    @IBOutlet weak var doctorRating: UILabel!
    @IBOutlet weak var allVisitorCount: UILabel!
    @IBOutlet weak var totalRateLbl: UILabel!
    @IBOutlet var ratingView: UIView!
    @IBOutlet var rateTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Reviews".localized
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColor.Blue]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getDoctorReview()
        
        ratingView.ShadowView(view: ratingView, radius: 10, opacity: 0.3, shadowRadius: 3, color: UIColor.lightGray.cgColor)
        setupTableView()
    }
    
    func setupTableView(){
        rateTableView.register(ReviewsCell.nib, forCellReuseIdentifier: "ReviewsCell")
        rateTableView.delegate = self
        rateTableView.dataSource = self
        rateTableView.separatorStyle = .none
    }
    
    func getDoctorReview() {
        NetworkClient.performRequest(_type: DoctorReviewsModel.self, router: APIRouter.doctorreviews(id: doctorId ?? 0)) {[weak self] (result) in
            guard let self = self else {return}
            switch result {
            case.success(let data):
                self.doctorReviewData = data.message
                self.rateTableView.reloadData()
            case.failure(let err):
                print(err)
                self.showAlert(message: err.localizedDescription)
            }
        }
    }

  
}
