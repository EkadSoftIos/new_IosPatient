//
//  ChangeLanguage.swift
//  E4Doctor
//
//  Created by mac on 17/01/2021.
//

import UIKit

protocol ChangeLanguageViewProtocol: class { //View Conteroller
    var presenter: ChangeLanguagePresenterProtocol! { get set }
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func successRequest()
    func showMessage(message: String)
}

protocol ChangeLanguagePresenterProtocol: class { // Logic
    var view: ChangeLanguageViewProtocol? { get set }
     
}

protocol ChangeLanguageInteractorInputProtocol: class { // func do it from presenter
     var presenter: ChangeLanguageInteractorOutputProtocol? { get set }
    
}

protocol ChangeLanguageInteractorOutputProtocol: class { // it's will call when interactor finished
    func fetchedSuccessfuly()
    func fetchingFailed(withError error: String)
    func showMessage(message: String)
}

protocol ChangeLanguageRouterProtocol { // For Segue
     
}
