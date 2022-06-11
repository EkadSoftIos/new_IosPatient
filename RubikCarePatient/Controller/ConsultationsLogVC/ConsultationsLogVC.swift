//
//  ConsultationsLogVC.swift
//  E4 Patient
//
//  Created by mohab on 09/05/2021.
//

import UIKit

class ConsultationsLogVC: UIViewController, BaseViewProtocol, UISearchBarDelegate {
    
    var consultationLogViewModel = ConsultationLogViewModel()
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return formatter
    }()
    
    var fromDate: String?
    var toDate: String?
    var consultationServiceFK: Int?
    
    let vw = UIView(frame: UIScreen.main.bounds)
    let indicator = UIActivityIndicatorView(style: .whiteLarge)
    @IBOutlet var fillterView: UIView!
    @IBOutlet weak var searchTF: UISearchBar!
    @IBOutlet var ConsultationsTableView: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Consultations Log".localized
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColor.Blue]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initBinding()
        consultationLogViewModel.getConsultation(bookingStatus: [5], fromDate: fromDate, toDate: toDate, consultationFK: consultationServiceFK)
        
        searchTF.delegate = self
        
        fillterView.ShadowView(view: fillterView, radius: 10, opacity: 2, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        setupTableView()
        // Do any additional setup after loading the view.
    }
    func initBinding() {
        consultationLogViewModel.isLoading.addObserver { [weak self] (isLoading) in
            guard let self = self else {return}
            if isLoading {
                self.showActivityIndicator(view: self.vw, indicator: self.indicator)
            } else {
                self.hideActivityIndicator(view: self.vw, indicator: self.indicator)
            }
        }
        consultationLogViewModel.reloadTableView.addObserver { [weak self] (isReload) in
            guard let self = self else {return}
            if isReload {
                DispatchQueue.main.async {
                    self.ConsultationsTableView.reloadData()
                }
            }
        }
        consultationLogViewModel.showError.addObserver { [weak self] (value) in
            guard let self = self else {return}
            if value != "" {
                DispatchQueue.main.async { self.showAlert(message: value) }
            }
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.consultationLogViewModel.filteredConsultationData = self.consultationLogViewModel.consultationData
            self.ConsultationsTableView.reloadData()
        } else {
            self.consultationLogViewModel.filteredConsultationData = self.consultationLogViewModel.consultationData.filter({ (doctor) -> Bool in
            guard let searchTxt = self.searchTF.text else {return false}
            return (doctor.doctor_name!.lowercased().contains(searchTxt.lowercased()))
                    })
            self.ConsultationsTableView.reloadData()
        }
    }
    func setupTableView(){
        ConsultationsTableView.register(ConsultationsLogCell.nib, forCellReuseIdentifier: "ConsultationsLogCell")
        ConsultationsTableView.delegate = self
        ConsultationsTableView.dataSource = self
        ConsultationsTableView.separatorStyle = .none
    }
    @IBAction func filler_Clic(_ sender: Any) {
        let vc = ConsultationsLogFillterVC()
        vc.filterConsultationDelegate = self
        self.show(vc, sender: nil)
    }
    
 

}
extension ConsultationsLogVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return consultationLogViewModel.filteredConsultationData.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConsultationsLogCell") as! ConsultationsLogCell
        cell.selectionStyle = .none
        
        let imgURL = URL(string: "\(Constants.baseURLImage)\(consultationLogViewModel.filteredConsultationData[indexPath.row].profileImage ?? "")")
        cell.doctorImg?.kf.indicatorType = .activity
        cell.doctorImg?.kf.setImage(with: imgURL)
        Animation.roundView(cell.doctorImg)
        cell.doctorName.text = consultationLogViewModel.filteredConsultationData[indexPath.row].doctor_name ?? ""
        cell.clinicName.text = consultationLogViewModel.filteredConsultationData[indexPath.row].consultationService_localized ?? ""
        
        if let date = self.dateFormatter.date(from: consultationLogViewModel.filteredConsultationData[indexPath.row].bookingDate ?? "") {
            dateFormatter.dateFormat = "E, d MMM yyyy"
            print(date)
            cell.dateLbl.text = dateFormatter.string(from: date)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ConsultationsLogDetailsVC()
        vc.id = consultationLogViewModel.filteredConsultationData[indexPath.row].bookingId ?? 0
        self.show(vc, sender: nil)
    }
}
extension ConsultationsLogVC: FilterConsultationDelegate {
    func filterConsultation(fromDate: String?, toDate: String?, consultationServiceFK: Int?) {
        self.fromDate = fromDate
        self.toDate = toDate
        self.consultationServiceFK = consultationServiceFK
        consultationLogViewModel.getConsultation(bookingStatus: [5], fromDate: fromDate, toDate: toDate, consultationFK: consultationServiceFK)
    }
}
