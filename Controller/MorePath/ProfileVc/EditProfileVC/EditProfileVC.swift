//
//  EditProfileVC.swift
//  E4 Patient
//
//  Created by mohab on 18/01/2021.
//

import UIKit
import ImagePicker
import TransitionButton
class EditProfileVC: UIViewController,UITextFieldDelegate {
    @IBOutlet var mainView: UIView!
    @IBOutlet var dateTxt: UITextField!
    @IBOutlet var genderTxt: UITextField!
    @IBOutlet var fNameTxt: UITextField!
    @IBOutlet var lNameTxt: UITextField!
    @IBOutlet var phoneTxt: UITextField!
    @IBOutlet var emailTxt: UITextField!
    @IBOutlet var gennderTxt: UITextField!
    @IBOutlet var weightTxt: UITextField!
    @IBOutlet var heightTxt: UITextField!
    @IBOutlet var bloodTxt: UITextField!
    @IBOutlet var identityTxt: UITextField!
    @IBOutlet var saveBtn: TransitionButton!
    @IBOutlet var attachImage: UIImageView!
    @IBOutlet var codeLbl: UILabel!
    
    @IBOutlet var profileImage: UIImageView!
    let pickerView = ToolbarPickerView()
    let datePicker = UIDatePicker()
    let genderArr = [("male".localized, 1), ("female".localized, 0)]
    var genderType: Int?
    var model: UserDataModel?
    var isBlodPicker: Bool = false
    var blodModel: getBloodGroubModel?
    var BlodID: Int = 0
    var Delegete: isProfileEdit?
    var userImage = [UploadDataa]()
    var attachImagePath = [UploadDataa]()
    lazy var imageInstance = imagePickerHelper(viewController: self)
    lazy var attachimageInstance = imagePickerHelper(viewController: self)
    let token = UserDefaults.standard.object(forKey: "token")
    var profileImagePath: String = ""
    var attachmentImagePath: String = ""
    var headers: [String: String] = ["Content-Type": "multipart/form-data","lang": "2"]
    var isProfileImage: Bool = true
    var birthDate: Date?
    override func viewWillAppear(_ animated: Bool) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        bloodTxt.delegate = self
        genderTxt.delegate = self
        getBlodGroub()
        setUppicker()
        showDatePicker()
        self.navigationItem.title = "Basic Data".localized
        mainView.ShadowView(view: mainView, radius: 20, opacity: 0.4, shadowRadius: 4, color: UIColor.black.cgColor)
        loadData()
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
           if textField == bloodTxt {
            isBlodPicker = true
           }else if textField == genderTxt{
            isBlodPicker = false
           }
       }
    func loadData(){
        let userData  = model?.message
        BlodID = userData?.blodGroupFk ?? 0
        fNameTxt.text = userData?.patientFirstName
        lNameTxt.text = userData?.patientLastName
        phoneTxt.text =  "\(userData?.patientMobile ?? "")"
        codeLbl.text = "\(userData?.patientMobileCode ?? "")" 
        dateTxt.text = self.GetFormatedDate(date_string: userData?.patientBirthDate ?? "", dateFormat: "yyyy-MM-dd'T'HH:mm:ss")
        emailTxt.text = userData?.patientEmail
        weightTxt.text = "\(userData?.patientWeight ?? 0.0)"
        heightTxt.text = "\(userData?.patientHeight ?? 0.0)"
        if userData?.patientGender == 1{
            genderTxt.text = "male".localized
        }else{
            genderTxt.text = "female".localized
        }
        bloodTxt.text = userData?.blodGroupFkNavigation?.blodGroupNameEn
        identityTxt.text = userData?.patientIdentification
        let image = "\(Constants.baseURLImage)\(userData?.patientProfileImage ?? "")"
        let attachmentImage = "\(Constants.baseURLImage)\(userData?.attachedIDPath ?? "")"
        profileImage.kf.setImage(with: URL(string: image),placeholder: UIImage(named: "ProfileImage"))
        Animation.roundView(profileImage)
        attachImage.kf.setImage(with: URL(string: attachmentImage),placeholder: UIImage(named: "place holder"))
        genderType = userData?.patientGender
    }
    func setUppicker(){
//        if #available(iOS 14.0, *)
//        {
//            datePicker.preferredDatePickerStyle = .wheels
//        }
        self.genderTxt.inputView = self.pickerView
        self.genderTxt.inputAccessoryView = self.pickerView.toolbar
        self.bloodTxt.inputView = self.pickerView
        self.bloodTxt.inputAccessoryView = self.pickerView.toolbar
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        self.pickerView.toolbarDelegate = self
        self.pickerView.reloadAllComponents()
    }
    @IBAction func addAtachmentTxt(_ sender: Any) {
        isProfileImage = false
        attachimageInstance.presentImagePicker()
        attachimageInstance.imageSelected = {[weak self] selectedImage in
            guard let self = self else {return}
            self.attachImage.image = selectedImage
            self.attachImagePath.append(UploadDataa(data: selectedImage.jpegData(compressionQuality: 0.1)!, Key: "attachedIdPath"))
            if let token = self.token as? String {
            self.headers["Authorization"] = "Bearer \(token)"
                
            }
            AlamofireMultiPart.PostMultiWithModel(model: SuccessModelImage.self,
                                                  url: "\(Constants.baseURL)Common/FormDataUpload",
                                                  Images: self.attachImagePath ,
                                                  header: self.headers,
                                                  parameters: nil,
                                                  completion: self.ProfileImageNetwork)
        }
    }
    
    @IBAction func chooseImage_CLick(_ sender: Any) {
        isProfileImage = true
        imageInstance.presentImagePicker()
        imageInstance.imageSelected = {[weak self] selectedImage in
            guard let self = self else {return}
            
            self.userImage.append(UploadDataa(data: selectedImage.jpegData(compressionQuality: 0.1)!, Key: "PatientProfileImage"))
            self.profileImage.image = selectedImage

            if let token = self.token as? String {
                self.headers["Authorization"] = "Bearer \(token)"
            }
            showUniversalLoadingView(true)
            AlamofireMultiPart.PostMultiWithModel(model: SuccessModelImage.self,
                                                  url: "\(Constants.baseURL)Common/FormDataUpload",
                                                  Images: self.userImage ,
                                                  header: self.headers,
                                                  parameters: nil,
                                                  completion: self.ProfileImageNetwork)
        }
    }
    @IBAction func save_Click(_ sender: Any) {
        validationinput()
    }
    func GetFormatedDate(date_string:String,dateFormat:String)-> String{

       let dateFormatter = DateFormatter()
       dateFormatter.locale = Locale(identifier: "en_US_POSIX")
       dateFormatter.dateFormat = dateFormat

       let dateFromInputString = dateFormatter.date(from: date_string)
       dateFormatter.dateFormat = "yyyy-MM-dd"
       if(dateFromInputString != nil){
           return dateFormatter.string(from: dateFromInputString!)
       }
       else{
           debugPrint("could not convert date")
           return ""
       }
   }
    
}
protocol isProfileEdit {
    func Data(isAdded: Bool)
}
