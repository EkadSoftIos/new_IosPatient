//
//  AdrressNetworking.swift
//  E4 Patient
//
//  Created by mohab on 26/02/2021.
//

import Foundation

extension AllAdressVC{
    func callApiAdd(){
        //showUniversalLoadingView(true)
        NetworkClient.performRequest(_type: UserDataModel.self, router: .profile) { (result) in
            showUniversalLoadingView(false)
            switch result{
            case .success(let model):
                print("\(model)")
                self.model = model
                self.setData()
                self.EmptyTable()
            case .failure(let model):
              print(model)
            }
        }
    }

    func setData(){
        self.adressTableView.reloadData()
    }


}
