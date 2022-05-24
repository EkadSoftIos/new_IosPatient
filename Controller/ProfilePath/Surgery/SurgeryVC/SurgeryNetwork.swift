//
//  SurgeryNetwork.swift
//  E4 Patient
//
//  Created by mohab on 06/03/2021.
//

import Foundation
extension SurgeryVC{
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

    func success(){
        emptyTable()
        self.sugaryTable.reloadData()
      
    }


}

