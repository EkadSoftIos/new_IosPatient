//
//  AppointmentVC.swift
//  E4 Patient
//
//  Created by mohab on 18/01/2021.
//

import UIKit
import FSCalendar
class AppointmentVC: UIViewController,FSCalendarDelegate , UISearchBarDelegate {
    @IBOutlet var fillterView: UIView!
    @IBOutlet var appointmentTableView: UITableView!
    @IBOutlet var calenderView: FSCalendar!
    @IBOutlet var calenderHeight: NSLayoutConstraint!
    @IBOutlet weak var searchBar: UISearchBar!

    var date = ""
    var isHistory: Bool = false
    var appointmentResponse: AppointmentHistoryModel?
    var newAppointmentResponse: AppointmentHistoryModel?
    var appointmentMessage: [AppointmentMessage]?
    var model: UserDataModel?
    var fromFilter = false
    var consultationServiceFk = 0
    //1,0 >> Waiting 2 >> Confirm
    var AppointmentStatus = [Int]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        searchBar.delegate = self
        calenderView.delegate = self
        self.calenderView.setScope(.week, animated: false)
        fillterView.ShadowView(view: fillterView, radius: 10, opacity: 2, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        
    }
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    override func viewWillAppear(_ animated: Bool) {
        let date = self.dateFormatter.string(from: Date())
        self.date = date
        callApi(date: self.date)
       
    }
    
    func setupTableView(){
        appointmentTableView.register(AppointmentCell.nib, forCellReuseIdentifier: "AppointmentCell")
        appointmentTableView.delegate = self
        appointmentTableView.dataSource = self
        appointmentTableView.separatorStyle = .none
    }
    @IBAction func filter_Click(_ sender: Any) {
        if isHistory == false{
        let vc = AppointmentFillterVC()
            self.show(vc, sender: nil)
            
        }else{
            let vc = AppointmetHistoryFillterVC()
            self.show(vc, sender: nil)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
                if searchText.isEmpty {
                    self.appointmentMessage = newAppointmentResponse?.message
                    appointmentTableView.reloadData()
                } else {
                    self.appointmentMessage = self.appointmentMessage?.filter({ (doctor) -> Bool in
                        guard let searchTxt = self.searchBar.text else {return false}
                        return (doctor.doctor_name!.lowercased().contains(searchTxt.lowercased()))
                                })
                    appointmentTableView.reloadData()
                }

    }

}
extension AppointmentVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointmentMessage?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentCell") as! AppointmentCell
        cell.selectionStyle = .none
        let appointmentModel = appointmentResponse?.message?[indexPath.row]

        let imgURL = URL(string: "\(Constants.baseURLImage)\(appointmentModel?.profileImage ?? "")")
        cell.doctorIMG?.kf.indicatorType = .activity
        cell.doctorIMG?.kf.setImage(with: imgURL)
        Animation.roundView(cell.doctorIMG)
        cell.doctorTitleNameLBL.text = "\(appointmentModel?.prefixTitle_Localized ?? "")\(appointmentModel?.doctor_name ?? "")"
//        cell.doctorSpecLBL.text = "\("Consultant in")\(" ")\(appointmentModel?.fullProfisionalDetails_Localized ?? "")"
        cell.clinicNameLBL.text = appointmentModel?.consultationService_localized ?? ""
        if appointmentModel?.isPaied == true {
            cell.unPaidLBL.text = "\("Unpaid".localized)\(" ")\(appointmentModel?.bookingFees ?? 0)\(" ")\("EGP")"
            cell.unPaidLBL.textColor = UIColor.red
        }else{
            cell.unPaidLBL.text = "\("Paid".localized)\(" ")\(appointmentModel?.bookingFees ?? 0)\(" ")\("EGP")"
            cell.unPaidLBL.textColor = UIColor.green
        }

        if appointmentModel?.isOverBooking == true {
            cell.overBookingLBL.isHidden = false
            cell.overBookingLBL.text = "OverBooking"
        }else{
            cell.overBookingLBL.isHidden = true
        }
//        if appointmentModel?.isOnline == true {
//            cell.onlineStatusView.backgroundColor = UIColor.green
//        }else{
//            cell.onlineStatusView.backgroundColor = UIColor.gray
//        }
        cell.statusNameLBL.text = appointmentModel?.bookingStatusName ?? ""
        if appointmentModel?.bookingStatus == 1 || appointmentModel?.bookingStatus == 0{
            //انتظار
            cell.statusNameLBL.textColor = UIColor.orange
        }else if appointmentModel?.bookingStatus == 2 {
            //"تم القبول"
            cell.statusNameLBL.textColor = UIColor.green
        }else if appointmentModel?.bookingStatus == 3 || appointmentModel?.bookingStatus == 4{
            //Cancel
            cell.statusNameLBL.textColor = UIColor.red
        }else if appointmentModel?.bookingStatus == 5 {
            //Finish
            cell.statusNameLBL.textColor = UIColor.blue
        }else if appointmentModel?.bookingStatus == 6{
            //No Show
            cell.statusNameLBL.textColor = UIColor.black

        }
        let startTimeString = convertTime(TimeString: appointmentModel?.startTime ?? "")
        let endTimeString = convertTime(TimeString: appointmentModel?.endTime ?? "")
        cell.timeLBL.text = "\(startTimeString)\("-")\(endTimeString)"
        if appointmentModel?.consultationServiceFk == 1 {
            //"Clinic Consultations"
            cell.clinicIMG.image = UIImage (named: "ic_clinic")
        }else if appointmentModel?.consultationServiceFk == 2 {
            //"Video  Call Consultations"
            cell.clinicIMG.image = UIImage (named: "ic_video call")
        }else if appointmentModel?.consultationServiceFk == 3 {
            //"Home Visiting"
            cell.clinicIMG.image = UIImage (named: "ic_home_active")
        }else if appointmentModel?.consultationServiceFk == 4 {
            //"Immediate Video Call"
            cell.clinicIMG.image = UIImage (named: "ic_video call immediate-1")
        }
//        else if appointmentModel?.consultationServiceFk == 5 {
//            //"Text Consultations"
//            cell.clinicIMG.image = UIImage (named: "")
//        }else if appointmentModel?.consultationServiceFk == 6 {
//            //"Pharmaceutical Reps"
//            cell.clinicIMG.image = UIImage (named: "")
//        }
        
        //Cancel BTN
        if appointmentModel?.bookingStatus == 0 || appointmentModel?.bookingStatus == 1 || appointmentModel?.bookingStatus == 2 {
            cell.cancelBTN.isHidden = false
            cell.cancelBTN.setTitle("Cancel".localized, for: .normal)
        }else if appointmentModel?.bookingStatus == 5{
            cell.cancelBTN.isHidden = false
            cell.cancelBTN.setTitle("Rate".localized, for: .normal)
        }else if appointmentModel?.bookingStatus == 3 || appointmentModel?.bookingStatus == 4 || appointmentModel?.bookingStatus == 6 || appointmentModel?.videoStatus == 4 {
            cell.cancelBTN.isHidden = true
        }
        
        cell.cancelBTN.tag = indexPath.row
        cell.cancelBTN.addTarget(self, action: #selector(cancelAppointement(sender:)), for: .touchUpInside)
        
        //Accept BTN
//        if appointmentModel?.bookingStatus == 0 {
//            cell.startVideoBTN.isHidden = false
//            cell.startVideoConstraint.constant = 80
//            cell.startVideoBTN.setTitle("Accept".localized, for: .normal)
//        }else{
//            cell.startVideoBTN.isHidden = true
//        }
//        //Video BTN
//        if appointmentModel?.bookingStatus == 2 && appointmentModel?.meetingId != nil && appointmentModel?.videoStatus ?? 0 < 4{
//            cell.startVideoBTN.isHidden = true
//        }else{
//            if appointmentModel?.bookingStatus == 5 {
//                cell.startVideoBTN.isHidden = false
//                cell.startVideoConstraint.constant = 140
//                cell.startVideoBTN.setTitle("ConsultationLog", for: .normal)
//            }else{
//                cell.startVideoBTN.isHidden = false
//                cell.startVideoConstraint.constant = 140
//                cell.startVideoBTN.setTitle("StartingVideo", for: .normal)
//            }
//
//        }
        if appointmentModel?.consultationServiceFk == 2 {
            cell.startVideoBTN.isHidden = false
        } else {
            cell.startVideoBTN.isHidden = true
        }
        
        //Ready to call
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        let timeString = "\(hour)\(":")\(minutes)\(":")\(seconds)"
        let nowDate = self.dateFormatter.string(from: Date())
        let bookinDateString = self.dateFormatter.date(from: appointmentModel?.bookingDate ?? "")
        if bookinDateString != nil {
           let bookingDate = self.dateFormatter.string(from: bookinDateString!)
            if appointmentModel?.consultationServiceFk != nil && appointmentModel?.consultationServiceFk == 2 {
                if appointmentModel?.bookingStatus == 2 && appointmentModel?.meetingId == nil && nowDate >= bookingDate && timeString <= appointmentModel?.endTime ?? "" && (appointmentModel?.readyToStartVideo == nil || appointmentModel?.readyToStartVideo == false){
                    cell.startVideoBTN.isHidden = false
                    cell.startVideoBTN.setTitle("ReadyToCall".localized, for: .normal)
                    cell.startVideoConstraint.constant = 140
                }else{
                    cell.startVideoBTN.isHidden = true
                }
            }
        }else{
           let bookingDate = nowDate
            if appointmentModel?.consultationServiceFk != nil && appointmentModel?.consultationServiceFk == 2 {
                if appointmentModel?.bookingStatus == 2 && appointmentModel?.meetingId == nil && nowDate >= bookingDate && timeString <= appointmentModel?.endTime ?? "" && (appointmentModel?.readyToStartVideo == nil || appointmentModel?.readyToStartVideo == false){
                    cell.startVideoBTN.isHidden = false
                    cell.startVideoBTN.setTitle("ReadyToCall".localized, for: .normal)
                    cell.startVideoConstraint.constant = 140
                }else{
                    cell.startVideoBTN.isHidden = true
                }
            }

        }
        
        
        return cell
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
   
        
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.appointmentResponse?.message?[indexPath.row]
        print(model?.bookingStatus)
        if model?.bookingStatus == 0 || model?.bookingStatus == 1 || model?.bookingStatus == 2{
            let vc = AppointmentDetailsVC()
            vc.appointmentModel = self.appointmentResponse?.message?[indexPath.row]
            self.show(vc, sender: nil)
        }else if model?.bookingStatus == 3 || model?.bookingStatus == 4{
            let vc = AppointmentDetailsCancelVC()
            vc.appointmentModel = model
            vc.bookingID = model?.bookingId ?? 0
            self.show(vc, sender: nil)
        }else if model?.bookingStatus == 5{
            let vc = AppointmentDetailsTwoVC()
            vc.appointmentModel = model
            self.show(vc, sender: nil)
        }
    }
}

extension AppointmentVC {
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calenderHeight.constant = bounds.height
        self.view.layoutIfNeeded()
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did select date \(self.dateFormatter.string(from: date))")
        let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        print("selected dates is \(selectedDates)")
        let fDate = self.dateFormatter.string(from: date).replacedArabicDigitsWithEnglish
        
        let selectedDate = self.dateFormatter.string(from: date)
        let nowDate = self.dateFormatter.string(from: Date())
        self.date = selectedDate
        callApi(date: self.date)
    }
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("\(self.dateFormatter.string(from: calendar.currentPage))")
    }
    func showWarningAlert() {
        let image = #imageLiteral(resourceName: "ic_hospital")
//        showCustomAlerts(title: "Warning".localized, message: "You Must Select Date Higher Than Or Equal Today.".localized, image: image, selfDismissing: true, time: 10, backViewColor: #colorLiteral(red: 0.9992219806, green: 0.7472427487, blue: 0.2628330588, alpha: 1))
    }
}
