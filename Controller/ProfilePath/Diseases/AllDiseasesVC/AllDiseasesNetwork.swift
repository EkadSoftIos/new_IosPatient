//
//  AllDiseasesNetwork.swift
//  E4 Patient
//
//  Created by mohab on 27/02/2021.
//

import UIKit
extension AllDiseasesVC{
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
        
        NetworkClient.performRequest(_type: SuccessModel.self, router: .deleteDieses(Id: Id)) { (result) in
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
        setEmptyTableView()
        self.dieseasesTableView.reloadData()
      
    }

}
