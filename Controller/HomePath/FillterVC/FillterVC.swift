//
//  FillterVC.swift
//  E4 Patient
//
//  Created by mohab on 30/04/2021.
//

import UIKit
import DLRadioButton
import RangeSeekSlider

protocol sendFilterDataToBack: AnyObject {
    func sendFilterData(date: String?, medicalArray: [Int]?, subServiceArray: [Int]?, mainSpecialityId: Int?, gender: Int?, toPrice: String?, fromPrice: String?, allowCancellation: Bool?, prefixIdArray: [Int]?, professionalIdArray: [Int]?, type: String)
    func filterReset(type: String)
}

class FillterVC: UIViewController, BaseViewProtocol {
    
    weak var filterDelegate: sendFilterDataToBack?
    
    var selectedCancelation = true
    var selectedFees = true
    var selectedGender: String?
    var expandedGender = true
    
    var selectedAvailability = "today"
    var expandedAvailability = true
    
    @IBOutlet weak var priceRangeLbl: UILabel!
    @IBOutlet weak var medicalHeight: NSLayoutConstraint!
    @IBOutlet weak var medicalSeparatorView: UIView!
    @IBOutlet weak var medicalImageDropDown: UIImageView!
    @IBOutlet weak var medicalBtnView: UIView!
    @IBOutlet weak var medicalBGView: UIView!
    @IBOutlet weak var medicalTB: UITableView!
    
    @IBOutlet weak var subSpecialityHeight: NSLayoutConstraint!
    @IBOutlet weak var subSpecialitySeparatorView: UIView!
    @IBOutlet weak var subSpecialityImageDropDown: UIImageView!
    @IBOutlet weak var subSpecialityBtnView: UIView!
    @IBOutlet weak var subSpecialityBGView: UIView!
    @IBOutlet weak var subSpecialityTB: UITableView!
    
    @IBOutlet weak var mainSpecialityHeight: NSLayoutConstraint!
    @IBOutlet weak var mainSpecialitySeparatorView: UIView!
    @IBOutlet weak var mainSpecialityImageDropDown: UIImageView!
    @IBOutlet weak var mainSpecialityBtnView: UIView!
    @IBOutlet weak var mainSpecialityBGView: UIView!
    @IBOutlet weak var mainSpecialityTB: UITableView!
    
    @IBOutlet weak var professionalHeight: NSLayoutConstraint!
    @IBOutlet weak var professionalSeparatorView: UIView!
    @IBOutlet weak var professionalImageDropDown: UIImageView!
    @IBOutlet weak var professionalBtnView: UIView!
    @IBOutlet weak var professionalTitleBGView: UIView!
    @IBOutlet weak var professionalTitleTB: UITableView!
    @IBOutlet weak var prefixHeight: NSLayoutConstraint!
    @IBOutlet weak var prefixBGView: UIView!
    @IBOutlet weak var prefixBtnView: UIView!
    @IBOutlet weak var prefixSeparator: UIView!
    @IBOutlet weak var prefixDropDownImage: UIImageView!
    @IBOutlet weak var prefixTitleTB: UITableView!
    @IBOutlet weak var freeCancelationBtn: DLRadioButton!
    @IBOutlet weak var cancelationHeight: NSLayoutConstraint!
    @IBOutlet weak var cancelationBGView: UIView!
    @IBOutlet weak var cancelationBtnView: UIView!
    @IBOutlet weak var cancelationImage: UIImageView!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var feesHight: NSLayoutConstraint!
    @IBOutlet weak var rangeSeekSlider: RangeSeekSlider!
    @IBOutlet weak var consultationFeesStack: UIStackView!
        @IBOutlet weak var feesBGView: UIView!
    @IBOutlet weak var feesView: UIView!
    @IBOutlet weak var feesSeparatorView: UIView!
    @IBOutlet weak var feesDropDownImage: UIImageView!
    @IBOutlet weak var pricerangeLbl: UILabel!
    @IBOutlet weak var genderImage: UIImageView!
    @IBOutlet weak var genderBtnView: UIView!
    @IBOutlet weak var genderBgView: UIView!
    @IBOutlet weak var genderSeparator: UIView!
    @IBOutlet weak var genderStackView: UIStackView!
    @IBOutlet weak var genderHeightConst: NSLayoutConstraint!
    @IBOutlet weak var allGenderBtn: DLRadioButton!
    @IBOutlet weak var maleGenderBtn: DLRadioButton!
    @IBOutlet weak var femaleGenderBtn: DLRadioButton!
    
    @IBOutlet weak var selectDayBtn: DLRadioButton!
    @IBOutlet weak var tommorrowBtn: DLRadioButton!
    @IBOutlet weak var todayBtn: DLRadioButton!
    @IBOutlet weak var selectDayTF: TextField!
    @IBOutlet weak var avilabilitySeparatorView: UIView!
    @IBOutlet weak var avilabilityDropdownImage: UIImageView!
    @IBOutlet weak var avilabilityHeight: NSLayoutConstraint!
    @IBOutlet weak var stackAvilabilityView: UIStackView!
    @IBOutlet weak var availabilityBtnView: UIView!
    @IBOutlet var AvailabilityView: UIView!
    @IBOutlet weak var bgConst: NSLayoutConstraint!
    
    var mainSpecialityID: Int?
    var mainSpecialityIndex = 0
    var selectedmedicaServicesIndexArray = [Int]()
    var selectedsubServicesIndexArray = [Int]()
    
    var selectedPrefixIndexArray = [Int]()
    var selectedProfessionalIndexArray = [Int]()
    
    var allowCancelation: Bool?
    var fromPrice: String?
    var toPrice: String?
    var gender: Int?
    var date: String?
    
    let dateFormatter = DateFormatter()
    
    var filterViewModel = FilterViewModel()
    var vw = UIView(frame: UIScreen.main.bounds)
    var indicator = UIActivityIndicatorView(style: .whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBinding()
        rangeSeekSlider.delegate = self
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        prefixTitleTB.separatorStyle = .none
        prefixTitleTB.delegate = self
        prefixTitleTB.dataSource = self
        prefixTitleTB.register(UINib(nibName: "PrefixTitleTBCell", bundle: nil), forCellReuseIdentifier: "PrefixTitleTBCell")
        
        professionalTitleTB.separatorStyle = .none
        professionalTitleTB.delegate = self
        professionalTitleTB.dataSource = self
        professionalTitleTB.register(UINib(nibName: "PrefixTitleTBCell", bundle: nil), forCellReuseIdentifier: "PrefixTitleTBCell")
        
        mainSpecialityTB.separatorStyle = .none
        mainSpecialityTB.delegate = self
        mainSpecialityTB.dataSource = self
        mainSpecialityTB.register(UINib(nibName: "PrefixTitleTBCell", bundle: nil), forCellReuseIdentifier: "PrefixTitleTBCell")
        
        subSpecialityTB.separatorStyle = .none
        subSpecialityTB.delegate = self
        subSpecialityTB.dataSource = self
        subSpecialityTB.register(UINib(nibName: "PrefixTitleTBCell", bundle: nil), forCellReuseIdentifier: "PrefixTitleTBCell")
        
        medicalTB.separatorStyle = .none
        medicalTB.delegate = self
        medicalTB.dataSource = self
        medicalTB.register(UINib(nibName: "PrefixTitleTBCell", bundle: nil), forCellReuseIdentifier: "PrefixTitleTBCell")
        
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .date
        selectDayTF.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        

        setUI()
        filterViewModel.getPrefixTitle()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        medicalBtnView.layer.cornerRadius = 10
        subSpecialityBtnView.layer.cornerRadius = 10
        mainSpecialityBtnView.layer.cornerRadius = 10
        professionalBtnView.layer.cornerRadius = 10
        prefixBtnView.layer.cornerRadius = 10
        cancelationBtnView.layer.cornerRadius = 10
        feesView.layer.cornerRadius = 10
        genderBtnView.layer.cornerRadius = 10
        availabilityBtnView.layer.cornerRadius = 10
        AvailabilityView.ShadowView(view: AvailabilityView, radius: 10, opacity: 0.3, shadowRadius: 2, color: UIColor.darkGray.cgColor)
        genderBgView.ShadowView(view: genderBgView, radius: 10, opacity: 0.3, shadowRadius: 2, color: UIColor.darkGray.cgColor)
        feesBGView.ShadowView(view: feesBGView, radius: 10, opacity: 0.3, shadowRadius: 2, color: UIColor.darkGray.cgColor)
        cancelationBGView.ShadowView(view: cancelationBGView, radius: 10, opacity: 0.3, shadowRadius: 2, color: UIColor.darkGray.cgColor)
        prefixBGView.ShadowView(view: prefixBGView, radius: 10, opacity: 0.3, shadowRadius: 2, color: UIColor.darkGray.cgColor)
        professionalTitleBGView.ShadowView(view: professionalTitleBGView, radius: 10, opacity: 0.3, shadowRadius: 2, color: UIColor.darkGray.cgColor)
        mainSpecialityBGView.ShadowView(view: mainSpecialityBGView, radius: 10, opacity: 0.3, shadowRadius: 2, color: UIColor.darkGray.cgColor)
        subSpecialityBGView.ShadowView(view: subSpecialityBGView, radius: 10, opacity: 0.3, shadowRadius: 2, color: UIColor.darkGray.cgColor)
        medicalBGView.ShadowView(view: medicalBGView, radius: 10, opacity: 0.3, shadowRadius: 2, color: UIColor.darkGray.cgColor)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Fillter".localized
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColor.Blue]
    }
    func initBinding() {
        filterViewModel.isLoading.addObserver { [weak self] (isLoading) in
            guard let self = self else {return}
            if isLoading {
                self.showActivityIndicator(view: self.vw, indicator: self.indicator)
            } else {
                self.hideActivityIndicator(view: self.vw, indicator: self.indicator)
            }
        }
        filterViewModel.reloadPrefixTitleTB.addObserver { [weak self] (isReload) in
            guard let self = self else {return}
            if isReload {
                DispatchQueue.main.async { self.prefixTitleTB.reloadData()}
            }
        }
        filterViewModel.reloadProfessionalTitleTB.addObserver { [weak self] (isReload) in
            guard let self = self else {return}
            if isReload {
                DispatchQueue.main.async { self.professionalTitleTB.reloadData()}
            }
        }
        filterViewModel.reloadMedicalServicesTB.addObserver { [weak self] (isReload) in
            guard let self = self else {return}
            if isReload {
                DispatchQueue.main.async { self.medicalTB.reloadData()}
            }
        }
        filterViewModel.reloadmainSpecialityTB.addObserver { [weak self] (isReload) in
            guard let self = self else {return}
            if isReload {
                DispatchQueue.main.async { self.mainSpecialityTB.reloadData()
                    self.subSpecialityTB.reloadData()}
            }
        }
        filterViewModel.showError.addObserver { [weak self] (value) in
            guard let self = self else {return}
            if value != "" {
                DispatchQueue.main.async { self.showAlert(message: value) }
            }
        }
    }
    @objc func handleDatePicker(sender: UIDatePicker) {
        let date = dateFormatter.string(from: sender.date)
        selectDayTF.text = date
        self.date = date
    }
    func setUI() {
        selectedAvaikability()
        selectedFeesFun()
        selectedGenderFun()
        cancelationselected()
        prefixSelected()
        professionalSelected()
        mainSelected()
        subSelected()
        medicalSelcted()
    }
    @IBAction func avilabilityBtnPressed(_ sender: Any) {
        selectedAvaikability()
    }
    func selectedAvaikability() {
        expandedAvailability = !expandedAvailability
        if expandedAvailability {
            stackAvilabilityView.isHidden = false
            avilabilityHeight.constant = 142
            avilabilityDropdownImage.image = #imageLiteral(resourceName: "ic_next-1")
            avilabilitySeparatorView.isHidden = false
        } else {
            stackAvilabilityView.isHidden = true
            avilabilityHeight.constant = 40
            avilabilityDropdownImage.image = #imageLiteral(resourceName: "ic_next-2")
            avilabilitySeparatorView.isHidden = true
        }
    }
    @IBAction func selectDayBtnPressed(_ sender: Any) {
        selected(btn: selectDayBtn)
        unSelected(btn: tommorrowBtn)
        unSelected(btn: todayBtn)
    }
    @IBAction func tommorrowBtnPressed(_ sender: Any){
        date = dateFormatter.string(from: NSDate().addingTimeInterval(24 * 60 * 60) as Date)
        selected(btn: tommorrowBtn)
        unSelected(btn: todayBtn)
        unSelected(btn: selectDayBtn)
    }
    @IBAction func todayBtnPressed(_ sender: Any) {
        dateFormatter.timeZone = TimeZone.current
        date = dateFormatter.string(from: Date())
        
        selected(btn: todayBtn)
        unSelected(btn: tommorrowBtn)
        unSelected(btn: selectDayBtn)
    }
    
    @IBAction func genderBtnPressed(_ sender: Any) {
        selectedGenderFun()
    }
    func selectedGenderFun() {
        expandedGender = !expandedGender
        if expandedGender {
            genderStackView.isHidden = false
            genderHeightConst.constant = 142
            genderImage.image = #imageLiteral(resourceName: "ic_next-1")
            genderSeparator.isHidden = false
        } else {
            genderStackView.isHidden = true
            genderHeightConst.constant = 40
            genderImage.image = #imageLiteral(resourceName: "ic_next-2")
            genderSeparator.isHidden = true
        }
    }
    @IBAction func feesBtnPressed(_ sender: Any) {
        selectedFeesFun()
    }
    func selectedFeesFun() {
        selectedFees = !selectedFees
        if selectedFees {
            consultationFeesStack.isHidden = false
            feesHight.constant = 142
            feesDropDownImage.image = #imageLiteral(resourceName: "ic_next-1")
            feesSeparatorView.isHidden = false
        } else {
            consultationFeesStack.isHidden = true
            feesHight.constant = 40
            feesDropDownImage.image = #imageLiteral(resourceName: "ic_next-2")
            feesSeparatorView.isHidden = true
        }
    }
    @IBAction func allgenderBtnPressed(_ sender: Any) {
        gender = 0
        selected(btn: allGenderBtn)
        unSelected(btn: maleGenderBtn)
        unSelected(btn: femaleGenderBtn)
    }
    @IBAction func maleGenderBtnPressed(_ sender: Any) {
        gender = 1
        selected(btn: maleGenderBtn)
        unSelected(btn: femaleGenderBtn)
        unSelected(btn: allGenderBtn)
    }
    @IBAction func femaleGenderBtnPressed(_ sender: Any) {
        gender = 2
        selected(btn: femaleGenderBtn)
        unSelected(btn: allGenderBtn)
        unSelected(btn: maleGenderBtn)
    }
    func selected(btn: DLRadioButton) {
        btn.isSelected = true
        btn.setTitleColor(#colorLiteral(red: 0.07058823529, green: 0.4666666667, blue: 0.8196078431, alpha: 1), for: .normal)
    }
    func unSelected(btn: DLRadioButton) {
        btn.isSelected = false
        btn.setTitleColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: .normal)
    }
    @IBAction func cancelationBtnPressed(_ sender: Any) {
        cancelationselected()
    }
    var selected = true
    @IBAction func freeCancelationBtnpressed(_ sender: Any) {
        selected = !selected
        if selected {
            allowCancelation = false
            freeCancelationBtn.isSelected = false
        } else {
            freeCancelationBtn.isSelected = true
            allowCancelation = true
        }
    }
    func cancelationselected() {
       selectedCancelation = !selectedCancelation
       if selectedCancelation {
           freeCancelationBtn.isHidden = false
           cancelationHeight.constant = 85
           cancelationImage.image = #imageLiteral(resourceName: "ic_next-1")
           separatorView.isHidden = false
       } else {
           freeCancelationBtn.isHidden = true
           cancelationHeight.constant = 40
           cancelationImage.image = #imageLiteral(resourceName: "ic_next-2")
           separatorView.isHidden = true
       }
    }
    var selectedPrefix = true
    @IBAction func prefixBtnPressed(_ sender: Any) {
        prefixSelected()
    }
    func prefixSelected() {
        selectedPrefix = !selectedPrefix
        if selectedPrefix {
            prefixTitleTB.isHidden = false
            prefixHeight.constant = 250
            prefixDropDownImage.image = #imageLiteral(resourceName: "ic_next-1")
            prefixSeparator.isHidden = false
        } else {
            prefixTitleTB.isHidden = true
            prefixHeight.constant = 40
            prefixDropDownImage.image = #imageLiteral(resourceName: "ic_next-2")
            prefixSeparator.isHidden = true
        }
    }
    var selectedProfessional = true
    @IBAction func professionalTitleBtnPressed(_ sender: Any) {
        professionalSelected()
    }
    func professionalSelected() {
        selectedProfessional = !selectedProfessional
        if selectedProfessional {
            professionalTitleTB.isHidden = false
            professionalHeight.constant = 250
            professionalImageDropDown.image = #imageLiteral(resourceName: "ic_next-1")
            professionalSeparatorView.isHidden = false
        } else {
            professionalTitleTB.isHidden = true
            professionalHeight.constant = 40
            professionalImageDropDown.image = #imageLiteral(resourceName: "ic_next-2")
            professionalSeparatorView.isHidden = true
        }
    }
    var selectedMainSpeciality = true
    @IBAction func mainSpecialityBtnPressed(_ sender: Any) {
        mainSelected()
    }
    func mainSelected() {
        selectedMainSpeciality = !selectedMainSpeciality
        if selectedMainSpeciality {
            mainSpecialityTB.isHidden = false
            mainSpecialityHeight.constant = 250
            mainSpecialityImageDropDown.image = #imageLiteral(resourceName: "ic_next-1")
            mainSpecialitySeparatorView.isHidden = false
        } else {
            mainSpecialityTB.isHidden = true
            mainSpecialityHeight.constant = 40
            mainSpecialityImageDropDown.image = #imageLiteral(resourceName: "ic_next-2")
            mainSpecialitySeparatorView.isHidden = true
        }
    }
    var selectedSubSpeciality = true
    @IBAction func subSpecialityBtnPressed(_ sender: Any) {
        subSelected()
    }
    func subSelected() {
        selectedSubSpeciality = !selectedSubSpeciality
        if selectedSubSpeciality {
            subSpecialityTB.isHidden = false
            subSpecialityHeight.constant = 250
            subSpecialityImageDropDown.image = #imageLiteral(resourceName: "ic_next-1")
            subSpecialitySeparatorView.isHidden = false
        } else {
            subSpecialityTB.isHidden = true
            subSpecialityHeight.constant = 40
            subSpecialityImageDropDown.image = #imageLiteral(resourceName: "ic_next-2")
            subSpecialitySeparatorView.isHidden = true
        }
    }
    var selectedMedical = true
    @IBAction func medicalBtnPressed(_ sender: Any) {
        medicalSelcted()
    }
    func medicalSelcted() {
        selectedMedical = !selectedMedical
        if selectedMedical {
            medicalTB.isHidden = false
            medicalHeight.constant = 250
            medicalImageDropDown.image = #imageLiteral(resourceName: "ic_next-1")
            medicalSeparatorView.isHidden = false
        } else {
            medicalTB.isHidden = true
            medicalHeight.constant = 40
            medicalImageDropDown.image = #imageLiteral(resourceName: "ic_next-2")
            medicalSeparatorView.isHidden = true
        }
    }
    @IBAction func reset_Click(_ sender: Any) {
        self.filterDelegate?.filterReset(type: "All")
        navigationController?.popViewController(animated: true)
    }
    @IBAction func search_Click(_ sender: Any) {
        self.filterDelegate?.sendFilterData(date: date, medicalArray: selectedmedicaServicesIndexArray, subServiceArray: selectedsubServicesIndexArray, mainSpecialityId: mainSpecialityID, gender: gender, toPrice: toPrice, fromPrice: fromPrice, allowCancellation: allowCancelation, prefixIdArray: selectedPrefixIndexArray, professionalIdArray: selectedProfessionalIndexArray, type: "Filter")
        navigationController?.popViewController(animated: true)
    }
    

}

extension FillterVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == prefixTitleTB {
            return filterViewModel.prefixTitle?.message?.count ?? 0
        } else if tableView == professionalTitleTB{
            return filterViewModel.professionaltitle?.message?.count ?? 0
        } else if tableView == mainSpecialityTB{
            return filterViewModel.mainSpeciality?.message?.count ?? 0
        } else if tableView == subSpecialityTB{
            return filterViewModel.mainSpeciality?.message?[mainSpecialityIndex].inverseSpecialityParentFkNavigation?.count ?? 0
        } else {
            return filterViewModel.medicalServices?.message?.count ?? 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrefixTitleTBCell", for: indexPath) as! PrefixTitleTBCell
        if tableView == prefixTitleTB {
            cell.prefixTitleBtn.tag = indexPath.row
            cell.prefixTitleBtn.addTarget(self, action: #selector(selectedPrefixTitle(sender:)), for: .touchUpInside)
            cell.prefixTitleBtn.isSelected = false
            if selectedPrefixIndexArray.contains(filterViewModel.prefixTitle?.message?[indexPath.row].prefixTitleID ?? 0) {
                cell.prefixTitleBtn.isSelected = true
            }
            let title = filterViewModel.prefixTitle?.message?[indexPath.row].nameLocalized ?? ""
            cell.prefixTitleBtn.setTitle(title, for: .normal)
        } else if tableView == professionalTitleTB{
            cell.prefixTitleBtn.tag = indexPath.row
            cell.prefixTitleBtn.addTarget(self, action: #selector(selectedProfessionalTitle(sender:)), for: .touchUpInside)
            cell.prefixTitleBtn.isSelected = false
            if selectedProfessionalIndexArray.contains(filterViewModel.professionaltitle?.message?[indexPath.row].profisionalDetailsID ?? 0) {
                cell.prefixTitleBtn.isSelected = true
            }
            let title = filterViewModel.professionaltitle?.message?[indexPath.row].nameLocalized ?? ""
            cell.prefixTitleBtn.setTitle(title, for: .normal)
        } else if tableView == mainSpecialityTB {
            cell.prefixTitleBtn.tag = indexPath.row
            cell.prefixTitleBtn.addTarget(self, action: #selector(mainSpecialityBtnPressed(sender:)), for: .touchUpInside)
            if mainSpecialityIndex == indexPath.row {
                cell.prefixTitleBtn.isSelected = true
            } else {
                cell.prefixTitleBtn.isSelected = false
            }
            let title = filterViewModel.mainSpeciality?.message?[indexPath.row].nameLocalized ?? ""
            cell.prefixTitleBtn.setTitle(title, for: .normal)
        } else if tableView == subSpecialityTB {
            cell.prefixTitleBtn.tag = indexPath.row
            cell.prefixTitleBtn.addTarget(self, action: #selector(subServicesIndex(sender:)), for: .touchUpInside)
            cell.prefixTitleBtn.isSelected = false
            if selectedsubServicesIndexArray.contains(filterViewModel.mainSpeciality?.message?[mainSpecialityIndex].inverseSpecialityParentFkNavigation?[indexPath.row].specialityID ?? 0) {
                cell.prefixTitleBtn.isSelected = true
            }
            let title = filterViewModel.mainSpeciality?.message?[mainSpecialityIndex].inverseSpecialityParentFkNavigation?[indexPath.row].nameLocalized ?? ""
            cell.prefixTitleBtn.setTitle(title, for: .normal)
        } else {
            cell.prefixTitleBtn.tag = indexPath.row
            cell.prefixTitleBtn.addTarget(self, action: #selector(medicalServicesIndex(sender:)), for: .touchUpInside)
            cell.prefixTitleBtn.isSelected = false
            if selectedmedicaServicesIndexArray.contains(filterViewModel.medicalServices?.message?[indexPath.row].medicalServiceID ?? 0) {
                cell.prefixTitleBtn.isSelected = true
            }
            let title = filterViewModel.medicalServices?.message?[indexPath.row].nameLocalized ?? ""
            cell.prefixTitleBtn.setTitle(title, for: .normal)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 37
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        DispatchQueue.main.async() {
            scrollView.scrollIndicators.vertical?.backgroundColor = #colorLiteral(red: 0.2344345152, green: 0.5101650357, blue: 0.781674087, alpha: 1)
        }
    }
    @objc func mainSpecialityBtnPressed(sender: UIButton) {
        mainSpecialityIndex = sender.tag
        mainSpecialityID = filterViewModel.mainSpeciality?.message?[sender.tag].specialityID ?? 0
        self.selectedsubServicesIndexArray.removeAll()
        self.selectedmedicaServicesIndexArray.removeAll()
        self.subSpecialityTB.reloadData()
        self.mainSpecialityTB.reloadData()
        filterViewModel.getMedicalServices(id: mainSpecialityID ?? 0)
    }
    @objc func selectedPrefixTitle(sender: UIButton) {
        guard let prefixTitleId = filterViewModel.prefixTitle?.message?[sender.tag].prefixTitleID else {return}
        if selectedPrefixIndexArray.contains(prefixTitleId) {
            if let itemToRemoveIndex = selectedPrefixIndexArray.firstIndex(of: prefixTitleId) {
                selectedPrefixIndexArray.remove(at: itemToRemoveIndex)
            }
        } else {
            selectedPrefixIndexArray.append(prefixTitleId)
        }
        prefixTitleTB.reloadData()
    }
    @objc func selectedProfessionalTitle(sender: UIButton) {
        guard let professionalTitleId = filterViewModel.professionaltitle?.message?[sender.tag].profisionalDetailsID else {return}
        if selectedProfessionalIndexArray.contains(professionalTitleId) {
            if let itemToRemoveIndex = selectedProfessionalIndexArray.firstIndex(of: professionalTitleId) {
                selectedProfessionalIndexArray.remove(at: itemToRemoveIndex)
            }
        } else {
            selectedProfessionalIndexArray.append(professionalTitleId)
        }
        professionalTitleTB.reloadData()
    }
    @objc func medicalServicesIndex(sender: UIButton) {
        guard let medicalServiceId = filterViewModel.medicalServices?.message?[sender.tag].medicalServiceID else {return}
        if selectedmedicaServicesIndexArray.contains(medicalServiceId) {
            if let itemToRemoveIndex = selectedmedicaServicesIndexArray.firstIndex(of: medicalServiceId) {
                selectedmedicaServicesIndexArray.remove(at: itemToRemoveIndex)
            }
        } else {
            selectedmedicaServicesIndexArray.append(medicalServiceId)
        }
        medicalTB.reloadData()
    }
    @objc func subServicesIndex(sender: UIButton) {
        guard let subServiceId = filterViewModel.mainSpeciality?.message?[mainSpecialityIndex].inverseSpecialityParentFkNavigation?[sender.tag].specialityID else {return}
        if selectedsubServicesIndexArray.contains(subServiceId) {
            if let itemToRemoveIndex = selectedsubServicesIndexArray.firstIndex(of: subServiceId) {
                selectedsubServicesIndexArray.remove(at: itemToRemoveIndex)
            }
        } else {
            selectedsubServicesIndexArray.append(subServiceId)
        }
        subSpecialityTB.reloadData()
    }
}
extension UIScrollView {

    var scrollIndicators: (horizontal: UIView?, vertical: UIView?) {

        guard self.subviews.count >= 2 else {
            return (horizontal: nil, vertical: nil)
        }

        func viewCanBeScrollIndicator(view: UIView) -> Bool {
            let viewClassName = NSStringFromClass(type(of: view))
            if viewClassName == "_UIScrollViewScrollIndicator" || viewClassName == "UIImageView" {
                return true
            }
            return false
        }

        let horizontalScrollViewIndicatorPosition = self.subviews.count - 2
        let verticalScrollViewIndicatorPosition = self.subviews.count - 1

        var horizontalScrollIndicator: UIView?
        var verticalScrollIndicator: UIView?

        let viewForHorizontalScrollViewIndicator = self.subviews[horizontalScrollViewIndicatorPosition]
        if viewCanBeScrollIndicator(view: viewForHorizontalScrollViewIndicator) {
            horizontalScrollIndicator = viewForHorizontalScrollViewIndicator.subviews[0]
        }

        let viewForVerticalScrollViewIndicator = self.subviews[verticalScrollViewIndicatorPosition]
        if viewCanBeScrollIndicator(view: viewForVerticalScrollViewIndicator) {
            verticalScrollIndicator = viewForVerticalScrollViewIndicator.subviews[0]
        }
        return (horizontal: horizontalScrollIndicator, vertical: verticalScrollIndicator)
    }

}
extension FillterVC: RangeSeekSliderDelegate {

    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        if slider === rangeSeekSlider {
            print("Custom slider updated. Min Value: \(minValue) Max Value: \(maxValue)")
            self.fromPrice = "\(Int(minValue))"
            self.toPrice = "\(Int(maxValue))"
        }
    }

    func didStartTouches(in slider: RangeSeekSlider) {
        print("did start touches")
    }

    func didEndTouches(in slider: RangeSeekSlider) {
        print("did end touches")
        priceRangeLbl.text = "\(fromPrice ?? "0") - \(toPrice ?? "2000") EGP"
    }
}
