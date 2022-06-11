//
//  LogOutPresenter.swift
//  E4Doctor
//
//  Created by mac on 17/01/2021.
//

import UIKit

class LogOutPresenter: LogOutPresenterProtocol, LogOutInteractorOutputProtocol {
    
    weak var view: LogOutViewProtocol?
    private let interactor: LogOutInteractorInputProtocol
    private var router: LogOutRouterProtocol
    
    
    init(view: LogOutViewProtocol, interactor: LogOutInteractorInputProtocol, router: LogOutRouterProtocol) {
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
    
    func goToLoginVC() -> UIViewController {
        return router.goToLoginVC()
    }
     
}
