//
//  MoreVC.swift
//  E4 Patient
//
//  Created by mohab on 17/01/2021.
//

import UIKit

class MoreVC: UIViewController {
    @IBOutlet var moreTableView: UITableView!
    let moreArr = [("My Profile".localized,AppImages.profile),("My Wallet",AppImages.myWallet),("My Favorite ",AppImages.myFavorite),("My Cart",AppImages.myCart),("My Order ",AppImages.myOrder),("Medicine Reminder ",AppImages.MmdicinemReminder),("Appointment History",AppImages.appointmentHistory),("Consultations Log",AppImages.consultationsLog),("Reports",AppImages.Reports),("Profile Permission",AppImages.ProfilePermission),("Emergency Number",AppImages.EmergencyNumber),("Change Password",AppImages.ChangePassword),("Help & Support",AppImages.HelpSupport),("Privacy Policy & Terms of use",AppImages.HelpSupport),("Contact Us",AppImages.HelpSupport),("FAQ",AppImages.HelpSupport),("Language",AppImages.Language),("Log Out",AppImages.LogOut)]
    var userData: UserDataModel?
    var adressModel: GetFullCitiesModel?
    override func viewWillAppear(_ animated: Bool) {
        callApi()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        self.navigationItem.title = "More".localized
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColor.Blue]
    }
     override func viewWillDisappear(_ animated: Bool) {
        
    }
    func setupTableView(){
        moreTableView.register(MoreCell.nib, forCellReuseIdentifier: "moreCell")
        moreTableView.delegate = self
        moreTableView.dataSource = self
    }
    func callApi(){
        showUniversalLoadingView(true)
        NetworkClient.performRequest(_type: UserDataModel.self, router: .profile) { (result) in
            showUniversalLoadingView(false)
            switch result{
            
            case .success(let model):
                if model.successtate == 200 {
                    print("\(model)")
                    self.userData = model
                    
                }else{
                    self.showMessage(sub: model.errormessage)
                }
            case .failure(let model):
                print(model)
                self.showMessage(title: "", sub: "error connecting to server. please try again", type: .error, layout: .messageView)
            }
        }
    }
    func getCountries() {
        NetworkClient.performRequest(_type: GetFullCitiesModel.self, router: .getAllCountries) { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(let model) :
                if model.successtate == 200 {
                    self.adressModel = model
                }
                else{
                    self.showAlertWith(msg: model.errormessage ?? "")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
}
