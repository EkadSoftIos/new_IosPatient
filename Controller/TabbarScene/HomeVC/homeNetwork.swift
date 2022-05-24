//
//  homeNetwork.swift
//  E4 Patient
//
//  Created by mohab on 31/05/2021.
//

import Foundation
extension HomeVC{
    func callApi(){
        showUniversalLoadingView(true)
        NetworkClient.performRequest(_type: HomeModel.self, router: .home) { (result) in
            showUniversalLoadingView(false)
            switch result{
            case .success(let model):
                print(model)
                if model.successtate == 200{
                    print("success home")
                    self.homeResponse = model
                    self.successApi()
                }else{

                }
            case .failure(let model):
                self.showMessage(title: "", sub: "error connecting to server. please try again", type: .error, layout: .messageView)
                print("failure: \(model)")
            
            }
        }
    }
    func successApi(){
        nameLbl.text = "\(homeResponse?.message?.patientFirstName ?? "")" + " " + "\(homeResponse?.message?.patientLastName ?? "")"
        if let lastVisit = homeResponse?.message?.lastVisitDate?.components(separatedBy: "T") {
            
//            lastVisitLbl.text = lastVisit[0]
            lastVisitLbl.text = GetFormatedDate(date_string: lastVisit[0], dateFormat: "yyyy-MM-dd")
        }
        
        let image = "\(Constants.baseURLImage)\(homeResponse?.message?.patientProfileImage ?? "")"
        userIMG.kf.setImage(with: URL(string: image),placeholder: UIImage(named: "ProfileImage"))
        self.pagerSlider.reloadData()
        self.SpecializationsCollection.reloadData()
        self.topDoctorCollection.reloadData()
    }
    func GetFormatedDate(date_string:String,dateFormat:String)-> String{

       let dateFormatter = DateFormatter()
       dateFormatter.locale = Locale(identifier: "en_US_POSIX")
       dateFormatter.dateFormat = dateFormat

       let dateFromInputString = dateFormatter.date(from: date_string)
       dateFormatter.dateFormat = "MMM dd,yyyy"
       if(dateFromInputString != nil){
           return dateFormatter.string(from: dateFromInputString!)
       }
       else{
           debugPrint("could not convert date")
           return ""
       }
   }
}
