//
//  ChangeLanguageRouter.swift
//  E4Doctor
//
//  Created by mac on 17/01/2021.
//

import UIKit
 
class ChangeLanguageRouter: ChangeLanguageRouterProtocol { //Router is only one take dicret instance
    

    weak var viewController: UIViewController?
    
//    func goTo() -> UIViewController {
//        let view = UIStoryboard(name: Helper.storyboardName.auth.rawValue, bundle: nil).instantiateViewController(withIdentifier: "\( .self)") as!
//        let interactor =  Interactor()
//        let router =  Router()
//        let presenter =  Presenter(view: view, interactor: interactor, router: router)
//        view.presenter = presenter
//        view.modalPresentationStyle = .fullScreen
//        interactor.presenter = presenter
//        router.viewController = view
//        return view
//    }

}
