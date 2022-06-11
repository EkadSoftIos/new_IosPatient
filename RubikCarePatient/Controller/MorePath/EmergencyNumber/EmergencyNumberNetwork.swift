//
//  EmergencyNumberNetwork.swift
//  E4 Patient
//
//  Created by mohab on 14/03/2021.
//

import Foundation
extension EmergencyNumberVC{
func callApi(){
    showUniversalLoadingView(true)
    NetworkClient.performRequest(_type: GetEmergencyModel.self, router: .getEmergency) { (result) in
        showUniversalLoadingView(false)
        switch result{
        
        case .success(let model):
            if model.successtate == 200 {
                self.model = model
                self.emergencyTable.reloadData()
            }else{
                self.showMessage(sub: model.errormessage)
            }
        case .failure(let model):
            print(model)
            self.showMessage(title: "", sub: "error connecting to server. please try again", type: .error, layout: .messageView)
        }
    }
}
}
