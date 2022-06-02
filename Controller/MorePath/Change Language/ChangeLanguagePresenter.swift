//
//  ChangeLanguagePresenter.swift
//  E4Doctor
//
//  Created by mac on 17/01/2021.
//

import UIKit

class ChangeLanguagePresenter: ChangeLanguagePresenterProtocol, ChangeLanguageInteractorOutputProtocol {
    
    weak var view: ChangeLanguageViewProtocol?
    private let interactor: ChangeLanguageInteractorInputProtocol
    private var router: ChangeLanguageRouterProtocol
    
    
    init(view: ChangeLanguageViewProtocol, interactor: ChangeLanguageInteractorInputProtocol, router: ChangeLanguageRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func fetchedSuccessfuly() {
        view?.hideLoadingIndicator()
        view?.successRequest()
    }
    
    func fetchingFailed(withError error: String) {
         view?.hideLoadingIndicator()
    }
    
    func showMessage(message: String) {
        view?.showMessage(message: message)
    }
     
}
