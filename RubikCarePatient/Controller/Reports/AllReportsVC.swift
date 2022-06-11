//
//  AllReportsVC.swift
//  E4 Patient
//
//  Created by Ahmed Kassem on 24/05/2022.
//

import UIKit

class AllReportsVC: UIViewController, UITextFieldDelegate, FilterReportProtocol {

    @IBOutlet weak var searchTf: UITextField!
    @IBOutlet weak var reportsTB: UITableView!
    @IBOutlet weak var filterBG: UIView!
    @IBOutlet weak var searchBG: UIView!
    
    var reportsData = [AllReportsData]()
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return formatter
    }()
    
    var fromDate = ""
    var toDate = ""
    var appointementStatus: [Int] = []
    var serviceFk: Int?
    var branchFK: Int?
    var paymentStatus: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        getAllReports()
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        getAllReports()
    }
    
    @IBAction func didTappedFilter() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "FilterReportsVC") as! FilterReportsVC
        
        vc.delegate = self
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func getAllReports() {
        var para: [String: Any] =
        [
            "DoctorNameOrMobile": searchTf.text ?? "",
            "datefrom": fromDate,
            "dateto": toDate,
            "BookingStatus": appointementStatus,
        ]
        
        if serviceFk != nil {
            para["ConsultationServiceFk"] = serviceFk ?? 0
        }
        
        if branchFK != nil {
            para["BusinessProviderBranckFk"] = branchFK ?? 0
        }
        
        if paymentStatus != nil {
            para["PaymentStatus"] = paymentStatus ?? 0
        }
        
        showUniversalLoadingView(true)
        NetworkClient.performRequest(_type: AllReportsModel.self, router: .bookingReport(params: para)) {[weak self] result in
            showUniversalLoadingView(false)
            guard let self = self else {return}
            switch result{
            case .success(let model):
                print(model)
                if model.successtate == 200{
                    self.reportsData = model.message ?? []
                    self.reportsTB.reloadData()
                }else{
                    self.showMessage(title: "", sub: "error connecting to server. please try again", type: .error, layout: .messageView)
                }
            case .failure(let model):
                self.showMessage(title: "", sub: "error connecting to server. please try again", type: .error, layout: .messageView)
                print("failure: \(model)")
            
            }
        }
    }
    
    func returnFilterData(fromDate: String, toDate: String, appointementStatus: [Int], serviceFk: Int?, branchFK: Int?, paymentStatus: Int?) {
        self.fromDate = fromDate
        self.toDate = toDate
        self.appointementStatus = appointementStatus
        self.serviceFk = serviceFk
        self.branchFK = branchFK
        self.paymentStatus = paymentStatus
        
        getAllReports()
    }
    
    func returnFilterData(fromDate: String, toDate: String, appointementStatus: [Int], serviceFk: Int?, branchFK: Int?){
        fatalError("must implement")
    }
    
}

extension AllReportsVC {
    fileprivate func setupUI() {
        self.title = "Reports"
        searchTf.delegate = self
        filterBG.ShadowView(view: filterBG, radius: 10, opacity: 0.4, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        searchBG.ShadowView(view: searchBG, radius: 10, opacity: 0.4, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        registerTB()
    }
    
    fileprivate func registerTB() {
        reportsTB.delegate = self
        reportsTB.dataSource = self
        reportsTB.separatorStyle = .none
        reportsTB.register(UINib(nibName: "AllReportsCell", bundle: nil), forCellReuseIdentifier: "AllReportsCell")
    }
}

extension AllReportsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reportsData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllReportsCell", for: indexPath) as! AllReportsCell
        
        let imgURL = URL(string: "\(Constants.baseURLImage)\(reportsData[indexPath.row].profileImage ?? "")")
        cell.patientImg?.kf.indicatorType = .activity
        cell.patientImg?.kf.setImage(with: imgURL)
        Animation.roundView(cell.patientImg)
        
        cell.patientName.text = reportsData[indexPath.row].doctorName ?? ""
        cell.locationLbl.text = reportsData[indexPath.row].branchAddressLocalized ?? ""
        if let date = self.dateFormatter.date(from: reportsData[indexPath.row].bookingDate ?? "") {
            dateFormatter.dateFormat = "E, d MMM yyyy"
            print(date)
            cell.dateLbl.text = dateFormatter.string(from: date)
        } else {
            cell.dateLbl.text = ""
        }
        cell.serviceType.text = reportsData[indexPath.row].consultationServiceLocalized ?? ""
        let paid = reportsData[indexPath.row].bookingFees ?? 0
        cell.paidLbl.text = "Paid \(paid) EG"
        let paymentType = reportsData[indexPath.row].paymentType
        if paymentType == 1 {
            cell.paymentType.text = "Cash"
        } else {
            cell.paymentType.text = "Wallet"
        }
        cell.reportStatus.text = reportsData[indexPath.row].bookingStatusName ?? ""
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func returnserviceType(serviceFK: Int) -> String {
        switch serviceFK {
        case 1:
            return "ic_clinic"
        case 2:
            return "f2"
        case 3:
            return "f3"
        case 4:
            return "f4"
        case 5:
            return "f5"
        default:
            return "ic_clinic"
        }

    }
}
