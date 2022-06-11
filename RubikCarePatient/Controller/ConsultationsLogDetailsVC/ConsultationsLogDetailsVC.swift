//
//  ConsultationsLogDetailsVC.swift
//  E4 Patient
//
//  Created by mohab on 09/05/2021.
//

import UIKit

class ConsultationsLogDetailsVC: UIViewController, BaseViewProtocol {
    
    var consultationDetailsViewModel = ConsultationsDetailsViewModel()
    
    var id: Int?
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return formatter
    }()
    
    let vw = UIView(frame: UIScreen.main.bounds)
    let indicator = UIActivityIndicatorView(style: .whiteLarge)
    @IBOutlet weak var bookingSummaryCollection: UICollectionView!
    @IBOutlet weak var clinicSummaryLbl: UILabel!
    @IBOutlet weak var diseasesLbl: UILabel!
    @IBOutlet weak var doctorName: UILabel!
    @IBOutlet weak var doctorImage: UIImageView!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var branchLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var consultationNameLbl: UILabel!
    @IBOutlet var dataView: UIView!
    @IBOutlet var diesesView: UIView!
    @IBOutlet var summaryView: UIView!
    @IBOutlet var medicationTableView: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Consultations Log".localized
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColor.Blue]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initBinding()
        consultationDetailsViewModel.getConsultationDetails(id: id ?? 0)
        
        dataView.ShadowView(view: dataView, radius: 10, opacity: 2, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        diesesView.ShadowView(view: diesesView, radius: 10, opacity: 2, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        summaryView.ShadowView(view: summaryView, radius: 10, opacity: 2, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        setupTableView()
        doctorImage.layer.cornerRadius = doctorImage.frame.width / 2
        
        bookingSummaryCollection.delegate = self
        bookingSummaryCollection.dataSource = self
        bookingSummaryCollection.register(UINib(nibName: "BookingSummaryCollection", bundle: nil), forCellWithReuseIdentifier: "BookingSummaryCollection")
        
    }
    func setupTableView(){
        medicationTableView.register(MedicationCell.nib, forCellReuseIdentifier: "MedicationCell")
        medicationTableView.separatorStyle = .none
        medicationTableView.delegate = self
        medicationTableView.dataSource = self
    }
    func initBinding() {
        consultationDetailsViewModel.isLoading.addObserver { [weak self] (isLoading) in
            guard let self = self else {return}
            if isLoading {
                self.showActivityIndicator(view: self.vw, indicator: self.indicator)
            } else {
                self.hideActivityIndicator(view: self.vw, indicator: self.indicator)
            }
        }
        consultationDetailsViewModel.reloadTableView.addObserver { [weak self] (isReload) in
            guard let self = self else {return}
            if isReload {
                DispatchQueue.main.async {
                    self.setData()
                    self.medicationTableView.reloadData()
                    self.bookingSummaryCollection.reloadData()
                }
            }
        }
        consultationDetailsViewModel.showError.addObserver { [weak self] (value) in
            guard let self = self else {return}
            if value != "" {
                DispatchQueue.main.async { self.showAlert(message: value) }
            }
        }
    }
    func setData() {
        let consultationData = consultationDetailsViewModel.consultationDetailsData
        self.consultationNameLbl.text = consultationData?.consultationService_localized ?? ""
        if let date = self.dateFormatter.date(from: consultationData?.bookingDate ?? "") {
            dateFormatter.dateFormat = "E, d MMM yyyy"
            print(date)
            self.dateLbl.text = dateFormatter.string(from: date)
        }
        let fromDate = consultationData?.startTime ?? ""
        let toTime = consultationData?.endTime ?? ""
        self.timeLbl.text = fromDate + " - " + toTime
        self.branchLbl.text = consultationData?.branchName_Localized ?? ""
        self.locationLbl.text = consultationData?.branchAddress_Localized ?? ""
        
        let imgURL = URL(string: "\(Constants.baseURLImage)\(consultationData?.profileImage ?? "")")
        self.doctorImage?.kf.indicatorType = .activity
        self.doctorImage?.kf.setImage(with: imgURL)
        Animation.roundView(self.doctorImage)
        self.doctorName.text = consultationData?.doctor_name ?? ""
        self.diseasesLbl.text = consultationData?.medicalService_localized ?? ""
        clinicSummaryLbl.text = consultationData?.bookingSummery ?? ""
    }
    @IBAction func buy_Click(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func add_click(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
extension ConsultationsLogDetailsVC: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return consultationDetailsViewModel.consultationDetailsData?.prescription?[0].tblPatientMedicine?.count ?? 0
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedicationCell", for: indexPath) as! MedicationCell
        cell.selectionStyle = .none
        
        let data = consultationDetailsViewModel.consultationDetailsData?.prescription?[0].tblPatientMedicine?[indexPath.row]
        let imgURL = URL(string: "\(Constants.baseURLImage)\(data?.medicineImagePath ?? "")")
               cell.medImage?.kf.indicatorType = .activity
               cell.medImage?.kf.setImage(with: imgURL)
        cell.nameLbl.text = data?.medicationName ?? ""
        cell.detailsOneLbl.text = data?.whenMedicationTakenName_Localized ?? ""
        cell.quantityLbl.text = data?.medicineStrenght ?? ""
        cell.repeatLbl.text = data?.durationTypetName_Localized ?? ""
        if let date = self.dateFormatter.date(from: data?.createDate ?? "") {
            dateFormatter.dateFormat = "E, d MMM yyyy"
            print(date)
            cell.dateLbl.text = dateFormatter.string(from: date)
        }

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
extension ConsultationsLogDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return consultationDetailsViewModel.consultationDetailsData?.bookingSummaryFiles?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookingSummaryCollection", for: indexPath) as! BookingSummaryCollection
        
        let imgURL = URL(string: "\(Constants.baseURLImage)\(consultationDetailsViewModel.consultationDetailsData?.bookingSummaryFiles?[indexPath.item].bookingSummaryFilesPath ?? "")")
        cell.summaryImage?.kf.indicatorType = .activity
        cell.summaryImage?.kf.setImage(with: imgURL)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
