//
//  homeNetwork.swift
//  E4 Patient
//
//  Created by mohab on 31/05/2021.
//

import Foundation
extension AppointmentVC{
    func callApi(date: String){
        var parameters: [String: Any]
        let patientID = UserDefaults.standard.string(forKey: "patientId") ?? ""
        if isHistory == true {
            if fromFilter {
                if consultationServiceFk == 0 {
                    parameters = [
                        "BookingStatus":AppointmentStatus,
                        "PatientFk": patientID
                    ]
                }else{
                    parameters = [
                        "BookingStatus":AppointmentStatus,
                        "ConsultationServiceFk": consultationServiceFk,
                        "PatientFk": patientID
                    ]
                }
                
            }else{
                parameters = [
                    "BookingStatus":[3,4,5,6],
                    "PatientFk": patientID
            ]
            }
            
        }else{
            if fromFilter {
                if consultationServiceFk == 0 {
                    parameters = [
                        "BookingStatus":AppointmentStatus,
                        "PatientFk": patientID
                    ]
                }else{
                    parameters = [
                        "BookingStatus":AppointmentStatus,
                        "ConsultationServiceFk": consultationServiceFk,
                        "PatientFk": patientID
                    ]
                }
                
            }else{
                parameters = [
                    "BookingStatus":[0,1,2],
                    "PatientFk": patientID
                ]
            }
            
        }
        parameters["datefrom"] = date
        parameters["dateto"] = date
        
        print(parameters)
        
        showUniversalLoadingView(true)
        NetworkClient.performRequest(_type: AppointmentHistoryModel.self, router: .AppointmentHistory(params: parameters)) { (result) in
            showUniversalLoadingView(false)
            switch result{
            case .success(let model):
                print(model.message?.count)
                if model.successtate == 200{
                    print("success home")
                    self.appointmentResponse = model
                    self.newAppointmentResponse = model
                    self.appointmentMessage = model.message
                    self.successAppointmentApi()
                }else{

                }
            case .failure(let model):
                self.showMessage(title: "", sub: "error connecting to server. please try again", type: .error, layout: .messageView)
                print("failure: \(model)")
            
            }
        }
    }
    func successAppointmentApi(){
        appointmentTableView.reloadData()
    }
    @objc func cancelAppointement(sender: UIButton) {
        let bookingId = appointmentResponse?.message?[sender.tag].bookingId ?? 0
        let para = ["BookingId": bookingId]
        showUniversalLoadingView(true)
        NetworkClient.performRequest(_type: CancelAppointementModel.self, router: .cancelAppointment(params: para)) { (result) in
            switch result {
            case.success(let data):
                if data.successtate == 200 {
                    self.callApi(date: self.date)
                } else {
                    self.showMessage(title: "", sub: "error connecting to server. please try again", type: .error, layout: .messageView)
                }
            case.failure(let err):
                print(err)
                self.showMessage(title: "", sub: "error connecting to server. please try again", type: .error, layout: .messageView)
            }
        }
    }
}
