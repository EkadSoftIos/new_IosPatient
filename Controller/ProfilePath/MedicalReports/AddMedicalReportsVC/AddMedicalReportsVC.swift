//
//  AddMedicalReportsVC.swift
//  E4 Patient
//
//  Created by mohab on 23/01/2021.
//

import UIKit
import TransitionButton
//import ImagePicker
import MobileCoreServices
class AddMedicalReportsVC: UIViewController, UITextViewDelegate,UISearchBarDelegate {
    @IBOutlet var mainView: UIView!
    @IBOutlet var nameTxt: UITextField!
    @IBOutlet var dateTxt: UITextField!
    @IBOutlet var resultTxt: UITextView!
    @IBOutlet var resultImage: UIImageView!
    @IBOutlet var notesTxt: UITextView!
  //  @IBOutlet var prescribedTxt: UITextField!
    @IBOutlet var testTxt: UITextField!
    @IBOutlet var saveBtn: TransitionButton!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var searchView: UIView!
    @IBOutlet var searchTable: UITableView!
    @IBOutlet var searchViewHeight: NSLayoutConstraint!
    @IBOutlet var mainViewHeight: NSLayoutConstraint!
    var searchArr = [GetDoctorsMessage]()
    var selectedPDF = [UploadDataURL]()
    var model: UserDataModel?
    var isUpdate: Bool?
    var updateData: TblPatientMedicalReport?
    var relationID: Int = 0
    var Delegete: AddMedicalReport?
    let datePicker = UIDatePicker()
    var userImage = [UploadDataa]()
    var doctorsModel: GetDoctorsModel?
    var headers: [String: String] = ["Content-Type": "multipart/form-data","lang": "2"]
    lazy var imageInstance = imagePickerHelper(viewController: self)
    var attachImage: String = ""
    override func viewWillAppear(_ animated: Bool) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.ShadowView(view: searchView, radius: 10, opacity: 0.4, shadowRadius: 4, color: UIColor.lightGray.cgColor)
        searchBar.delegate = self
        searchBar.backgroundColor = .white
        searchBar.layer.borderColor = UIColor.lightGray.cgColor
        searchBar.compatibleSearchTextField.textColor = UIColor.black
        searchBar.compatibleSearchTextField.backgroundColor = UIColor.white
        SetupTextView()
        mainView.ShadowView(view: mainView, radius: 20, opacity: 0.4, shadowRadius: 4, color: UIColor.black.cgColor)
        setData()
        showDatePicker()
        SetUpTableView()
        getDoctors()
        setDoctorsView()
        
    }
    func setDoctorsView(isShow: Bool = true, height: CGFloat = 450, ViewHeight: CGFloat = 0){
        UIView.animate(withDuration: 1) {
            self.searchView.isHidden = isShow
            self.searchTable.isHidden = isShow
            self.mainViewHeight.constant = height
            self.searchViewHeight.constant = ViewHeight
            self.view.layoutIfNeeded()
        }
  
}
    func SetUpTableView(){
        searchTable.register(DoctorsSearchCell.nib, forCellReuseIdentifier: "doctorsCell")
        searchTable.separatorStyle = .none
        searchTable.delegate = self
        searchTable.dataSource = self
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.setDoctorsView()
        }else{
        searchArr = searchText.isEmpty ? doctorsModel?.message ?? []: doctorsModel?.message.filter { (item: (GetDoctorsMessage)) -> Bool in
            return item.employeeName.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            
        } ?? []
            if searchArr.count != 0{
            self.setDoctorsView(isShow: false, height: 600, ViewHeight: 150)
            self.searchTable.reloadData()
            self.view.layoutIfNeeded()
            searchTable.reloadData()
            }else{
                self.setDoctorsView()
            }
        }
    }
    func SetupTextView(){
        notesTxt.text = "notes"
        notesTxt.textColor = UIColor.lightGray
        resultTxt.text = "result"
        resultTxt.textColor = UIColor.lightGray
        notesTxt.delegate = self
        resultTxt.delegate = self
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == notesTxt{
            if textView.text.isEmpty {
                textView.text = "notes"
                textView.textColor = UIColor.lightGray
            }
        }else if textView == resultTxt{
            if textView.text.isEmpty {
                textView.text = "result"
                textView.textColor = UIColor.lightGray
            }
        }
        
    }
    func setData(){
        if isUpdate == true{
            attachImage = updateData?.medicalReportResultFile ?? ""
            self.navigationItem.title = "Edit Medical Reports".localized
            nameTxt.text = updateData?.medicalReportName
            dateTxt.text = updateData?.medicalReportDate
            resultTxt.text = updateData?.medicalReportResult
            notesTxt.text = updateData?.notes
            searchBar.text = updateData?.doctorName
            let image = "\(Constants.baseURLImage)\(updateData?.medicalReportResultFile ?? "")"
            resultImage.kf.setImage(with: URL(string: image),placeholder: UIImage(named: "user"))
        }else{
            self.navigationItem.title = "Add Medical Reports".localized
        }
    }
    @IBAction func addAttachment_Click(_ sender: Any) {
        showChooseMediaActionSheet()
 
        
       
    }
    func showChooseMediaActionSheet(){
        choosePhoto()
    }
    /*
    {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        actionSheet.addAction(UIAlertAction(title: "image", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            
            self.imageInstance.presentImagePicker()
            self.imageInstance.imageSelected = {[weak self] selectedImage in
                guard let self = self else {return}
                self.userImage.append(UploadDataa(data: selectedImage.jpegData(compressionQuality: 0.1)!, Key: "MedicalReportResultFile"))
                self.resultImage.image = selectedImage
                AlamofireMultiPart.PostMultiWithModel(model: SuccessModelImage.self,
                                                      url: "\(Constants.baseURL)Common/FormDataUpload",
                                                      Images: self.userImage ,
                                                      header: self.headers,
                                                      parameters: nil,
                                                      completion: self.ProfileImageNetwork)
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Pdf", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            let importMenu = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF)], in: .import)
            importMenu.delegate = self
            importMenu.modalPresentationStyle = .formSheet
            self.present(importMenu, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true, completion: nil)
    }
    */
    @IBAction func save_CLick(_ sender: Any) {
        validationinput()
    }
    


}
protocol AddMedicalReport {
    func Data(isAdded: Bool)
}
extension AddMedicalReportsVC : UIDocumentMenuDelegate,UIDocumentPickerDelegate,UIDocumentInteractionControllerDelegate {
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        let myURL = url as URL
        selectedPDF.removeAll()
        let uploadPdf = UploadDataURL(data: myURL, name: "attach[]")
        selectedPDF.append(uploadPdf)
        print("import result : \(myURL)")
    }
    
    
    public func documentMenu(_ documentMenu:UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        dismiss(animated: true, completion: nil)
    }
}
extension AddMedicalReportsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "doctorsCell") as! DoctorsSearchCell
        cell.selectionStyle = .none
        cell.nameLbl.text = searchArr[indexPath.row].employeeName
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBar.text = searchArr[indexPath.row].employeeName
       // doctorId = searchArr[indexPath.row].businessProviderEmployeeID
        setDoctorsView()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 25
    }
}
extension AddMedicalReportsVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK:- imagePickerController
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let images = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            self.resultImage.image = images
//            guard let file = images.jpegData(compressionQuality: 0.2) else { return  }
            uploadImage()
//            presenter.uploadImage(file: file)
         }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Choose Photo Actions
    
     func choosePhoto() {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source".localized, message: "Choose Source".localized, preferredStyle: .actionSheet)
        let cameraAction = (UIAlertAction(title: "Camera".localized, style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }else{
                print("Camera not available")
            }
            
        }))
//        let image = UIImage(named: "ic_Error")
//        cameraAction.setValue(image, forKey: "image")
        actionSheet.addAction(cameraAction)
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library".localized, style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
                let image = UIImagePickerController()
                image.delegate = self
                
                image.sourceType = UIImagePickerController.SourceType.photoLibrary
                
                image.allowsEditing = false
                
                self.present(image, animated: true)
            
        })
        actionSheet.addAction(photoLibraryAction)
        actionSheet.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}
