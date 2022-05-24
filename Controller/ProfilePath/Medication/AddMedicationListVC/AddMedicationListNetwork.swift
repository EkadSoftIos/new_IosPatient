//
//  AddMedicationListNetwork.swift
//  E4 Patient
//
//  Created by mohab on 06/03/2021.
//

import Foundation
extension AddMedicationListVC{
    func callApi(){
        showUniversalLoadingView(true)
        NetworkClient.performRequest(_type: getAllMedicineModel.self, router: .getAllMedicine) { (result) in
            showUniversalLoadingView(false)
            switch result{
            case .success(let model):
                print("\(model)")
                
                self.model = model
                self.successCallApi()
            case .failure(let model):
              print(model)
            }
        }
    }
    func successCallApi(){

        self.medicationTableView.reloadData()
        self.medicationCollectionView.reloadData()
    }
}
