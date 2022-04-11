//
//  ProfileNetwork.swift
//  E4 Patient
//
//  Created by mohab on 25/02/2021.
//

import Foundation
import UIKit
extension ProfileVC{
    func callApi(){
       // showUniversalLoadingView(true)
        NetworkClient.performRequest(_type: UserDataModel.self, router: .profile) { (result) in
            showUniversalLoadingView(false)
            switch result{
            
            case .success(let model):
                if model.successtate == 200 {
                    print("\(model)")
                    self.userData = model
                    self.setData()
                }else{
                    self.showMessage(sub: model.errormessage)
                }
            case .failure(let model):
                print(model)
                self.showMessage(title: "", sub: "error connecting to server. please try again", type: .error, layout: .messageView)
            }
        }
    }
    func setData(){
        self.profileTableView.reloadData()
        let model = userData?.message
        nameLbl.text = "\(userData?.message?.patientFirstName ?? "")" + " \(userData?.message?.patientLastName ?? "")"
        
        let image = "\(Constants.baseURLImage)\(model?.patientProfileImage ?? "")"
        print("image: \(image)")
        userImage.kf.setImage(with: URL(string: (image)),placeholder: UIImage(named: "profile"))
        Animation.roundView(userImage)
        patientIDLbl.text = "patient ID \("\(model?.patientID ?? 0)")"
      //  joinAtLbl.text = "joined \(model?.createDate ?? "")"
        //self.custoomizeDate()
        progressLBl.text = "\(model?.profilePercentage ?? "" ) %"
        
        let Percentage = Int(model?.profilePercentage ?? "")
        let resultProgress = Float(Percentage ?? 0) / 100.0
        progressView.progress = resultProgress
        let milisecond = model?.createDate ?? ""
       //let date = self.GetFormatedDate(date_string: milisecond, dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS")
        joinAtLbl.text = "joined " + convertDateFormat(inputDate: milisecond)
        //let dateVar = Date.init(timeIntervalSinceNow: TimeInterval(milisecond) ?? 0/1000)
  
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

