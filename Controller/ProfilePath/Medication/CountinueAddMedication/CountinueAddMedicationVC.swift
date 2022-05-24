//
//  CountinueAddMedicationVC.swift
//  E4 Patient
//
//  Created by mohab on 20/01/2021.
//

import UIKit
import TransitionButton
class CountinueAddMedicationVC: UIViewController,UITextFieldDelegate,UITextViewDelegate, UISearchBarDelegate {
    @IBOutlet var medicalView: UIView!
    @IBOutlet var dosageView: UIView!
    @IBOutlet var dosageHeightView: NSLayoutConstraint!
    @IBOutlet var otherView: UIView!
    @IBOutlet var otherHeight: NSLayoutConstraint!
    @IBOutlet var MedicationImage: UIImageView!
    @IBOutlet var MedicationaboutLbl: UILabel!
    @IBOutlet var MedicationNameLbl: UILabel!
    @IBOutlet var MedicationTapLbl: UILabel!
    @IBOutlet var quantityTxt: TextField!
    @IBOutlet var whenTxt: UITextField!
    @IBOutlet var FrequencyTxt: TextField!
    @IBOutlet var durationTxt: UITextField!
    @IBOutlet var instractionsTxt: UITextView!
  //  @IBOutlet var byDoctorTxt: UITextField!
    @IBOutlet var saveBtn: TransitionButton!
    @IBOutlet var doctorsTableView: UITableView!
    @IBOutlet var doctorsView: UIView!
    @IBOutlet var doctorsViewHeight: NSLayoutConstraint!
    @IBOutlet var searchBar: UISearchBar!
    
    
    @IBOutlet weak var aboutLBL: UILabel!
    @IBOutlet weak var dosageLBL: UILabel!
    @IBOutlet weak var quantityLBL: UILabel!
    @IBOutlet weak var whenLBL: UILabel!
    @IBOutlet weak var durationLBL: UILabel!
    @IBOutlet weak var dayLBL: UIStackView!
    @IBOutlet weak var otherInstructionLBL: UILabel!
    
    @IBOutlet weak var givenLBL: UILabel!
    
    let datePicker = UIDatePicker()
    var Medicationmodel: AllMedicineMessage?
    var updateData: TblPatientMedicine?
    var isUpdate: Bool = false
    var Delegete: addmedication?
    var model: UserDataModel?
    var isFromDate: Bool = true
    var whenModel: getwhenModel?
    let whenPickerView = UIPickerView()
    let durationPickerView = UIPickerView()
    var whenId: Int = 0
    var duratiionId: Int = 0
    var durantionType: String = ""
    var doctorsModel: GetDoctorsModel?
    var doctorId: Int = 0
    let durationArr = [("Day".localized, 1, "duration_day"), ("Week".localized, 2 , "duration_week"), ("Month".localized, 3, "duration_month"), ("Year".localized, 4 , "duration_year")]
    var searchArr = [GetDoctorsMessage]()
    override func viewWillAppear(_ animated: Bool) {
        setLocalization()
    }
    func setLocalization()
    {
        aboutLBL.text = "About".localized
        dosageLBL.text = "Dosage".localized
        quantityLBL.text = "Quantity *".localized
        quantityTxt.placeholder = "Quantity".localized
        whenLBL.text = "When *".localized
        whenTxt.placeholder = "When".localized
        durationLBL.text = "Duration".localized
        FrequencyTxt.placeholder = "Duration".localized
        durationTxt.placeholder = "Day".localized
        otherInstructionLBL.text = "Other Instruction".localized
        givenLBL.text = "Given by Doctor".localized
        saveBtn.setTitle("Save".localized, for: .normal)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("isupdate:\(isUpdate)")
        instractionsTxt.text = "Other Instruction".localized
        instractionsTxt.textColor = UIColor.lightGray
        instractionsTxt.delegate = self
        searchBar.delegate = self
        doctorsView.ShadowView(view: doctorsView, radius: 10, opacity: 0.4, shadowRadius: 4, color: UIColor.lightGray.cgColor)
        searchBar.backgroundColor = .white
        searchBar.layer.borderColor = UIColor.lightGray.cgColor
        searchBar.compatibleSearchTextField.textColor = UIColor.black
        searchBar.compatibleSearchTextField.backgroundColor = UIColor.white
        setDoctorsView()
        SetUpTableView()
        setupView()
        getDoctors()
        setData()
        setUpPickerView()
        getwhenData()
      
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Other Instruction".localized
            textView.textColor = UIColor.lightGray
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.setDoctorsView()
        }else{
        searchArr = searchText.isEmpty ? doctorsModel?.message ?? []: doctorsModel?.message.filter { (item: (GetDoctorsMessage)) -> Bool in
            return item.employeeName?.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            
        } ?? []
            if searchArr.count != 0{
            self.setDoctorsView(isShow: false, height: 480, ViewHeight: 150)
            self.doctorsTableView.reloadData()
            self.view.layoutIfNeeded()
            doctorsTableView.reloadData()
            }else{
                self.setDoctorsView()
            }
        }
    }

    func SetUpTableView(){
        doctorsTableView.register(DoctorsSearchCell.nib, forCellReuseIdentifier: "doctorsCell")
        doctorsTableView.separatorStyle = .none
        doctorsTableView.delegate = self
        doctorsTableView.dataSource = self
    }
        func setDoctorsView(isShow: Bool = true, height: CGFloat = 200, ViewHeight: CGFloat = 0){
            UIView.animate(withDuration: 1) {
                self.doctorsView.isHidden = isShow
                self.doctorsTableView.isHidden = isShow
                self.otherHeight.constant = height
                self.doctorsViewHeight.constant = ViewHeight
                self.view.layoutIfNeeded()
            }
      
    }
    func setUpPickerView(){
        whenPickerView.dataSource = self
        whenPickerView.delegate = self
        whenTxt.inputView = whenPickerView
        createDoneBtn(for: whenTxt)
        durationPickerView.dataSource = self
        durationPickerView.delegate = self
        durationTxt.inputView = durationPickerView
        createDoneBtn(for: durationTxt)
    }
    func createDoneBtn (for textField : UITextField)
    {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action:#selector(donePressedOfPickerView))
        toolbar.setItems([done], animated: true)
        textField.inputAccessoryView = toolbar
    }
    @objc func donePressedOfPickerView()
    {
        self.view.endEditing(true)
    }
    func setData(){
        if isUpdate == true{
            searchBar.text = updateData?.doctorName
            durationTxt.text = updateData?.durationTypetNameLocalized
            whenTxt.text = updateData?.whenMedicationTakenNameLocalized
            whenId = updateData?.whenMedicationTakenFk ?? 0
            duratiionId = updateData?.durationType ?? 0
            self.navigationItem.title = updateData?.medicationName
            MedicationaboutLbl.text = updateData?.medicinAboutLocalized
            MedicationNameLbl.text = updateData?.medicationName
            quantityTxt.text = "\(updateData?.quantity ?? 0)"
            whenTxt.text = updateData?.whenTake
          //  FrequencyTxt.text = "\(updateData?.frequencyValue ?? 0)"
            doctorId = updateData?.businessProviderEmployeeFk ?? 0
            instractionsTxt.text  = updateData?.notes
            let image = "\(Constants.baseURLImage)\(updateData?.medicineImagePath ?? "")"
            MedicationImage.kf.setImage(with: URL(string: image),placeholder: UIImage(named: "BarLogo"))
            FrequencyTxt.text = "\(updateData?.durationValue ?? 0)"
            print("gggg: \(updateData)")
            if updateData?.notes != ""{
                instractionsTxt.textColor = .black
            }
        }else{
            self.navigationItem.title = Medicationmodel?.medicationName
            MedicationNameLbl.text = Medicationmodel?.medicationName
            MedicationaboutLbl.text = Medicationmodel?.medicinAboutLocalized
            let image = "\(Constants.baseURLImage)\(Medicationmodel?.medicineImagePath ?? "")"
            MedicationImage.kf.setImage(with: URL(string: image),placeholder: UIImage(named: "BarLogo"))
        }
    }
    func setupView(){
        dosageView.ShadowView(view: dosageView, radius: 10, opacity: 0.4, shadowRadius: 4, color: UIColor.lightGray.cgColor)
        medicalView.ShadowView(view: medicalView, radius: 10, opacity: 0.4, shadowRadius: 4, color: UIColor.lightGray.cgColor)
        otherView.ShadowView(view: otherView, radius: 10, opacity: 0.4, shadowRadius: 4, color: UIColor.lightGray.cgColor)
        
        self.dosageHeightView.constant = 200
    }
    
    @IBAction func save_CLick(_ sender: Any) {
        ValidateionInput()
    }
    func getwhenData() {
        NetworkClient.performRequest(_type: getwhenModel.self, router: .whenMedication) { [weak self] (result) in
            guard let self = self else {return}
            showUniversalLoadingView(false)
            
            switch result {
            case .success(let model) :
                if model.successtate == 200 {
                    self.whenModel = model
                    self.updateRelationUI()
                }
                else{
                    self.showAlertWith(msg: model.errormessage ?? "")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    func updateRelationUI() {
        whenPickerView.reloadComponent(0)
     
    }
}
protocol addmedication {
    func Data(isAdded: Bool, isupdate: Bool)
}
extension UISearchBar {

    // Due to searchTextField property who available iOS 13 only, extend this property for iOS 13 previous version compatibility
    var compatibleSearchTextField: UITextField {
        guard #available(iOS 13.0, *) else { return legacySearchField }
        return self.searchTextField
    }

    private var legacySearchField: UITextField {
        if let textField = self.subviews.first?.subviews.last as? UITextField {
            // Xcode 11 previous environment
            textField.backgroundColor = .red
            return textField
        } else if let textField = self.value(forKey: "searchField") as? UITextField {
            // Xcode 11 run in iOS 13 previous devices
            textField.backgroundColor = .red
            return textField
        } else {
            // exception condition or error handler in here
            return UITextField()
        }
    }
}
