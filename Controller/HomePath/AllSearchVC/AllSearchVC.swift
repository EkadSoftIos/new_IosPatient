//
//  AllSearchVC.swift
//  E4 Patient
//
//  Created by mohab on 30/04/2021.
//

import UIKit

class AllSearchVC: UIViewController, BaseViewProtocol, UISearchBarDelegate {
    
    var allSearchViewModel = AllSearchViewModel()
    var searchtext = ""
    var type = "All"
    var sortType: Int?
    
    var mainSpecialityID: Int?
    var selectedmedicaServicesIndexArray = [Int]()
    var selectedsubServicesIndexArray = [Int]()
    
    var selectedPrefixIndexArray = [Int]()
    var selectedProfessionalIndexArray = [Int]()
    
    var consultationServiceId: Int?
    var allowCancelation: Bool?
    var fromPrice: String?
    var toPrice: String?
    var gender: Int?
    var date: String?
    
    var lat: String?
    var lng: String?
    var distance = 10
    var cityId: Int?
    var areaId: Int?
    
    @IBOutlet weak var cityViewConstraint: NSLayoutConstraint!
//    @IBOutlet weak var filterViewConstraint: NSLayoutConstraint!
//    @IBOutlet weak var sortViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var cityView: UIView!
    @IBOutlet var fillterView: UIView!
    @IBOutlet var sortView: UIView!
    @IBOutlet var searchTableView: UITableView!
    @IBOutlet var noDataView: UIView!
    @IBOutlet var noDataLBL: UILabel!
    
//    var model: HomeModel?
    var vw = UIView(frame: UIScreen.main.bounds)
    var indicator = UIActivityIndicatorView(style: .whiteLarge)
    override func viewDidLoad() {
        super.viewDidLoad()
        initBinding()
        searchBar.delegate = self
//        if mainSpecialityID != nil {
            type = "Filter"
            allSearchViewModel.filterDoctors(ConsultationServiceId: consultationServiceId, date: date, medicalArray: selectedmedicaServicesIndexArray, subServiceArray: selectedsubServicesIndexArray, mainSpecialityId: mainSpecialityID, gender: gender, toPrice: toPrice, fromPrice: fromPrice, allowCancellation: allowCancelation, prefixIdArray: selectedPrefixIndexArray, professionalIdArray: selectedProfessionalIndexArray, sortType: sortType, lat: lat, lng: lng, cityId: cityId, areaId: areaId)
//        }else{
//            allSearchViewModel.getAllDoctor()
//        }
        cityView.ShadowView(view: cityView, radius: 8, opacity: 0.2, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        fillterView.ShadowView(view: fillterView, radius: 8, opacity: 0.2, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        sortView.ShadowView(view: sortView, radius: 8, opacity: 0.2, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        mapView.ShadowView(view: mapView, radius: 8, opacity: 0.2, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        setTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Search".localized
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColor.Blue]
        if consultationServiceId == 1 || consultationServiceId == 3{
            cityViewConstraint.constant = 150
//            filterViewConstraint.constant = 94
//            sortViewConstraint.constant = 94
        }else{
            cityViewConstraint.constant = 0
//            filterViewConstraint.constant = 170
//            sortViewConstraint.constant = 170
        }
        self.searchBar.text = searchtext
        
    }
    func initBinding() {
        allSearchViewModel.isLoading.addObserver { [weak self] (isLoading) in
            guard let self = self else {return}
            if isLoading {
                self.showActivityIndicator(view: self.vw, indicator: self.indicator)
            } else {
                self.hideActivityIndicator(view: self.vw, indicator: self.indicator)
            }
        }
        allSearchViewModel.reloadDoctorSearchTB.addObserver { [weak self] (isReload) in
            guard let self = self else {return}
            if isReload {
                if self.searchBar.text == "" {
                    self.noDataView.isHidden = true
                    DispatchQueue.main.async { self.searchTableView.reloadData()}
                }else{
                    self.allSearchViewModel.filteredDoctorsearch = self.allSearchViewModel.filterDoctors.filter({ (doctor) -> Bool in
                    guard let searchTxt = self.searchBar.text else {return false}
                    return (doctor.doctorName!.lowercased().contains(searchTxt.lowercased()))
                            })
                    if self.allSearchViewModel.filteredDoctorsearch.count == 0 {
                        self.noDataView.isHidden = false
                    }else{
                        self.noDataView.isHidden = true
                    }
                    self.searchTableView.reloadData()
                }
            }
        }
        allSearchViewModel.showError.addObserver { [weak self] (value) in
            guard let self = self else {return}
            if value != "" {
                DispatchQueue.main.async { self.showAlert(message: value) }
            }
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if type == "All" {
                if searchText.isEmpty {
                    self.allSearchViewModel.filteredDoctors = self.allSearchViewModel.doctorSearch
                    if self.allSearchViewModel.filteredDoctors.count == 0 {
                        noDataView.isHidden = false
                    }else{
                        noDataView.isHidden = true
                    }
                    self.searchTableView.reloadData()
                } else {
                    self.allSearchViewModel.filteredDoctors = self.allSearchViewModel.doctorSearch.filter({ (doctor) -> Bool in
                    guard let searchTxt = self.searchBar.text else {return false}
                    return (doctor.doctorName!.lowercased().contains(searchTxt.lowercased()))
                            })
                    if self.allSearchViewModel.filteredDoctors.count == 0 {
                        noDataView.isHidden = false
                    }else{
                        noDataView.isHidden = true
                    }
                    self.searchTableView.reloadData()
                }
            } else {
                if searchText.isEmpty {
                    self.allSearchViewModel.filteredDoctorsearch = self.allSearchViewModel.filterDoctors
                    if self.allSearchViewModel.filteredDoctorsearch.count == 0 {
                        noDataView.isHidden = false
                    }else{
                        noDataView.isHidden = true
                    }
                    self.searchTableView.reloadData()
                } else {
                    self.allSearchViewModel.filteredDoctorsearch = self.allSearchViewModel.filterDoctors.filter({ (doctor) -> Bool in
                    guard let searchTxt = self.searchBar.text else {return false}
                    return (doctor.doctorName!.lowercased().contains(searchTxt.lowercased()))
                            })
                    if self.allSearchViewModel.filteredDoctorsearch.count == 0 {
                        noDataView.isHidden = false
                    }else{
                        noDataView.isHidden = true
                    }
                    self.searchTableView.reloadData()
                }
            }
    }
    func setTableView(){
        searchTableView.register(AllSearchCell.nib, forCellReuseIdentifier: "AllSearchCell")
        searchTableView.dataSource = self
        searchTableView.delegate = self
        searchTableView.separatorStyle = .none
    }
    @IBAction func chooseCity_Click(_ sender: Any) {
        let vc = CityFilterVC()
        vc.locationDelegate = self
        self.show(vc, sender: nil)
    }
    
    @IBAction func fillter_Click(_ sender: Any) {
        let vc = FillterVC()
        vc.filterDelegate = self
        self.show(vc, sender: nil)
        
    }
    @IBAction func sort_Click(_ sender: Any) {
        let vc = SortVC()
        vc.sortDelegate = self
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func map_Click(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MapFilterVC") as! MapFilterVC
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension AllSearchVC: sendFilterDataToBack, SortDelegate, FilterWithLocation {
    func filterWithLocation(lat: String?, lng: String?, areaId: Int?, cityId: Int?) {
        self.lat = lat
        self.lng = lng
        self.areaId = areaId
        self.cityId = cityId
        
        allSearchViewModel.filterDoctors(ConsultationServiceId: consultationServiceId, date: date, medicalArray: selectedmedicaServicesIndexArray, subServiceArray: selectedsubServicesIndexArray, mainSpecialityId: mainSpecialityID, gender: gender, toPrice: toPrice, fromPrice: fromPrice, allowCancellation: allowCancelation, prefixIdArray: selectedPrefixIndexArray, professionalIdArray: selectedProfessionalIndexArray, sortType: sortType, lat: lat, lng: lng, cityId: cityId, areaId: areaId)
    }
    
    func sort(id: Int) {
        self.sortType = id
        allSearchViewModel.filterDoctors(ConsultationServiceId: consultationServiceId, date: date, medicalArray: selectedmedicaServicesIndexArray, subServiceArray: selectedsubServicesIndexArray, mainSpecialityId: mainSpecialityID, gender: gender, toPrice: toPrice, fromPrice: fromPrice, allowCancellation: allowCancelation, prefixIdArray: selectedPrefixIndexArray, professionalIdArray: selectedProfessionalIndexArray, sortType: sortType, lat: lat, lng: lng, cityId: cityId, areaId: areaId)
    }
    func resetSort() {
         self.sortType = nil
        allSearchViewModel.filterDoctors(ConsultationServiceId: consultationServiceId, date: date, medicalArray: selectedmedicaServicesIndexArray, subServiceArray: selectedsubServicesIndexArray, mainSpecialityId: mainSpecialityID, gender: gender, toPrice: toPrice, fromPrice: fromPrice, allowCancellation: allowCancelation, prefixIdArray: selectedPrefixIndexArray, professionalIdArray: selectedProfessionalIndexArray, sortType: sortType, lat: lat, lng: lng, cityId: cityId, areaId: areaId)
    }
    func sendFilterData(date: String?, medicalArray: [Int]?, subServiceArray: [Int]?, mainSpecialityId: Int?, gender: Int?, toPrice: String?, fromPrice: String?, allowCancellation: Bool?, prefixIdArray: [Int]?, professionalIdArray: [Int]?, type: String) {
        self.type = type
        self.date = date
        self.selectedmedicaServicesIndexArray = medicalArray ?? []
        self.selectedsubServicesIndexArray = subServiceArray ?? []
        self.mainSpecialityID = mainSpecialityId
        self.gender = gender
        self.toPrice = toPrice
        self.fromPrice = fromPrice
        self.allowCancelation = allowCancellation
        self.selectedPrefixIndexArray = prefixIdArray ?? []
        self.selectedProfessionalIndexArray = professionalIdArray ?? []
        
        allSearchViewModel.filterDoctors(ConsultationServiceId: consultationServiceId, date: date, medicalArray: selectedmedicaServicesIndexArray, subServiceArray: selectedsubServicesIndexArray, mainSpecialityId: mainSpecialityID, gender: gender, toPrice: toPrice, fromPrice: fromPrice, allowCancellation: allowCancelation, prefixIdArray: selectedPrefixIndexArray, professionalIdArray: selectedProfessionalIndexArray, sortType: sortType, lat: lat, lng: lng, cityId: cityId, areaId: areaId)
    }
    
    func filterReset(type: String) {
        self.type = type
        self.date = nil
        self.selectedmedicaServicesIndexArray = []
        self.selectedsubServicesIndexArray = []
        self.mainSpecialityID = nil
        self.gender = nil
        self.toPrice = nil
        self.fromPrice = nil
        self.allowCancelation = nil
        self.selectedPrefixIndexArray = []
        self.selectedProfessionalIndexArray = []
        
        self.lat = nil
        self.lng = nil
        self.areaId = nil
        self.cityId = nil
        
        allSearchViewModel.getAllDoctor()
    }
}
