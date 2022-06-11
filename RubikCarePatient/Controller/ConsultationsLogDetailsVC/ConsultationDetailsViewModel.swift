//
//  ConsultationDetailsViewModel.swift
//  E4 Patient
//
//  Created by Nada on 9/5/21.
//

import Foundation

class ConsultationsDetailsViewModel {
    
    var consultationDetailsData: ConsultationDetailsData?
    let showError = Observable<String>(value: "")
    let isLoading = Observable<Bool>(value: false)
    let reloadTableView = Observable<Bool>(value: false)
    
    func getConsultationDetails(id: Int) {
        self.isLoading.value = true
        NetworkClient.performRequest(_type: ConsultationDetailsModel.self, router: APIRouter.consultationDetails(id: id)) {[weak self] (result) in
            guard let self = self else {return}
            self.isLoading.value = false
            switch result {
            case.success(let data):
                print(data)
                self.consultationDetailsData = data.message
                self.reloadTableView.value = true
            case.failure(let err):
                print(err)
                self.showError.value = err.localizedDescription
            }
        }
    }
}
