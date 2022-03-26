//
//  AllEmergencyContactsNetwork.swift
//  E4 Patient
//
//  Created by mohab on 06/03/2021.
//

import Foundation
extension AllEmergencyContactsVC{
    func callApiAdd(){
        showUniversalLoadingView(true)
        NetworkClient.performRequest(_type: UserDataModel.self, router: .profile) { (result) in
            showUniversalLoadingView(false)
            switch result{
            case .success(let model):
                print("\(model)")
                self.model = model
                self.success()
            case .failure(let model):
              print(model)
            }
        }
    }
    func callApiDelete(Id: Int){
        showUniversalLoadingView(true)
        let parameters: [String: Any] = [
            "PatientContactId": Id
          ]
        NetworkClient.performRequest(_type: SuccessModel.self, router: .DeleteContact(params: parameters)) { (result) in
            showUniversalLoadingView(false)
            switch result{
            case .success(let model):
                if model.successtate == 200{
                    self.showMessage(title: "", sub: model.message, type: .success, layout: .messageView)
                    self.success()
                }else{
                    self.showMessage(title: "", sub: model.errormessage, type: .error, layout: .messageView)
                }
            case .failure(let model):
                print("failure: \(model)")
            
            }
        }
    }
    func success(){
        self.EmergencyTableView.reloadData()
      
    }
    
}
