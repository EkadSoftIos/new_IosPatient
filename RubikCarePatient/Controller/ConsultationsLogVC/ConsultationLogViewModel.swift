//
//  ConsultationLogViewModel.swift
//  E4 Patient
//
//  Created by Nada on 9/1/21.
//

import Foundation

class ConsultationLogViewModel {
    
    var consultationData = [ConsultationLogData]()
    var filteredConsultationData = [ConsultationLogData]()
    let showError = Observable<String>(value: "")
    let isLoading = Observable<Bool>(value: false)
    let reloadTableView = Observable<Bool>(value: false)
    
    func getConsultation(bookingStatus: [Int], fromDate: String?, toDate: String?, consultationFK: Int?) {
        self.isLoading.value = true
        var para: [String: Any] =
        [
            "BookingStatus": bookingStatus
        ]
        if fromDate != nil && toDate != nil {
            para["datefrom"] = fromDate
            para["dateto"] = toDate
        }
        if consultationFK != nil {
            para["ConsultationServiceFk"] = consultationFK
        }
        NetworkClient.performRequest(_type: ConsultationLogModel.self, router: APIRouter.consultationLog(parameters: para)) {[weak self] (result) in
            guard let self = self else {return}
            self.isLoading.value = false
            switch result {
            case.success(let data):
                if data.successtate == 200 {
                    self.consultationData = data.message ?? []
                    self.filteredConsultationData = self.consultationData
                    self.reloadTableView.value = true
                } else {
                    self.showError.value = "Error occured"
                }
            case.failure(let err):
                print(err)
                self.showError.value = err.localizedDescription
            }
        }
    }
}
