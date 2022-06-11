//
//  homeNetwork.swift
//  E4 Patient
//
//  Created by mohab on 31/05/2021.
//

import Foundation
extension MyFavoriteVC {
    func callApi(){
        
        showUniversalLoadingView(true)
        NetworkClient.performRequest(_type: FavouriteDoctorBaseJson.self, router: .GetFavouriteDoctor) { (result) in
            showUniversalLoadingView(false)
            switch result{
            case .success(let model):
                print(model)
                if model.successtate == 200{
                    print("success home")
                    self.favModel = model.message
                }else{

                }
            case .failure(let model):
                self.showMessage(title: "", sub: "error connecting to server. please try again", type: .error, layout: .messageView)
                print("failure: \(model)")
            
            }
        }
    }
    
    func callRemoveFromFavApi(){
        
        showUniversalLoadingView(true)
        NetworkClient.performRequest(_type: RegisterModel.self, router: .RemoveFavouriteDoctor(id: doctorID)) { (result) in
            showUniversalLoadingView(false)
            switch result{
            case .success(let model):
                print(model)
                if model.successtate == 200{
                    print("success home")
                    self.showMessage(title: "", sub: "Doctor has been removed from favorites list".localized, type: .error, layout: .messageView)
                    //
                    self.addedSuccess = model.message ?? ""
                }else{

                }
            case .failure(let model):
                self.showMessage(title: "", sub: "error connecting to server. please try again", type: .error, layout: .messageView)
                print("failure: \(model)")
            
            }
        }
    }
}
