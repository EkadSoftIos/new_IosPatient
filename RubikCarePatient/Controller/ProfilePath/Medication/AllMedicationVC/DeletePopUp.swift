//
//  LogOutVC.swift
//  E4Doctor
//
//  Created by mac on 17/01/2021.
//

import UIKit
 
class DeletePopUp: UIViewController, LogOutViewProtocol {
    
    //MARK: - IBOutlets
    
    
    //MARK: - Properties
    var presenter: LogOutPresenterProtocol!
    var cellId = 0
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        }
    }
    
    func showLoadingIndicator() {
//        showLoader()
    }
    
    func hideLoadingIndicator() {
//        hideLoader()
    }
    
    func successRequest() {
        
    }
    
    func showMessage(message: String) {
        
    }
    
    //MARK: - IBOutlets
    @IBAction
    func didTappedCancel(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction
    func didTappedLogout(_ sender: UIButton) {
        
    callApi()
//        let view = presenter.goToLoginVC()
//        self.present(view, animated: true, completion: nil)
    }
    func callApi(){
        let deviceId = UIDevice.current.identifierForVendor!.uuidString
        let parameters: [String: Any] = [
            "Decvice_id": deviceId,
            "Device_token": UserDefaults.standard.string(forKey: "token") ?? ""
          ]
        
        NetworkClient.performRequest(_type: LogoutModel.self, router: .logout(params: parameters)) { (result) in
            switch result{
            case .success(let model):
                print(model)
                if model.successtate == 200{
                    
                    UserDefaults.standard.set(nil, forKey: "token")
                    let vc = LoginVC()
                    vc.modalTransitionStyle = .coverVertical
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }else{
                    self.showMessage(title: "", sub: model.errormessage, type: .error, layout: .messageView)
                    UserDefaults.standard.set(nil, forKey: "token")
                    let vc = LoginVC()
                    vc.modalTransitionStyle = .coverVertical
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)

//                    self.loginBtn.stopAnimation()
                }
            case .failure(let model):
//                self.loginBtn.stopAnimation()
                self.showMessage(title: "", sub: "error connecting to server. please try again", type: .error, layout: .messageView)
                print("failure: \(model)")
            
            }
        }
    }
}

//MARK: Setup View
extension LogOutVC {
    
     fileprivate func setupUI() {
        
     }
}

 
