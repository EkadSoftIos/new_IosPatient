//
//  homeNetwork.swift
//  E4 Patient
//
//  Created by mohab on 31/05/2021.
//

import Foundation
extension AppointmentDetailsCancelVC{
    func callApi(bookingID: Int){
        showUniversalLoadingView(true)
        NetworkClient.performRequest(_type: AppointmentDetailsBase.self, router: .AppointmentsDetailsCancel(bookingid: bookingID)) { (result) in
            showUniversalLoadingView(false)
            switch result{
            case .success(let model):
                print(model)
                if model.successtate == 200{
                    print("success home")
                    self.appointmentDetailsResponse = model.message
                }else{

                }
            case .failure(let model):
                self.showMessage(title: "", sub: "error connecting to server. please try again", type: .error, layout: .messageView)
                print("failure: \(model)")
            
            }
        }
    }
    
}





































































































































































































































