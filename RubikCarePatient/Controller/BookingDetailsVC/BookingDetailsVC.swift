//
//  BookingDetailsVC.swift
//  E4 Patient
//
//  Created by mohab on 09/05/2021.
//

import UIKit

class BookingDetailsVC: UIViewController, BaseViewProtocol {
    
    var date: String?
    var fTime: String?
    var toTime: String?
    var branchName: String?
    var branchAddress: String?
    var totalFees: Int?
    var doctorImg: String?
    var doctorName: String?
    var doctorId: Int?
    var branchId: Int?
    var consultationserviceFK: Int?
    
    var serviceType: Int?
    var medicalServiceFK: Int?
    var isOverBookin: Bool?
    var bookingReason: String?
    
    var paymetType: Int?
    
    var wallet = 0
    
    @IBOutlet weak var walletImg: UIImageView!
    @IBOutlet weak var cashImage: UIImageView!
    @IBOutlet weak var consultationName: UILabel!
    @IBOutlet weak var doctorNameImage: UIImageView!
    @IBOutlet weak var doctorNameLbl: UILabel!
    @IBOutlet weak var totalFeesLbl: UILabel!
    @IBOutlet weak var clinicAddress: UILabel!
    @IBOutlet weak var fromToTime: UILabel!
    @IBOutlet weak var clinicDate: UILabel!
    @IBOutlet weak var clinicName: UILabel!
    @IBOutlet weak var walletBalance: UILabel!
    @IBOutlet var dataView: UIView!
    @IBOutlet var walletView: UIView!
    @IBOutlet var cashView: UIView!
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Booking Details".localized
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColor.Blue]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getWalletBalance()
        setData()
        doctorNameImage.layer.cornerRadius = doctorNameImage.frame.width / 2
        
        dataView.ShadowView(view: dataView, radius: 10, opacity: 2, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        walletView.ShadowView(view: walletView, radius: 10, opacity: 2, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        cashView.ShadowView(view: cashView, radius: 10, opacity: 2, shadowRadius: 2, color: UIColor.lightGray.cgColor)
       
    }
    func setData() {
        let imgURL = URL(string: doctorImg ?? "")
        doctorNameImage?.kf.indicatorType = .activity
        doctorNameImage?.kf.setImage(with: imgURL)
        doctorNameLbl.text = doctorName ?? ""
        totalFeesLbl.text = "Total fees \(totalFees ?? 0) EGP"
        clinicAddress.text = branchAddress ?? ""
        clinicName.text = branchName ?? ""
        clinicDate.text = date ?? ""
        fromToTime.text = "\(fTime ?? "") - \(toTime ?? "")"
    }
    
    func getWalletBalance() {
        NetworkClient.performRequest(_type: WalletbalanceModel.self, router: APIRouter.walletBalance) {[weak self] (result) in
            guard let self = self else {return}
            switch result {
            case.success(let data):
                if data.successtate == 200 {
                    self.wallet = data.message ?? 0
                    self.walletBalance.text = "Your balance \(data.message ?? 0) in your wallet"
                }
            case.failure(let err):
                print(err)
            }
        }
    }

    @IBAction func cashBtnPressed(_ sender: Any) {
        paymetType = 1
        cashImage.image = #imageLiteral(resourceName: "ic_radiobtn_active")
        walletImg.image = #imageLiteral(resourceName: "ic_radiobtn_unactive")
    }
    @IBAction func walletBtnPressed(_ sender: Any) {
        paymetType = 2
        walletImg.image = #imageLiteral(resourceName: "ic_radiobtn_active")
        cashImage.image = #imageLiteral(resourceName: "ic_radiobtn_unactive")
    }
    @IBAction func confirm_Click(_ sender: Any) {
        addBooking()
    }
    func addBooking() {
        if paymetType == nil {
            self.showAlert(message: "Select Payment")
            return
        }
        let patientId = UserDefaults.standard.string(forKey: "patientId")
        var para: [String: Any] =
        [
            "BookingDate": date ?? "",
            "BookingReason": bookingReason ?? "",
            "BookingStatus": 1,
            "BusinessProviderBranchFk": branchId ?? 0,
            "CurrencyFk": 1,
            "DoctorFk": doctorId ?? 0,
            "DoctorName": doctorName ?? "",
            "EndTime": toTime ?? "",
            "PatientFk": patientId ?? 0,
            "PaymentType": paymetType ?? 0,
            "StartTime": fTime ?? "",
            "ServiceType": serviceType ?? 0,
            "IsOverBooking": isOverBookin ?? false
        ]
        if serviceType != 2 {
            para["ConsultationServiceFk"] = consultationserviceFK ?? 0
        }
        print(para)
        NetworkClient.performRequest(_type: AddBookingModel.self, router: APIRouter.addBooking(parameters: para)) { (result) in
            switch result {
            case.success(let data):
                if data.successtate == 200 {
                    let vc = SuccessBookingVC()
                    self.present(vc, animated: true, completion: nil)
                } else {
                    self.showAlert(message: "Error, try again")
                }
            case.failure(let err):
                print(err)
                self.showAlert(message: err.localizedDescription)
            }
        }
    }

}
