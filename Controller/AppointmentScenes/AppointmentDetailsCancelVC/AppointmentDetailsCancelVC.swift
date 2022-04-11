//
//  AppointmentDetailsCancelVC.swift
//  E4 Patient
//
//  Created by mohab on 09/05/2021.
//

import UIKit

class AppointmentDetailsCancelVC: UIViewController {
    @IBOutlet var canceledView: UIView!
    @IBOutlet weak var appointmentCancelTitleLBL: UILabel!
    @IBOutlet weak var appointmentCancelDescLBL: UILabel!
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
    var bookingID = 0
    var appointmentDetailsResponse: AppointmentDetailsMessage?{
        didSet{
            setCancelData()
        }
    }

    var appointmentModel: AppointmentMessage?
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Appointment Details".localized
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColor.Blue]
        yourAppointmentLBL.text = "Your Appointment"
        withDoctorLBL.text = "With Doctor"
        appointmentReasonTitleLBL.text = "Appointment Reason"
        appointmentCancelTitleLBL.text = "Appointment Cancel"
        viewHistoryTitleLBL.text = "View History Appointment"
        callApi(bookingID: bookingID)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        dataView.ShadowView(view: dataView, radius: 10, opacity: 2, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        reasonView.ShadowView(view: reasonView, radius: 10, opacity: 2, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        historyView.ShadowView(view: historyView, radius: 10, opacity: 2, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        canceledView.ShadowView(view: canceledView, radius: 10, opacity: 2, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        
        }
    func setCancelData() {
        clinicNameLBL.text = self.appointmentDetailsResponse?.consultationServiceLocalized ?? ""
        bookingStatusLBL.textColor = UIColor.red
        bookingStatusLBL.text = appointmentDetailsResponse?.bookingStatusName ?? ""
        self.branchAddressLBL.text = "\(appointmentDetailsResponse?.entityNameLocalized ?? "")\(" ")\("(")\(appointmentDetailsResponse?.branchAddressLocalized ?? "")\(")")"
        if appointmentDetailsResponse?.consultationServiceFk == 1 {
            //"Clinic Consultations"
            clinicIconIMG.image = UIImage (named: "ic_clinic")
            locationLBL.text = appointmentDetailsResponse?.branchAddressLocalized
            locationLBL.numberOfLines = 3
            locationLBL.sizeToFit()
            locationHeightConstraint.constant = 15
            dataHeightConstraint.constant = 310
        }else if appointmentDetailsResponse?.consultationServiceFk == 2 {
            //"Video  Call Consultations"
            clinicIconIMG.image = UIImage (named: "ic_video call")
            locationHeightConstraint.constant = 0
            dataHeightConstraint.constant = 295
        }else if appointmentDetailsResponse?.consultationServiceFk == 3 {
            //"Home Visiting"
            clinicIconIMG.image = UIImage (named: "ic_home_active")
            locationHeightConstraint.constant = 0
            dataHeightConstraint.constant = 295
        }else if appointmentDetailsResponse?.consultationServiceFk == 4 {
            //"Immediate Video Call"
            clinicIconIMG.image = UIImage (named: "ic_video call immediate-1")
            locationHeightConstraint.constant = 0
            dataHeightConstraint.constant = 295
        }
        let startTimeString = convertTime(TimeString: appointmentDetailsResponse?.startTime ?? "")
        let endTimeString = convertTime(TimeString: appointmentDetailsResponse?.endTime ?? "")
        timeLBL.text = "\(startTimeString)\("-")\(endTimeString)"
        totalFeesLBL.text = "\("Total Fees ")\(appointmentDetailsResponse?.bookingFees ?? 0)\(" EGP")"
        if appointmentDetailsResponse?.isPaied == true {
            paidLBL.text = "\("Unpaid")\(appointmentDetailsResponse?.bookingFees ?? 0)"
                    paidLBL.textColor = UIColor.red
                }else{
                    paidLBL.text = "\("Paid")\(appointmentDetailsResponse?.bookingFees ?? 0)"
                    paidLBL.textColor = UIColor.green
                }
        let imgURL = URL(string: "\(Constants.baseURLImage)\(appointmentDetailsResponse?.profileImage ?? "")")
        doctorIMG.kf.indicatorType = .activity
        doctorIMG.kf.setImage(with: imgURL)
        Animation.roundView(doctorIMG)
        doctorNameLBL.text = "\(appointmentModel?.prefixTitle_Localized ?? "")\(appointmentModel?.doctor_name ?? "")"
        dateLBL.text = convertDate(DateString: appointmentDetailsResponse?.bookingDate ?? "")
        appointmentReasonDescLBL.text = appointmentDetailsResponse?.bookingReason ?? ""
        appointmentReasonDescLBL.numberOfLines = 3
        appointmentReasonDescLBL.sizeToFit()
//        appointmentCancelDescLBL.text =
        if appointmentModel?.history?.count != 0 {
        appointmentCancelDescLBL.text = appointmentDetailsResponse?.history?[0].changeStatusReason
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
        let date = dateFormatter.date(from: string)!
        dateFormatter.dateFormat = "EEEE MMM, dd yyyy"
        dateFormatter.locale = tempLocale // reset the locale
        let dateString = dateFormatter.string(from: date)
        print("EXACT_DATE : \(dateString)")
        return dateString
    }

    


}
