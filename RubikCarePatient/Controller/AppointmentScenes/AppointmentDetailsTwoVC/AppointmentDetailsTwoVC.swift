//
//  AppointmentDetailsTwoVC.swift
//  E4 Patient
//
//  Created by mohab on 09/05/2021.
//

import UIKit
import Cosmos

class AppointmentDetailsTwoVC: UIViewController {
    
    var doctorReviewData: DoctorReviewsData?{
        didSet {
            let totalRate = doctorReviewData?.totalRate ?? 0.0
            let doctorRating = doctorReviewData?.totalDoctorRate ?? 0
            let assistantRating = doctorReviewData?.totalAssistantRate ?? 0
            let clinicRating = doctorReviewData?.totalClinicRate ?? 0
            
            doctorCosmosView.rating = Double(doctorRating)
            assistantCosmosView.rating = Double(assistantRating)
            clinicCosmosView.rating = Double(clinicRating)
                
            self.doctorRateValueLBL.text = "\(doctorRating)"
            self.assistantRatingValueLBL.text = "\(assistantRating)"
            self.clinicRatingValueLBL.text = "\(clinicRating)"
        }
    }
    
    @IBOutlet var rateViewe: UIView!
    @IBOutlet var dataView: UIView!
    @IBOutlet weak var clinicIconIMG: UIImageView!
    @IBOutlet weak var clinicNameLBL: UILabel!
    @IBOutlet weak var yourAppointmentLBL: UILabel!
    @IBOutlet weak var dateLBL: UILabel!
    @IBOutlet weak var timeLBL: UILabel!
    @IBOutlet weak var branchAddressLBL: UILabel!
    @IBOutlet weak var branchAddressIcon: UIImageView!
    @IBOutlet weak var locationLBL: UILabel!
    @IBOutlet weak var totalFeesLBL: UILabel!
    @IBOutlet weak var withDoctorLBL: UILabel!
    @IBOutlet weak var doctorIMG: UIImageView!
    @IBOutlet weak var doctorNameLBL: UILabel!
    @IBOutlet weak var bookingStatusLBL: UILabel!
    @IBOutlet weak var paidLBL: UILabel!
    //15
    @IBOutlet weak var locationHeightConstraint: NSLayoutConstraint!
    //140
    @IBOutlet weak var historyHeightConstraint: NSLayoutConstraint!
    //310
    @IBOutlet weak var dataHeightConstraint: NSLayoutConstraint!
    //150
    @IBOutlet weak var resonHeigtConstraint: NSLayoutConstraint!
    @IBOutlet var reasonView: UIView!
    @IBOutlet weak var appointmentReasonTitleLBL: UILabel!
    @IBOutlet weak var appointmentReasonDescLBL: UILabel!
    @IBOutlet var historyView: UIView!
    @IBOutlet weak var viewHistoryTitleLBL: UILabel!
    @IBOutlet weak var viewHistoryDescLBL: UILabel!
    @IBOutlet weak var viewBTN: UIButton!
    
    @IBOutlet weak var doctorRateValueLBL: UILabel!
    @IBOutlet weak var doctorRatingLBL: UILabel!
    @IBOutlet weak var doctorCosmosView: CosmosView!
    
    @IBOutlet weak var assistantRatingValueLBL: UILabel!
    @IBOutlet weak var assistantCosmosView: CosmosView!
    @IBOutlet weak var assistantRatingLBL: UILabel!
    
    @IBOutlet weak var clinicRatingValueLBL: UILabel!
    @IBOutlet weak var clinicCosmosView: CosmosView!
    @IBOutlet weak var clinicRatingLBL: UILabel!
    
    @IBOutlet weak var userIMG: UIImageView!
    @IBOutlet weak var userNameLBL: UILabel!
    @IBOutlet weak var dateTimeLBL: UILabel!
    @IBOutlet weak var userDescLBL: UILabel!
    @IBOutlet weak var commentUserIMG: UIImageView!
    @IBOutlet weak var commentUserNameLBL: UILabel!
    @IBOutlet weak var timeDateCommentLBL: UILabel!
    @IBOutlet weak var commentedUserDesLBL: UILabel!
    var appointmentModel: AppointmentMessage?
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Appointment Details".localized
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColor.Blue]
        yourAppointmentLBL.text = "Your Appointment"
        withDoctorLBL.text = "With Doctor"
        appointmentReasonTitleLBL.text = "Appointment Reason"
        viewHistoryTitleLBL.text = "View History Appointment"
        SetData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getDoctorReview()
        
        dataView.ShadowView(view: dataView, radius: 10, opacity: 2, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        reasonView.ShadowView(view: reasonView, radius: 10, opacity: 2, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        historyView.ShadowView(view: historyView, radius: 10, opacity: 2, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        rateViewe.ShadowView(view: rateViewe, radius: 10, opacity: 2, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        doctorIMG.layer.cornerRadius = doctorIMG.frame.width / 2
        userIMG.layer.cornerRadius = doctorIMG.frame.width / 2
        commentUserIMG.layer.cornerRadius = doctorIMG.frame.width / 2
    }
    func SetData(){
        clinicNameLBL.text = self.appointmentModel?.consultationService_localized ?? ""
        if appointmentModel?.bookingStatus == 1 || appointmentModel?.bookingStatus == 0{
            //انتظار
            bookingStatusLBL.textColor = UIColor.orange
        }else if appointmentModel?.bookingStatus == 2 {
            //"تم القبول"
            bookingStatusLBL.textColor = UIColor.green
        }
        bookingStatusLBL.text = appointmentModel?.bookingStatusName ?? ""
        self.branchAddressLBL.text = "\(appointmentModel?.entityName_Localized ?? "")\(" ")\("(")\(appointmentModel?.branchName_Localized ?? "")\(")")"
        if appointmentModel?.consultationServiceFk == 1 {
            //"Clinic Consultations"
            clinicIconIMG.image = UIImage (named: "ic_clinic")
            locationLBL.text = appointmentModel?.branchAddress_Localized
            locationLBL.numberOfLines = 3
            locationLBL.sizeToFit()
            locationHeightConstraint.constant = 15
            dataHeightConstraint.constant = 310
        }else if appointmentModel?.consultationServiceFk == 2 {
            //"Video  Call Consultations"
            clinicIconIMG.image = UIImage (named: "ic_video call")
            locationHeightConstraint.constant = 0
            dataHeightConstraint.constant = 295
        }else if appointmentModel?.consultationServiceFk == 3 {
            //"Home Visiting"
            clinicIconIMG.image = UIImage (named: "ic_home_active")
            locationHeightConstraint.constant = 0
            dataHeightConstraint.constant = 295
        }else if appointmentModel?.consultationServiceFk == 4 {
            //"Immediate Video Call"
            clinicIconIMG.image = UIImage (named: "ic_video call immediate-1")
            locationHeightConstraint.constant = 0
            dataHeightConstraint.constant = 295
        }
        
        let startTimeString = convertTime(TimeString: appointmentModel?.startTime ?? "")
        let endTimeString = convertTime(TimeString: appointmentModel?.endTime ?? "")
        timeLBL.text = "\(startTimeString)\("-")\(endTimeString)"
        totalFeesLBL.text = "\("Total Fees ")\(appointmentModel?.bookingFees ?? 0)\(" EGP")"
        if appointmentModel?.isPaied == true {
            paidLBL.text = "Unpaid"
            paidLBL.textColor = UIColor.red
        }else{
            paidLBL.text = "Paid"
            paidLBL.textColor = UIColor.green
        }
        let imgURL = URL(string: "\(Constants.baseURLImage)\(appointmentModel?.profileImage ?? "")")
        doctorIMG.kf.indicatorType = .activity
        doctorIMG.kf.setImage(with: imgURL)
        Animation.roundView(doctorIMG)
        doctorNameLBL.text = "\(appointmentModel?.prefixTitle_Localized ?? "")\(appointmentModel?.doctor_name ?? "")"
        dateLBL.text = convertDate(DateString: appointmentModel?.bookingDate ?? "")
        appointmentReasonDescLBL.text = appointmentModel?.bookingReason ?? ""
        appointmentReasonDescLBL.numberOfLines = 3
        appointmentReasonDescLBL.sizeToFit()
        if appointmentModel?.history?.count != 0 {
            viewHistoryDescLBL.text = appointmentModel?.history?[0].changeStatusReason
            viewHistoryDescLBL.numberOfLines = 2
            viewHistoryDescLBL.sizeToFit()
        }
       
    }
    @IBAction func view_Click(_ sender: Any) {
        let vc = AppointmentHistoryPopup()
        vc.patientNameString = appointmentModel?.patientName ?? ""
        vc.doctorNameString = appointmentModel?.doctor_name ?? ""
        vc.appointmentHistoryArray = appointmentModel?.history
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func edit_Click(_ sender: Any) {
        let vc = WriteReviewsVC()
        vc.bookingFK = appointmentModel?.bookingId ?? 0
        vc.doctorFK = appointmentModel?.doctorFk ?? 0
        vc.patientReviewId = appointmentModel?.patientFk ?? 0
        self.show(vc, sender: nil)
    }
    func convertTime(TimeString : String) -> String {
        let dateAsString = TimeString
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // fixes nil if device time in 24 hour format
        let date = dateFormatter.date(from: dateAsString) ?? Date()

        dateFormatter.dateFormat = "h:mm a"
        let date24 = dateFormatter.string(from: date)
        return date24
    }
    func convertDate(DateString : String) -> String {
        let string = DateString

        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if string == "" {
            return ""
        }
        let date = dateFormatter.date(from: string)!
        dateFormatter.dateFormat = "EEEE MMM, dd yyyy"
        dateFormatter.locale = tempLocale // reset the locale
        let dateString = dateFormatter.string(from: date)
        print("EXACT_DATE : \(dateString)")
        return dateString
    }
    func getDoctorReview() {
        let doctorId = appointmentModel?.doctorFk ?? 0
        NetworkClient.performRequest(_type: DoctorReviewsModel.self, router: APIRouter.doctorreviews(id: doctorId)) {[weak self] (result) in
            guard let self = self else {return}
            switch result {
            case.success(let data):
                self.doctorReviewData = data.message
            case.failure(let err):
                print(err)
            }
        }
    }
}
