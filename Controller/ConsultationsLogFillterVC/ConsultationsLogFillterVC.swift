//
//  ConsultationsLogFillterVC.swift
//  E4 Patient
//
//  Created by mohab on 09/05/2021.
//

import UIKit
import DLRadioButton

protocol FilterConsultationDelegate: AnyObject {
    func filterConsultation(fromDate: String?, toDate: String?, consultationServiceFK: Int?)
}

class ConsultationsLogFillterVC: UIViewController {
    
    var selected = false
    var selectedServices = false
    
    var fromDate: String?
    var toDate: String?
    var consultationServiceFK: Int?
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    
    weak var filterConsultationDelegate: FilterConsultationDelegate?
    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var separateView: UIView!
    @IBOutlet weak var dateHeight: NSLayoutConstraint!
    @IBOutlet weak var collapsedImage: UIImageView!
    @IBOutlet weak var fromDateBtn: DLRadioButton!
    @IBOutlet weak var thirtyDaysBtn: DLRadioButton!
    @IBOutlet weak var sevenDaysBTn: DLRadioButton!
    @IBOutlet weak var toBG: UIView!
    @IBOutlet weak var fromBG: UIView!
    @IBOutlet weak var toTF: UITextField!
    @IBOutlet weak var fromTF: UITextField!
    @IBOutlet var dateView: UIView!
    @IBOutlet var serviseView: UIView!
    @IBOutlet weak var collapsedServiseImage: UIImageView!
    @IBOutlet weak var separatorServiceView: UIView!
    @IBOutlet weak var serviceHeightConst: NSLayoutConstraint!
    @IBOutlet weak var allBtn: DLRadioButton!
    @IBOutlet weak var clinicConsultationBtn: DLRadioButton!
    @IBOutlet weak var videoCallConsultationsBtn: DLRadioButton!
    @IBOutlet weak var homeVisitBtn: DLRadioButton!
    @IBOutlet weak var immadiateVideoCallBtn: DLRadioButton!
    @IBOutlet weak var contentServiceStack: UIStackView!
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Filter".localized
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColor.Blue]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fromTF.isEnabled = false
        toTF.isEnabled = false
        
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .date
        fromTF.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        
        let datePickerView2 = UIDatePicker()
        datePickerView2.datePickerMode = .date
        toTF.inputView = datePickerView2
        datePickerView2.addTarget(self, action: #selector(handleToDatePicker(sender:)), for: .valueChanged)

        serviseView.ShadowView(view: serviseView, radius: 10, opacity: 2, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        dateView.ShadowView(view: dateView, radius: 10, opacity: 2, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        fromBG.ShadowView(view: fromBG, radius: 10, opacity: 0.3, shadowRadius: 2, color: UIColor.darkGray.cgColor)
        toBG.ShadowView(view: toBG, radius: 10, opacity: 0.3, shadowRadius: 2, color: UIColor.darkGray.cgColor)
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
    @IBAction func collapsedDateBtn(_ sender: Any) {
        selected = !selected
        if selected {
            dateHeight.constant = 40
            separateView.isHidden = true
            contentStackView.isHidden = true
            collapsedImage.image = #imageLiteral(resourceName: "ic_next-2")
        } else {
            dateHeight.constant = 200
            separateView.isHidden = false
            contentStackView.isHidden = false
            collapsedImage.image = #imageLiteral(resourceName: "ic_next-1")
        }
    }
    @IBAction func sevenDaysBtnPressed(_ sender: Any) {
        sevenDaysBTn.isSelected = true
        thirtyDaysBtn.isSelected = false
        fromDateBtn.isSelected = false
        fromTF.isEnabled = false
        toTF.isEnabled = false
        
        let now = Date()
        let sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -7, to: now)
        fromDate = self.dateFormatter.string(from: sevenDaysAgo ?? now)
        toDate = self.dateFormatter.string(from: now)
    }
    @IBAction func thirtyDaysBtnPressed(_ sender: Any) {
        sevenDaysBTn.isSelected = false
        thirtyDaysBtn.isSelected = true
        fromDateBtn.isSelected = false
        fromTF.isEnabled = false
        toTF.isEnabled = false
        
        let now = Date()
        let thirtyDaysAgo = Calendar.current.date(byAdding: .day, value: -30, to: now)
        fromDate = self.dateFormatter.string(from: thirtyDaysAgo ?? now)
        toDate = self.dateFormatter.string(from: now)
    }
    @IBAction func fromDateBtnPressed(_ sender: Any) {
        sevenDaysBTn.isSelected = false
        thirtyDaysBtn.isSelected = false
        fromDateBtn.isSelected = true
        fromTF.isEnabled = true
        toTF.isEnabled = true
    }
    @IBAction func collapsedServiceBtn(_ sender: Any) {
        selectedServices = !selectedServices
        if selectedServices {
            serviceHeightConst.constant = 40
            separatorServiceView.isHidden = true
            contentServiceStack.isHidden = true
            collapsedServiseImage.image = #imageLiteral(resourceName: "ic_next-2")
        } else {
            serviceHeightConst.constant = 250
            separatorServiceView.isHidden = false
            contentServiceStack.isHidden = false
            collapsedServiseImage.image = #imageLiteral(resourceName: "ic_next-1")
        }
    }
    @IBAction func allBtnPressed(_ sender: Any) {
        allBtn.isSelected = true
        clinicConsultationBtn.isSelected = false
        videoCallConsultationsBtn.isSelected = false
        homeVisitBtn.isSelected = false
        immadiateVideoCallBtn.isSelected = false
        
        consultationServiceFK = nil
    }
    @IBAction func clinicConsultationsBtnPressed(_ sender: Any) {
        allBtn.isSelected = false
        clinicConsultationBtn.isSelected = true
        videoCallConsultationsBtn.isSelected = false
        homeVisitBtn.isSelected = false
        immadiateVideoCallBtn.isSelected = false
        
        consultationServiceFK = 1
    }
    @IBAction func videoCallConsultationBtnPressed(_ sender: Any) {
        allBtn.isSelected = false
        clinicConsultationBtn.isSelected = false
        videoCallConsultationsBtn.isSelected = true
        homeVisitBtn.isSelected = false
        immadiateVideoCallBtn.isSelected = false
        
        consultationServiceFK = 2
    }
    @IBAction func homeVisitBtnPressed(_ sender: Any) {
        allBtn.isSelected = false
        clinicConsultationBtn.isSelected = false
        videoCallConsultationsBtn.isSelected = false
        homeVisitBtn.isSelected = true
        immadiateVideoCallBtn.isSelected = false
        
        consultationServiceFK = 3
    }
    @IBAction func immadiateVideoCallBtnPressed(_ sender: Any) {
        allBtn.isSelected = false
        clinicConsultationBtn.isSelected = false
        videoCallConsultationsBtn.isSelected = false
        homeVisitBtn.isSelected = false
        immadiateVideoCallBtn.isSelected = true
        
        consultationServiceFK = 4
    }
    
    @IBAction func search_Click(_ sender: Any) {
        self.filterConsultationDelegate?.filterConsultation(fromDate: fromDate, toDate: toDate, consultationServiceFK: consultationServiceFK)
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func reset_Click(_ sender: Any) {
        fromDate = nil
        toDate = nil
        consultationServiceFK = nil
        self.filterConsultationDelegate?.filterConsultation(fromDate: fromDate, toDate: toDate, consultationServiceFK: consultationServiceFK)
        self.navigationController?.popViewController(animated: true)
    }
    
}
