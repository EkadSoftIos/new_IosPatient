//
//  AddMedicalReportsPicker.swift
//  E4 Patient
//
//  Created by mohab on 13/03/2021.
//

import UIKit
extension AddMedicalReportsVC {
    
    //MARK:-date picker
    func showDatePicker(){
//        if #available(iOS 14.0, *)
//        {
//            datePicker.preferredDatePickerStyle = .wheels
//        }
        //Formate Date
//        datePicker.datePickerMode = .date
//
//        //ToolBar
//        let toolbar = UIToolbar();
//        toolbar.sizeToFit()
//        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
//        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
//        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
//
//        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
//
//        dateTxt.inputAccessoryView = toolbar
//        dateTxt.inputView = datePicker
        
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .date
        dateTxt.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)

        
    }
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: sender.date)
        dateTxt.text = date
//        self.view.endEditing(true)
//        dateFrom = date
//        self.delegate?.sendDate(fDate: dateFrom ?? "", tDate: dateTo ?? "")
    }
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dateTxt.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    func uploadImage(){
//        imageInstance.presentImagePicker()
//        imageInstance.imageSelected = {[weak self] selectedImage in
//            guard let self = self else {return}
//            self.profileImage.image = selectedImage
        self.userImage.append(UploadDataa(data: (self.resultImage.image?.jpegData(compressionQuality: 0.1)!)!, Key: "personal_image"))
            AlamofireMultiPart.PostMultiWithModel(model: SuccessModelImage.self,
                                                  url: "\(Constants.baseURL)Common/FormDataUpload",
                                                  Images: self.userImage ,
                                                  header: self.headers,
                                                  parameters: nil,
                                                  completion: self.ProfileImageNetwork)
        
    }
//    func uploadFiles(_ urlPath: [URL]){
//
//    if let url = URL(string: "Common/FormDataUpload"){
//    var request = URLRequest(url: url)
//    let boundary:String = "Boundary-\(UUID().uuidString)"
//
//    request.httpMethod = "POST"
//    request.timeoutInterval = 10
//    request.allHTTPHeaderFields = ["Content-Type": "multipart/form-data; boundary=----\(boundary)"]
//
//        for path in urlPath{
//            do{
//                var data2: Data = Data()
//                var dataa: Data = Data()
//                data2 = try NSData.init(contentsOf: URL.init(fileURLWithPath: path.absoluteString, isDirectory: true)) as Data
//                dataa.append("------\(boundary)\r\n")
//                //Here you have to change the Content-Type
//                dataa.append("Content-Disposition: form-data; name=\"file\"; filename=\"YourFileName\"\r\n")
//                dataa.append("Content-Type: application/YourType\r\n\r\n")
//                dataa.append(data2)
//                dataa.append("\r\n")
//                dataa.append("------\(boundary)--")
//
//                request.httpBody = dataa
//            }catch let err{
//                //Your errors
//                showMessage(message: err.localizedDescription, messageKind: .error)
//            }
//            DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).sync {
//                let session = URLSession.shared
//                let task = session.dataTask(with: request, completionHandler: { (dataS, aResponse, error) in
//                    if let erros = error{
//                        //Your errors
//                        print(erros)
//                    }else{
//                        do{
//                            let responseObj = try JSONSerialization.jsonObject(with: dataS!, options: JSONSerialization.ReadingOptions(rawValue:0)) as! [String:Any]
//                            print(responseObj)
//
//                        }catch let err{
//                            print(err)
//                        }
//                    }
//                }).resume()
//            }
//        }
//    }
//    }
}
