//
//  TabBarVC.swift
//  E4 Patient
//
//  Created by mohab on 17/01/2021.
//

import UIKit
class BadgedButtonItem: UIBarButtonItem {
    var notificationCount = 0
    var notificationlabel = UILabel()
    var tapAction: (() -> Void)?
    
    public func setBadge(with value: Int) {
            self.badgeValue = value
        }

        private var badgeValue: Int? {
            didSet {
                if let value = badgeValue,
                    value > 0 {
                    notificationlabel.isHidden = false
                    notificationlabel.text = "\(value)"
                } else {
                    notificationlabel.isHidden = true
                }
            }
        }
    init(with image: UIImage?) {
            super.init()
        getNotificationCount()
            setup(image: image)
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setup()
        }
    func getNotificationCount() {
        NetworkClient.performRequest(_type: NotificationCountModel.self, router: APIRouter.notificationCount) {[weak self] (result) in
            guard let self = self else {return}
            switch result {
            case.success(let data):
                self.notificationCount = data.message ?? 0
                self.badgeValue = data.message ?? 0
                self.notificationlabel.text = String(self.notificationCount)
            case.failure(let err):
                print(err)
            }
        }
    }
    @objc func NotificationButtonTouched() {
        if let action = tapAction {
                    action()
                }
    }
    
    private func setup(image: UIImage? = nil) {
        let imagek = AppImages.BarLogo
        let imageView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageView.image = imagek
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        let barButton = UIBarButtonItem(image: imagek, landscapeImagePhone: nil, style: .done, target: self, action: nil)
        barButton.isEnabled = false
        
//        VC.navigationItem.leftBarButtonItem = barButton
        
//        let imageN = AppImages.notLogo
//        let imageViewN = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
//        imageViewN.image = imageN
//        imageViewN.contentMode = .scaleToFill
//        imageViewN.layer.cornerRadius = 8
//        imageViewN.layer.masksToBounds = true
        let barButtonN = UIButton()
        barButtonN.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        barButtonN.adjustsImageWhenHighlighted = false
        barButtonN.setImage(AppImages.notLogo, for: .normal)
        barButtonN.addTarget(self, action: #selector(NotificationButtonTouched), for: .touchUpInside)
        self.notificationlabel.frame = CGRect(x: 20, y: 0, width: 15, height: 15)
        self.notificationlabel.backgroundColor = .red
        self.notificationlabel.clipsToBounds = true
        self.notificationlabel.layer.cornerRadius = 7
        self.notificationlabel.textColor = UIColor.white
        self.notificationlabel.font = UIFont.systemFont(ofSize: 10)
        self.notificationlabel.textAlignment = .center
        self.notificationlabel.isHidden = true
        self.notificationlabel.minimumScaleFactor = 0.1
        self.notificationlabel.adjustsFontSizeToFitWidth = true
        barButtonN.addSubview(notificationlabel)
        self.customView = barButtonN
//        let barButtonN = UIBarButtonItem(image: imageN, landscapeImagePhone: nil, style: .done, target: self, action: #selector(NotificationButtonTouched))
        barButtonN.isEnabled = true
        
//        VC.navigationItem.rightBarButtonItem = barButtonN
        
        
       // setNavButtons()
    }
}
class TabbarManager: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabbar()
    }
    
    func setupTabbar(){
        let home = HomeVC()
        home.tabBarItem = UITabBarItem(title: AppString.TabHome,
                                       image:  AppImages.Home,
                                       selectedImage: AppImages.HomeSelected)
//        setLogo(VC: home)

        let Appointment = AppointmentVC()
        Appointment.tabBarItem = UITabBarItem(title: AppString.Appointment,
                                           image: AppImages.Appointment,
                                           selectedImage: AppImages.AppointmentSelected)
//        setLogo(VC: Appointment)
        let Pharmacy = PharmacyVC()
        Pharmacy.tabBarItem = UITabBarItem(title: AppString.Pharmacy,
                                               image: AppImages.Pharmacy,
                                               selectedImage: AppImages.PharmacySelected)
//        setLogo(VC: Pharmacy)
        let Blog = BlogVC()
        Blog.tabBarItem = UITabBarItem(title: AppString.Club,
                                               image: AppImages.Blog,
                                               selectedImage: AppImages.BlogSelected)
//        setLogo(VC: Blog)
        let More = MoreVC()
        More.tabBarItem = UITabBarItem(title: AppString.More,
                                          image: AppImages.More,
                                          selectedImage: AppImages.MoreSelected)
//        setLogo(VC: More)
        
        
        viewControllers = [setNav(VC: home),
                           setNav(VC: Appointment),
                           setNav(VC: Pharmacy),
                           setNav(VC: Blog),
                           setNav(VC: More)]
    }
    

    
}
extension TabbarManager {
   
    func setNav(VC : UIViewController) -> UINavigationController {
        
        let Nav = UINavigationController.init(rootViewController: VC)
        //===titleLogoView===
        /*  let imagek = AppImages.whiteLogo?.resizeImage(newSize: CGSize.init(width: 150, height: 40))
         let imageView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
         imageView.image = imagek
         imageView.contentMode = .scaleAspectFit
         VC.navigationItem.titleView = imageView*/
        
        return Nav
    }
    
    
}
extension UITabBar {
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        guard let window = UIApplication.shared.keyWindow else {
            return super.sizeThatFits(size)
        }
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = window.safeAreaInsets.bottom + 50
        return sizeThatFits
    }
}



