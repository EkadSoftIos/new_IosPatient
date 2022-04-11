//
//  AddAppointmentVC.swift
//  E4 Patient
//
//  Created by mohab on 10/05/2021.
//

import UIKit
import FSCalendar
import iOSDropDown

class AddAppointmentVC: UIViewController, FSCalendarDelegate, BaseViewProtocol, UITextViewDelegate {
    
    var branchList: ServiceList?
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    
    var consultationService: Int?
    var doctorId: Int?
    var doctorImg: String?
    var doctorName: String?
    var selectedDate: String?
    var selectedFees: Int?
    var branchId: Int?
    var serviceType = 1
    var medicalService: Int?
    
    var shiftSelectedIndex = 0 {
        didSet {
            if branchTimeData?.count != 0 && branchTimeData != nil {
                if branchTimeData?[shiftSelectedIndex].allowSecondConsultaion == true {
                    secondConsultationBnt.isEnabled = true
                } else {
                    secondConsultationBnt.isEnabled = false
                    secondConsultationView.backgroundColor = .lightGray
                    secondFeesLbl.textColor = .white
                }
            }
        }
    }
    var hoursSelectedIndex: Int?
    
    var branchTimeData: [AvailableTimesData]? {
        didSet {
            if branchTimeData?.count != 0 && branchTimeData != nil {
                if branchTimeData?[shiftSelectedIndex].allowSecondConsultaion == true {
                    secondConsultationBnt.isEnabled = true
                } else {
                    secondConsultationBnt.isEnabled = false
                    secondConsultationView.backgroundColor = .lightGray
                    secondFeesLbl.textColor = .white
                }
            }
        }
    }
    var medicalServiceList: [MedicalServiceList]? {
        didSet {
            if medicalServiceList?.count != 0 && medicalServiceList != nil {
                for service in medicalServiceList! {
                    self.serviceNameArr.append((service.medicalServiceNameLocalized)!)
                }
            }
        }
    }
    var serviceNameArr = [String]()
    
    @IBOutlet weak var firstFeesTitle: UILabel!
    @IBOutlet weak var secondFeesTitle: UILabel!
    @IBOutlet weak var secondConsultationView: UIView!
    @IBOutlet weak var firstConsultationView: UIView!
    @IBOutlet weak var secondConsultationBnt: UIButton!
    @IBOutlet weak var reasonPlanTextView: UITextView!
    @IBOutlet weak var reasonPlanBGView: UIView!
    @IBOutlet weak var firstFeesLbl: UILabel!
    @IBOutlet weak var secondFeesLbl: UILabel!
    @IBOutlet weak var branchName: UILabel!
    @IBOutlet weak var branchAddress: UILabel!
    @IBOutlet weak var branchImage: UIImageView!
    @IBOutlet var serviseView: UIView!
    @IBOutlet var shiiftCollection: UICollectionView!
    @IBOutlet var addressView: UIView!
    @IBOutlet var calenderView: FSCalendar!
    @IBOutlet var calenderHeight: NSLayoutConstraint!
    @IBOutlet var hoursCollection: UICollectionView!
    @IBOutlet weak var medicalServiceTF: DropDown!
    var isCalenderWeek: Bool = true
    override func viewDidAppear(_ animated: Bool) {
//        calenderView.scope = .week
//        calenderView.rowHeight = 50
//        calenderView.fs_height = 50
//        calenderHeight.constant = 100
//        calenderView.layoutIfNeeded()
//        self.calenderView.reloadData()

    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Appointment".localized
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColor.Blue]
    }
    func setBranchData() {
        let branchname = "\(branchList?.entityName_Localized ?? "")" + "(" + "\(branchList?.branchName_Localized ?? "")" + ")"
        branchName.text = branchname
        let imgURL = URL(string: "\(Constants.baseURLImage)\(branchList?.imagepath ?? "")")
        branchImage?.kf.indicatorType = .activity
        branchImage?.kf.setImage(with: imgURL)
        branchAddress.text = branchList?.branchAddress_Localized ?? ""
        
        firstFeesLbl.text = "\(branchList?.consultationServiceFees ?? 0) EGP"
        secondFeesLbl.text = "\(branchList?.secondConsultationServiceFees ?? 0) EGP"
        selectedFees = branchList?.consultationServiceFees ?? 0
    }
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
            self.calenderHeight.constant = bounds.height
            self.view.layoutIfNeeded()
        }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did select date \(self.dateFormatter.string(from: date))")
        let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        print("selected dates is \(selectedDates)")
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
        let selectedDate = self.dateFormatter.string(from: date)
        let nowDate = self.dateFormatter.string(from: Date())
        if selectedDate < nowDate {
            self.showAlert(message: "You Must Select Date Higher Than Or Equal Today.")
            return
        }
        let date = self.dateFormatter.string(from: date)
        self.selectedDate = date
        shiftSelectedIndex = 0
        getAvailableTimes()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setBranchData()
        self.selectedDate = self.dateFormatter.string(from: Date())
        getAvailableTimes()
        
        reasonPlanTextView.delegate = self
        
        calenderView.delegate = self
        self.calenderView.setScope(.week, animated: false)
        serviseView.ShadowView(view: serviseView, radius: 10, opacity: 2, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        addressView.ShadowView(view: addressView, radius: 10, opacity: 2, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        setupCollectionView()
        
        medicalServiceTF.optionArray = serviceNameArr
        medicalServiceTF.didSelect{(selectedText , index ,id) in
            self.serviceType = 2
            self.medicalService = self.medicalServiceList?[index].medicalServiceFk ?? 0
        }
    }
    func setupCollectionView(){
        shiiftCollection.register(ShiftCell.nib, forCellWithReuseIdentifier: "ShiftCell")
        shiiftCollection.delegate = self
        shiiftCollection.dataSource = self
        
        hoursCollection.register(hoursCell.nib, forCellWithReuseIdentifier: "hoursCell")
        hoursCollection.register(UINib(nibName: "WorkingTimeCell", bundle: nil), forCellWithReuseIdentifier: "WorkingTimeCell")
        hoursCollection.delegate = self
        hoursCollection.dataSource = self
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        reasonPlanBGView.setupShadowView(cornerRadius: 13, shadowRadius: 4, shadowColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.16), shadowOpacity: 0.4, shadowOffset: .init(width: 3, height: 4), borderwidth: 0.2, borderColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.16))
        reasonPlanTextView.layer.cornerRadius = 7
        reasonPlanTextView.layer.borderWidth = 0.5
        reasonPlanTextView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.16)
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Appointment Reason"
        }
    }
    @IBAction func downCalender_Click(_ sender: Any) {
        if isCalenderWeek == true{
            self.calenderView.setScope(.month, animated: false)
        }else{
            self.calenderView.setScope(.month, animated: false)
        }
    }
    @IBAction func firstFeesLblBtn(_ sender: Any) {
        firstFeesLbl.textColor = .white
        firstConsultationView.backgroundColor = #colorLiteral(red: 0.07058823529, green: 0.4666666667, blue: 0.8196078431, alpha: 1)
        firstFeesTitle.textColor = .white
        
        if branchTimeData?[shiftSelectedIndex].allowSecondConsultaion == true {
            secondFeesLbl.textColor = #colorLiteral(red: 0.07058823529, green: 0.4666666667, blue: 0.8196078431, alpha: 1)
            secondConsultationView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            secondFeesTitle.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            secondConsultationView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
        
        serviceType = 1
        medicalService = nil
        selectedFees = branchList?.consultationServiceFees ?? 0
    }
    @IBAction func secondFeesLblBtn(_ sender: Any) {
        if branchTimeData?[shiftSelectedIndex].allowSecondConsultaion == true {
            secondFeesLbl.textColor = .white
            secondConsultationView.backgroundColor = #colorLiteral(red: 0.07058823529, green: 0.4666666667, blue: 0.8196078431, alpha: 1)
            secondFeesTitle.textColor = .white
            
            firstFeesLbl.textColor = #colorLiteral(red: 0.07058823529, green: 0.4666666667, blue: 0.8196078431, alpha: 1)
            firstConsultationView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            firstFeesTitle.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            firstConsultationView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            firstConsultationView.borderWidth = 0.5
            
            serviceType = 3
            medicalService = nil
        
            selectedFees = branchList?.secondConsultationServiceFees ?? 0
        }
    }
    @IBAction func reservision_Click(_ sender: Any) {
        
    }
    @IBAction func continue_Click(_ sender: Any) {
        let vc = BookingDetailsVC()
        
        var fTime: String?
        var toTime: String?
        
        if branchTimeData?.count ?? 0 > 0 {
            if branchTimeData?[shiftSelectedIndex].reservationType == 1 {
                fTime = branchTimeData?[shiftSelectedIndex].startTime ?? ""
                toTime = branchTimeData?[shiftSelectedIndex].endTime ?? ""
            } else {
                if hoursSelectedIndex == nil {
                    self.showAlert(message: "Select time")
                    return
                }
                fTime = branchTimeData?[shiftSelectedIndex].availableTime?[hoursSelectedIndex ?? 0].startTime ?? ""
                toTime = branchTimeData?[shiftSelectedIndex].availableTime?[hoursSelectedIndex ?? 0].endTime ?? ""
                
            }
        } else {
            self.showAlert(message: "No available times")
            return
        }
        
        vc.date = self.selectedDate ?? ""
        
        vc.fTime = fTime
        vc.toTime = toTime
        vc.branchName = branchName.text
        vc.branchAddress = branchAddress.text
        vc.totalFees = selectedFees
        vc.doctorImg = self.doctorImg
        vc.doctorName = self.doctorName
        vc.doctorId = doctorId
        vc.branchId = branchId
        vc.consultationserviceFK = consultationService 
        
        vc.serviceType = serviceType
        vc.medicalServiceFK = medicalService
        vc.bookingReason = reasonPlanTextView.text ?? ""
        
        if branchTimeData?[shiftSelectedIndex].leftBooking ?? 0 <= 0 {
            vc.isOverBookin = true
        } else {
            vc.isOverBookin = false
        }
        
        self.show(vc, sender: nil)
    }
    func getAvailableTimes() {
        let para: [String: Any] =
        [
            "BranchID": branchId ?? 0,
            "ConsultationService": consultationService ?? 0,
            "Date": selectedDate ?? "",
            "DoctorID": doctorId ?? 0
        ]
        NetworkClient.performRequest(_type: AvailableTimesModel.self, router: APIRouter.branchAvailableTime(parameters: para)) {[weak self] (result) in
            guard let self = self else {return}
            switch result {
            case.success(let data):
                self.branchTimeData = data.message
                self.shiiftCollection.reloadData()
                self.hoursCollection.reloadData()
            case.failure(let err):
                print(err)
            }
        }
    }
    
}
extension AddAppointmentVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == shiiftCollection{
            return self.branchTimeData?.count ?? 0
        }else{
            if branchTimeData != nil && branchTimeData?.count != 0 {
                if branchTimeData?[shiftSelectedIndex].reservationType == 1 {
                    return 1
                } else {
                    return branchTimeData?[shiftSelectedIndex].availableTime?.count ?? 0
                }
            }
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == shiiftCollection{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShiftCell", for: indexPath) as! ShiftCell
            cell.shiftLbl.text = "Shift \(indexPath.row + 1)"
            if indexPath.row == shiftSelectedIndex {
                cell.selectedView.backgroundColor = #colorLiteral(red: 0.07058823529, green: 0.4666666667, blue: 0.8196078431, alpha: 1)
            } else {
                cell.selectedView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            return cell
            
        }else{
            if branchTimeData?[shiftSelectedIndex].reservationType == 1 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WorkingTimeCell", for: indexPath) as! WorkingTimeCell
                
                cell.fromDate.text = branchTimeData?[shiftSelectedIndex].startTime ?? ""
                cell.todate.text = branchTimeData?[shiftSelectedIndex].endTime ?? ""
                let reservationCount = branchTimeData?[shiftSelectedIndex].leftBooking ?? 0
                cell.reservationCountLbl.text = "Only \(reservationCount) reservations left"
                
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hoursCell", for: indexPath) as! hoursCell
                cell.hoursLbl.text = branchTimeData?[shiftSelectedIndex].availableTime?[indexPath.row].startTime ?? ""
                
                if branchTimeData?[shiftSelectedIndex].availableTime?[indexPath.row].isAvilable == true {
                    if indexPath.row == hoursSelectedIndex {
                        cell.cellView.backgroundColor = #colorLiteral(red: 0.07058823529, green: 0.4666666667, blue: 0.8196078431, alpha: 1)
                        cell.hoursLbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    } else {
                        cell.cellView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                        cell.hoursLbl.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
                    }
                } else {
                    cell.cellView.backgroundColor = .lightGray
                    cell.hoursLbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                }
                
                
                
                return cell
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == shiiftCollection{
            return CGSize(width: collectionView.frame.width / 3 - 8,height:  50 )
        } else {
            if branchTimeData?[shiftSelectedIndex].reservationType == 1 {
                return CGSize(width: collectionView.frame.width ,height:  180 )
            } else {
                return CGSize(width: collectionView.frame.width / 3 - 8,height:  50 )
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == shiiftCollection{
            self.hoursSelectedIndex = nil
            self.shiftSelectedIndex = indexPath.row
        }else{
            if branchTimeData?[shiftSelectedIndex].reservationType == 2 {
                if branchTimeData?[shiftSelectedIndex].availableTime?[indexPath.row].isAvilable == true {
                    self.hoursSelectedIndex = indexPath.row
                } else {
                    showAlert(message: "This time is reserved by another patient.")
                }
            }
            
        }
        self.shiiftCollection.reloadData()
        self.hoursCollection.reloadData()
    }
    
}
