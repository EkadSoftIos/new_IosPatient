//
//  DoctorProfileViewModel.swift
//  E4 Patient
//
//  Created by Nada on 8/20/21.
//

import Foundation

class DoctorProfileViewModel {
    
    var doctorData: DoctorByIdData?
    var branchList = [ServiceList]()
    var homeVisit = [ServiceList]()
    var videoCallList = [ServiceList]()
    
    let showError = Observable<String>(value: "")
    let isLoading = Observable<Bool>(value: false)
    let reloadDoctorData = Observable<Bool>(value: false)
    
    func getDoctordata(id: Int) {
        self.isLoading.value = true
        NetworkClient.performRequest(_type: DoctorByIdModel.self, router: APIRouter.doctorById(id: id)) {[weak self] (result) in
            guard let self = self else {return}
            self.isLoading.value = false
            switch result {
            case.success(let data):
                self.doctorData = data.message
                if data.message?.serviceList?.count != 0 && data.message?.serviceList != nil{
                    for data in (data.message?.serviceList)! {
                        if data.consultationServiceFk == 1 {
                            self.branchList.append(data)
                        } else if data.consultationServiceFk == 2 {
                            self.videoCallList.append(data)
                        } else if  data.consultationServiceFk == 3 {
                            self.homeVisit.append(data)
                        }
                    }
                }
                self.reloadDoctorData.value = true
            case.failure(let err):
                print(err)
                self.showError.value = err.localizedDescription
            }
        }
    }
    
}
