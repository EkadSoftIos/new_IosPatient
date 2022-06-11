//
//  LogOut.swift
//  E4Doctor
//
//  Created by mac on 17/01/2021.
//

import UIKit

protocol LogOutViewProtocol: class { //View Conteroller
    var presenter: LogOutPresenterProtocol! { get set }
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func successRequest()
    func showMessage(message: String)
}

protocol LogOutPresenterProtocol: class { // Logic
    var view: LogOutViewProtocol? { get set }
    func goToLoginVC() -> UIViewController 
}

protocol LogOutInteractorInputProtocol: class { // func do it from presenter
     var presenter: LogOutInteractorOutputProtocol? { get set }
    
}

protocol LogOutInteractorOutputProtocol: class { // it's will call when interactor finished
    func fetchedSuccessfuly()
    func fetchingFailed(withError error: String)
    func showMessage(message: String)
}

protocol LogOutRouterProtocol { // For Segue
    func goToLoginVC() -> UIViewController
}
