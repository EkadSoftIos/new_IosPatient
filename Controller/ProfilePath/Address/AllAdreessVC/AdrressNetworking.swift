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
    func callApiDelete(id: Int){
        showUniversalLoadingView(true)
        
        let parameters: [String: Any] = [
            "PatientAddressId": id
          ]
        NetworkClient.performRequest(_type: SuccessModel.self, router: .deleteAdress(params: parameters)) {[weak self] (result) in
            guard let self = self else {return}
            showUniversalLoadingView(false)
            switch result{
            case .success(let model):
                if model.successtate == 200 {
                    self.callApiAdd()
                }
                else{
                    self.showAlertWith(msg: model.errormessage)
                }
            case .failure(let model):
              print(model)
            }
        }
    }

}
