//
//  homeNetwork.swift
//  E4 Patient
//
//  Created by mohab on 31/05/2021.
//

import Foundation
extension WriteReviewsVC{
    func callApi(){
        let parameters: [String: Any]
//        let patientID = UserDefaults.standard.string(forKey: "patientId")
//        print(patientID)
        parameters = [
            "AssistantRate":ratingAssistantValue,
            "BookingFk": bookingFK,
            "ClinicRate": ratingClinicValue,
            "DoctorFk":doctorFK,
            "DoctorRate": ratingDoctorValue,
            "PatientNote":writeReviewTXT.text ?? ""
//            "PatientReviewId":patientID
        ]
        print(parameters)
        showUniversalLoadingView(true)
        NetworkClient.performRequest(_type: RegisterModel.self, router: .AppointmentReview(params: parameters)) { (result) in
            showUniversalLoadingView(false)
            switch result{
            case .success(let model):
                print(model)
                if model.successtate == 200{
                    print("success home")
                    self.successRateSent = model.message ?? ""
                }else{

                }
            case .failure(let model):
                self.showMessage(title: "", sub: "error connecting to server. please try again", type: .error, layout: .messageView)
                print("failure: \(model)")
            
            }
        }
    }
    
}
