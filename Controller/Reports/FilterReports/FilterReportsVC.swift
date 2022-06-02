//
//  FilterReportsVC.swift
//  E4 Patient
//
//  Created by Ahmed Kassem on 28/05/2022.
//

import UIKit
import iOSDropDown

protocol FilterReportProtocol: AnyObject {
    func returnFilterData(fromDate: String, toDate: String, appointementStatus: [Int], serviceFk: Int?, branchFK: Int?, paymentStatus: Int?)
}

class FilterReportsVC: UIViewController {
    
    @IBOutlet weak var toTF: UITextField!
    @IBOutlet weak var fromTF: UITextField!
    @IBOutlet weak var dateStackView: UIStackView!
    @IBOutlet weak var toView: UIView!
    @IBOutlet weak var fromView: UIView!
    @IBOutlet weak var dateDropDownImg: UIImageView!
    @IBOutlet weak var separatorDateView: UIView!
    
    @IBOutlet weak var appointementDropDownImg: UIImageView!
    @IBOutlet weak var appointementStatusConstraint: NSLayoutConstraint!
    @IBOutlet weak var appointementStackView: UIStackView!
    @IBOutlet weak var separatorappointementView: UIView!
    @IBOutlet weak var appointementStatusView: UIView!

    @IBOutlet weak var paymentDropDownImg: UIImageView!
    @IBOutlet weak var paymentStatusConstraint: NSLayoutConstraint!
    @IBOutlet weak var paymentStackView: UIStackView!
    @IBOutlet weak var separatorPaymentView: UIView!
    
    @IBOutlet weak var separatorServiceTypeView: UIView!
    @IBOutlet weak var serviceTypeImg: UIImageView!
    @IBOutlet weak var serviceTypeStack: UIStackView!
    @IBOutlet weak var branchTF: DropDown!
    @IBOutlet weak var serviceTypeTF: DropDown!
    @IBOutlet weak var seviceTypeViewConst: NSLayoutConstraint!
    @IBOutlet weak var paymentStatusViewConst: NSLayoutConstraint!
    @IBOutlet weak var dateViewConst: NSLayoutConstraint!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var paymentStatusView: UIView!
    @IBOutlet weak var serviceTypeView: UIView!
    
    var selectedServiceType = true
    var selectedPaymentStatus = true
    var selectedappointement = true
    var selectedDate = true
    
    var fromDate: String?
    var toDate: String?
    var appointementStatus: [Int] = []
    var paymentStatus: Int?
    var serviceFk: Int?
    var branchFK: Int?
    
    weak var delegate: FilterReportProtocol?
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    var serviceListNameArr: [String] = [] {
        didSet {
            serviceTypeTF.optionArray = serviceListNameArr
        }
    }
    var serviceListIdArr: [Int] = []
    
    var branchListNameArr: [String] = [] {
        didSet {
            branchTF.optionArray = branchListNameArr
        }
    }
    var branchListIdArr: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        getReportServiceList()
        getBranchList()
        
    }
    
    func getReportServiceList() {
        NetworkClient.performRequest(_type: ReportServiceListModel.self, router: .reportServiceList) {[weak self] data in
            guard let self = self else {return}
            switch data {
            case.success(let data):
                if (data.message?.count ?? 0) > 0 {
                    for service in data.message! {
                        self.serviceListNameArr.append(service.nameLocalized ?? "")
                        self.serviceListIdArr.append(service.id ?? 0)
                    }
                }
            case.failure(let err):
                print(err)
            }
        }
    }
    
    func getBranchList() {
        NetworkClient.performRequest(_type: ReportServiceListModel.self, router: .reportBranchList) {[weak self] data in
            guard let self = self else {return}
            switch data {
            case.success(let data):
                if (data.message?.count ?? 0) > 0 {
                    for service in data.message! {
                        self.branchListNameArr.append(service.nameLocalized ?? "")
                        self.branchListIdArr.append(service.id ?? 0)
                    }
                }
            case.failure(let err):
                print(err)
            }
        }

    }
    
    @IBAction func didTappedServiceType() {
        selectedServiceType = !selectedServiceType
        if selectedServiceType {
            serviceTypeStack.isHidden = false
            seviceTypeViewConst.constant = 220
            serviceTypeImg.image = #imageLiteral(resourceName: "ic_next-1")
            separatorServiceTypeView.isHidden = false
        } else {
            serviceTypeStack.isHidden = true
            seviceTypeViewConst.constant = 44
            serviceTypeImg.image = #imageLiteral(resourceName: "ic_next-2")
            separatorServiceTypeView.isHidden = true
        }
    }
    
    @IBAction
    func didTappedPaymentStatus(_ sender: Any) {
        selectedPaymentStatus = !selectedPaymentStatus
        if selectedPaymentStatus {
            paymentStackView.isHidden = false
            paymentStatusConstraint.constant = 200
            paymentDropDownImg.image = #imageLiteral(resourceName: "ic_next-1")
            separatorPaymentView.isHidden = false
        } else {
            paymentStackView.isHidden = true
            paymentStatusConstraint.constant = 44
            paymentDropDownImg.image = #imageLiteral(resourceName: "ic_next-2")
            separatorPaymentView.isHidden = true
        }
    }
    
    @IBAction
    func didTappedPaymentBtn(_ sender: UIButton) {
        let tags = [11, 12, 13, 14, 15]
        let btnTag = sender.tag
        paymentStatus = btnTag
        
        for tag in tags {
            if let btn = view.viewWithTag(tag) as? UIButton {
                if paymentStatus == tag {
                    btn.setImage(UIImage(named: "ic_radiobtn_active"), for: .normal)
                } else {
                    btn.setImage(UIImage(named: "ic_radiobtn_unactive"), for: .normal)
                }
            }
        }
    }
    
    @IBAction
    func didTappedAppointementBtn(_ sender: UIButton) {
        let tags = [1, 2, 3, 4, 5, 6, 7]
        let btnTag = sender.tag
        if appointementStatus.contains(btnTag) {
            if let index = appointementStatus.firstIndex(of: btnTag) {
                appointementStatus.remove(at: index)
            }
        } else {
            appointementStatus.append(btnTag)
        }
        
        for tag in tags {
            if let btn = view.viewWithTag(tag) as? UIButton {
                if appointementStatus.contains(tag) {
                    btn.setImage(UIImage(named: "ic_radiobtn_active"), for: .normal)
                } else {
                    btn.setImage(UIImage(named: "ic_radiobtn_unactive"), for: .normal)
                }
            }
        }
    }
    
    @IBAction
    func didTappedAppointStatus(_ sender: Any) {
        selectedappointement = !selectedappointement
        if selectedappointement {
            appointementStackView.isHidden = false
            appointementStatusConstraint.constant = 220
            appointementDropDownImg.image = #imageLiteral(resourceName: "ic_next-1")
            separatorappointementView.isHidden = false
        } else {
            appointementStackView.isHidden = true
            appointementStatusConstraint.constant = 44
            appointementDropDownImg.image = #imageLiteral(resourceName: "ic_next-2")
            separatorappointementView.isHidden = true
        }
    }
    
    @IBAction
    func didTappedDate(_ sender: Any) {
        selectedDate = !selectedDate
        if selectedDate {
            dateStackView.isHidden = false
            dateViewConst.constant = 200
            dateDropDownImg.image = #imageLiteral(resourceName: "ic_next-1")
            separatorDateView.isHidden = false
        } else {
            dateStackView.isHidden = true
            dateViewConst.constant = 44
            dateDropDownImg.image = #imageLiteral(resourceName: "ic_next-2")
            separatorDateView.isHidden = true
        }
    }
    
    @IBAction
    func didTappedDateBtn(_ sender: UIButton) {
        let tags = [30, 31, 32]
        let btnTag = sender.tag
        for tag in tags {
            if let btn = view.viewWithTag(tag) as? UIButton {
                if tag == btnTag {
                    btn.setImage(UIImage(named: "ic_radiobtn_active"), for: .normal)
                } else {
                    btn.setImage(UIImage(named: "ic_radiobtn_unactive"), for: .normal)
               }
            }
        }
        
        if btnTag == 32 {
            fromTF.isEnabled = true
            toTF.isEnabled = true
        } else {
            fromTF.isEnabled = false
            toTF.isEnabled = false
            fromTF.text = ""
            toTF.text = ""
            if btnTag == 30 {
                let now = Date()
                let sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -7, to: now)
                fromDate = self.dateFormatter.string(from: sevenDaysAgo ?? now)
                toDate = self.dateFormatter.string(from: now)
            } else {
                let now = Date()
                let thirtyDaysAgo = Calendar.current.date(byAdding: .day, value: -30, to: now)
                fromDate = self.dateFormatter.string(from: thirtyDaysAgo ?? now)
                toDate = self.dateFormatter.string(from: now)

            }
        }
        
    }
    
    @IBAction
    func didTappedSearch(_ sender: Any) {
        if appointementStatus.contains(3) {
            appointementStatus.append(4)
        }
        if appointementStatus.contains(7) {
            appointementStatus = [1, 2, 3, 4, 5, 6]
        }
        if paymentStatus != nil {
            if paymentStatus == 15 {
                paymentStatus = nil
            } else {
                paymentStatus = paymentStatus! - 10
            }
        }
        delegate?.returnFilterData(fromDate: fromDate ?? "", toDate: toDate ?? "", appointementStatus: appointementStatus, serviceFk: serviceFk, branchFK: branchFK, paymentStatus: paymentStatus ?? 0)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction
    func didTappedReset(_ sender: Any) {
        resetData()
        delegate?.returnFilterData(fromDate: fromDate ?? "", toDate: toDate ?? "", appointementStatus: appointementStatus, serviceFk: serviceFk, branchFK: branchFK, paymentStatus: paymentStatus ?? 0)
        navigationController?.popViewController(animated: true)
    }
    
    func resetData() {
        fromDate = ""
        toDate = ""
        appointementStatus = []
        paymentStatus = nil
        serviceFk = nil
        branchFK = nil
    }
    
}

extension FilterReportsVC {
    fileprivate func setupUI() {
        self.title = "Filter"
        
        fromTF.isEnabled = false
        toTF.isEnabled = false
        
        serviceTypeTF.didSelect{(selectedText , index ,id) in
            self.serviceFk = self.serviceListIdArr[index]
        }
        
        branchTF.didSelect{(selectedText , index ,id) in
            self.branchFK = self.branchListIdArr[index]
        }

        
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .date
        fromTF.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        
        let datePickerView2 = UIDatePicker()
        datePickerView2.datePickerMode = .date
        toTF.inputView = datePickerView2
        datePickerView2.addTarget(self, action: #selector(handleToDatePicker(sender:)), for: .valueChanged)
        
        serviceTypeView.ShadowView(view: serviceTypeView, radius: 10, opacity: 0.4, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        paymentStatusView.ShadowView(view: paymentStatusView, radius: 10, opacity: 0.4, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        appointementStatusView.ShadowView(view: appointementStatusView, radius: 10, opacity: 0.4, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        dateView.ShadowView(view: dateView, radius: 10, opacity: 0.4, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        toView.ShadowView(view: toView, radius: 10, opacity: 0.4, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        fromView.ShadowView(view: fromView, radius: 10, opacity: 0.4, shadowRadius: 2, color: UIColor.lightGray.cgColor)
    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: sender.date)
        fromTF.text = date
        fromDate = date
    }
    @objc func handleToDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: sender.date)
        toTF.text = date
        toDate = date
    }
    
}
